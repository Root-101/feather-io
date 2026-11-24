import 'feather.dart';

// Handy commands:
// - dependencies: fvm dart pub outdated / fvm dart pub upgrade --major-versions
// - migrations: fvm dart fix --dry-run / fvm dart fix --apply
// - analysis: fvm dart analyze
// - Drift code: fvm dart run build_runner build
void main() async {
  // .env (and .env.<WINTER_PROFILE>) under the variables of the process, for
  // local development; in a container only the process ones exist
  Winter.context.setUp(env: Env.load());
  await FeatherIO.start();
}

class FeatherIO {
  /// Serves the S3 and admin APIs on [port].
  static Future<void> start({int port = 8080, AppDatabase? database}) async {
    final app = await setUp(database: database);
    await Winter.start(
      config: ServerConfig(
        host: env.host,
        port: port,
        maxBodySize: app.maxBodySize,
        trustedProxies: app.trustedProxies,
      ),
      globalFilterConfig: app.filters,
      securityConfig: app.security,
      router: app.router,
      scheduler: app.scheduler,
    );
  }

  /// The context, the dependencies and the pieces of the server, without
  /// opening a port: the tests serve them in memory (`WinterTestClient`).
  /// [database] lets them use an in-memory database instead of the file.
  static Future<FeatherApp> setUp({AppDatabase? database}) async {
    // Every missing variable in one error, before anything is created
    env.requireAll(requiredEnvVariables);

    //--------------- Context ---------------\\
    Winter.context.setUp(
      logger: env.serviceLogger,
      exceptionHandler: S3ExceptionHandler(),
      localeConfig: serviceLocales(),
    );
    // Only the name of the variable, never its value
    for (final name in env.shortSecrets) {
      logger.warning(
        '$name is shorter than ${recommendedSecretLengths[name]} characters: '
        'use a long random value',
        fields: {'variable': name},
      );
    }

    //--------------- OM ---------------\\
    om
      ..addDeserializer(
        Deserializer<DownloadObjectsRequest>.json(
          DownloadObjectsRequest.fromJson,
        ),
      )
      ..addDeserializer(Deserializer<LoginRequest>.json(LoginRequest.fromJson))
      ..addDeserializer(
        Deserializer<CreateRuleRequest>.json(CreateRuleRequest.fromJson),
      )
      ..addDeserializer(
        Deserializer<DeleteRuleRequest>.json(DeleteRuleRequest.fromJson),
      )
      ..addDeserializer(
        Deserializer<CreateBucketRequest>.json(CreateBucketRequest.fromJson),
      )
      ..addDeserializer(
        Deserializer<UpdateBucketRequest>.json(UpdateBucketRequest.fromJson),
      )
      ..addDeserializer(
        Deserializer<PresignRequest>.json(PresignRequest.fromJson),
      )
      ..addDeserializer(
        Deserializer<CompletedPart>.json(CompletedPart.fromJson),
      )
      ..addDeserializer(
        Deserializer<DeleteObjectEntry>.json(DeleteObjectEntry.fromJson),
      )
      ..addDeserializer(
        Deserializer<AccessKeyRequest>.json(AccessKeyRequest.fromJson),
      )
      ..addDeserializer(
        Deserializer<AccessKeyGrantRequest>.json(
          AccessKeyGrantRequest.fromJson,
        ),
      );

    // A malformed PUBLIC_URL fails at start-up, not on the first presigned URL
    env.publicUrl;

    //--------------- DB ---------------\\
    di.put<AppDatabase>(database ?? AppDatabase());

    //--------------- Access keys ---------------\
    // Their secrets are stored encrypted with KEYS_ENCRYPTION_SECRET
    di.put(SecretCipher(env.keysEncryptionSecret));

    //--------------- JWT ---------------\\
    di.put(JwtService());
    di.put(
      LoginRateLimiter(
        maxFailures: env.loginMaxFailures,
        lockDuration: Duration(seconds: env.loginLockSeconds),
        failureDelay: Duration(milliseconds: env.loginFailureDelayMs),
      ),
    );

    //--------------- Repos, services, controllers ---------------\\
    registerDependencies();

    //--------------- Routes ---------------\\
    final router = WinterRouter(
      config: RouterConfig(onLoadedRoutes: DefaultOnLoadedRoutes.log()),
      routes: [AdminController().routing, S3Controller().routing],
    );

    return (
      router: router,
      // The global limit is an object's, which goes to disk as a stream;
      // BodySizeFilter narrows it for every other request
      maxBodySize: env.maxObjectSize,
      // Behind your own proxies, clientIp and the scheme of requestedUri
      // come from their X-Forwarded-* (ignored without them)
      trustedProxies: env.trustedProxies > 0
          ? TrustedProxies(env.trustedProxies)
          : null,
      filters: FilterConfig([
        // First: stops a flood before reading bodies or checking signatures
        // (503 SlowDown on S3, 429 on admin: see S3ExceptionHandler)
        if (env.rateLimitRequests > 0)
          RateLimiterFilter(
            maxRequests: env.rateLimitRequests,
            window: Duration(seconds: env.rateLimitWindowSeconds),
          ),
        // Method, path, status and time of every request (never the query,
        // which holds the signature of a presigned URL)
        LoggingFilter(
          // The orchestrator asks for the health check every few seconds:
          // only a failed one is worth a line
          logRequest: (request) {
            if (!_isHealth(request)) defaultLogRequest(request);
          },
          logResponse: (request, response, duration) {
            if (!_isHealth(request) || response.statusCode != 200) {
              defaultLogResponse(request, response, duration);
            }
          },
        ),
        BodySizeFilter(),
        JwtFilter(),
      ]),
      // The console reads the ETag of each part of a multipart upload
      security: SecurityConfig(
        cors: const CorsConfig(exposedHeaders: ['ETag']),
      ),
      // What an interrupted upload leaves in the volume: once a day, and once
      // when it starts (after a crash or a restart)
      scheduler: Scheduler()
        ..every(
          const Duration(days: 1),
          name: 'storage-cleanup',
          task: _cleanStorage,
          runOnStart: true,
        ),
    );
  }

  static Future<void> _cleanStorage() async {
    final temps = await di.find<ObjectService>().deleteStaleTemps();
    final uploads = await di.find<MultipartService>().abortStale();
    if (temps + uploads > 0) {
      logger.info(
        'Storage cleaned',
        fields: {'tempFiles': temps, 'abortedUploads': uploads},
      );
    }
  }
}

bool _isHealth(RequestEntity request) =>
    request.route?.key == AdminController.healthKey;

/// The pieces of the server that [FeatherIO.setUp] builds: what
/// `Winter.start` (or a `WinterTestClient`) needs.
typedef FeatherApp = ({
  WinterRouter router,
  int maxBodySize,
  FilterConfig filters,
  SecurityConfig security,
  TrustedProxies? trustedProxies,
  Scheduler scheduler,
});
