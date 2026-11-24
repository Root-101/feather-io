import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:http/http.dart' as http;
import 'package:service/feather.dart';
import 'package:test/test.dart';

const String testAccess = 'test_access';
// Long enough not to trigger the start-up warning about short secrets
const String testSecret = 'test_secret_key_1';

/// The whole service for a test file: the real filters, security and routes,
/// its own folder in `./uploads_test/<name>` and an in-memory SQLite database
/// (or, with [fileDatabase], the real one inside that folder).
///
/// Served in memory by `WinterTestClient` (no port: files run in parallel),
/// and through [client] tests keep using `package:http`. With a [port] it is
/// served on a real socket instead, for what needs one: a raw socket, a body
/// that never ends, the address the server listens on. Each of those files
/// uses its own port.
class TestApp {
  final String name;
  final int? port;
  final String storagePath;
  final bool fileDatabase;

  /// JWT obtained in [start] with the test credentials.
  late final String token;

  /// Sends the requests of the tests: to the pipeline in memory, or to the
  /// socket with a [port].
  late final http.Client client;

  late final FeatherApp _app;

  TestApp({required this.name, this.port, this.fileDatabase = false})
    : storagePath = './uploads_test/$name';

  /// The JWT secret of this file (32 characters or more).
  String get jwtSecret => 'test-jwt-secret-of-the-tests-$name';

  /// What the requests carry in `Host` (and SigV4 signs).
  String get host => port == null ? 'localhost' : 'localhost:$port';

  Future<void> start() async {
    env.put('FEATHER_ACCESS', testAccess);
    env.put('FEATHER_SECRET', testSecret);
    env.put('JWT_SECRET', jwtSecret);
    env.put('KEYS_ENCRYPTION_SECRET', 'test-keys-encryption-secret-$name');
    env.put('STORAGE_VOLUME_PATH', storagePath);
    // Only problems: every request would otherwise write two lines
    env.put('LOG_LEVEL', 'warning');

    await _deleteStorage();
    _app = await FeatherIO.setUp(
      database: fileDatabase ? null : AppDatabase(NativeDatabase.memory()),
    );
    if (port == null) {
      // What Winter.start does: the storage cleanup runs once at start
      _app.scheduler.start();
      client = _InMemoryClient(
        WinterTestClient.build(
          router: _app.router,
          globalFilterConfig: _app.filters,
          securityConfig: _app.security,
          maxBodySize: _app.maxBodySize,
          trustedProxies: _app.trustedProxies,
        ).handler,
      );
    } else {
      await Winter.start(
        config: ServerConfig(
          host: env.host,
          port: port!,
          maxBodySize: _app.maxBodySize,
          trustedProxies: _app.trustedProxies,
          handleSignals: false,
        ),
        globalFilterConfig: _app.filters,
        securityConfig: _app.security,
        router: _app.router,
        scheduler: _app.scheduler,
      );
      client = http.Client();
    }

    final login = await client.post(
      url('/${env.adminPrefix}/login'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'access': testAccess, 'secret': testSecret}),
    );
    expect(login.statusCode, 200, reason: 'login: ${login.body}');
    token = jsonDecode(login.body)['access_token'] as String;
  }

  Future<void> stop() async {
    client.close();
    if (port == null) {
      await _app.scheduler.stop();
    } else {
      await Winter.close(force: true);
    }
    // On Windows an open file can't be deleted
    await di.find<AppDatabase>().close();
    await _deleteStorage();
  }

  Uri url(String path) => Uri.parse('http://$host$path');

  /// Headers with the JWT; [json] adds `Accept: application/json`.
  Map<String, String> auth({bool json = false}) => {
    'authorization': 'Bearer $token',
    if (json) 'accept': 'application/json',
  };

  /// Headers of a native S3 client: a SigV4 signature with the test keys.
  /// [path] goes as it is in the URL (already encoded). [at] changes the
  /// signature date (now by default) and [payloadHash] signs the body's sha256
  /// instead of `UNSIGNED-PAYLOAD`. [access] and [secret] sign with another
  /// key (an access key created in the test).
  Map<String, String> sigV4(
    String method,
    String path, {
    Map<String, String> query = const {},
    DateTime? at,
    String payloadHash = SigV4Signer.unsignedPayload,
    String access = testAccess,
    String secret = testSecret,
    Map<String, String> extraHeaders = const {},
  }) {
    final now = (at ?? utcNow()).toUtc();
    final amzDate = SigV4Signer.amzDate(now);
    final scope = SigV4Signer.scope(SigV4Signer.dateStamp(now));
    final headers = {
      'host': host,
      'x-amz-date': amzDate,
      'x-amz-content-sha256': payloadHash,
      ...extraHeaders,
    };
    final signedHeaders = (headers.keys.toList()..sort()).join(';');
    final signature = SigV4Signer.signature(
      secret: secret,
      amzDate: amzDate,
      scope: scope,
      canonicalRequest: SigV4Signer.canonicalRequest(
        method: method,
        path: path,
        query: query,
        headers: headers,
        signedHeaders: signedHeaders,
        payloadHash: payloadHash,
      ),
    );
    return {
      ...headers,
      'authorization':
          '${SigV4Signer.algorithm} Credential=$access/$scope, '
          'SignedHeaders=$signedHeaders, Signature=$signature',
    };
  }

  /// Creates the bucket unless it exists (a 409 means it was already there).
  Future<void> createBucket(String bucket) async {
    final response = await client.put(url('/$bucket'), headers: auth());
    expect(
      response.statusCode,
      anyOf(200, 409),
      reason: 'create $bucket: ${response.body}',
    );
  }

  /// Uploads an object (creating the bucket if needed). It goes as bytes
  /// without `Content-Type` (with a String, package:http would send
  /// `text/plain`), so on read the type comes from the extension. [headers] are
  /// added to the upload.
  Future<void> putObject(
    String bucket,
    String key,
    String body, {
    Map<String, String> headers = const {},
  }) async {
    await createBucket(bucket);
    final response = await client.put(
      url('/$bucket/$key'),
      headers: {...auth(), ...headers},
      body: utf8.encode(body),
    );
    expect(response.statusCode, 200, reason: 'put $bucket/$key');
  }

  Future<void> _deleteStorage() async {
    final dir = Directory(storagePath);
    if (await dir.exists()) await dir.delete(recursive: true);
  }
}

/// `package:http` over the pipeline in memory: what a socket would carry
/// (`Host`, `Content-Length`) goes in the headers, and the body flows as a
/// stream both ways.
class _InMemoryClient extends http.BaseClient {
  final RequestHandler handler;

  _InMemoryClient(this.handler);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final headers = <String, Object>{
      'host': request.url.host,
      ...request.headers,
      if (request.contentLength != null)
        'content-length': '${request.contentLength}',
    };
    final response = await handler(
      RequestEntity(
        request.method,
        request.url,
        headers: headers,
        body: request.finalize(),
      ),
    );
    return http.StreamedResponse(
      // Like a real server: the body of a HEAD response is never sent
      request.method == 'HEAD' ? const Stream.empty() : response.read(),
      response.statusCode,
      headers: {
        for (final entry in response.headers.entries)
          entry.key.toLowerCase(): entry.value,
      },
      request: request,
    );
  }
}
