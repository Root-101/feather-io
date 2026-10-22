import 'dart:convert';

import 'package:service/feather.dart';

class AuthController {
  final JwtService jwtService;
  final LoginRateLimiter rateLimiter;

  AuthController() : jwtService = di.find(), rateLimiter = di.find();

  Future<ResponseEntity> login(RequestEntity request) async {
    // Per IP (an IPv6 by its /64), as the general limit; behind your own
    // proxies, see TRUSTED_PROXIES
    final client = defaultClientId(request);
    void checkLock() {
      final locked = rateLimiter.lockedFor(client);
      if (locked != null) {
        throw TooManyRequestsException(
          detail: intl.errors.admin.tooManyLoginAttempts,
          retryAfter: (locked.inMilliseconds / 1000).ceil(),
        );
      }
    }

    checkLock();
    try {
      final loginReq = await request.body<LoginRequest>();
      // Again once the body is read: requests that passed the first check
      // while their bodies were held back would each get a guess past the lock.
      // Nothing awaits from here to the count of the failure, so it is atomic
      checkLock();

      // Always both comparisons, without stopping at the first different
      // character: the response time gives nothing away
      final validAccess = _sameText(loginReq.access, env.access);
      final validSecret = _sameText(loginReq.secret, env.secret);
      if (!validAccess || !validSecret) {
        // The IP, never what was typed
        logger.warning('Failed login', fields: {'client': client});
        await rateLimiter.failed(client);
        throw S3Exception(
          S3ErrorCode.invalidCredentials,
          message: intl.errors.admin.invalidCredentials,
        );
      }
      rateLimiter.succeeded(client);

      final expiresAfter = Duration(hours: 12);
      final expireAt = DateTime.now().add(expiresAfter);

      final token = jwtService.generateToken({
        'sub': loginReq.access,
        'roles': ['admin'],
        'permissions': [
          // S3 API
          's3.list-buckets',
          's3.create-bucket',
          's3.delete-bucket',
          's3.list-objects',
          's3.put-object',
          's3.get-object',
          's3.delete-object',
          's3.multi-delete-objects',
          // Admin API
          'admin.bucket.get',
          'admin.bucket.update',
          'admin.bucket.presign',
          'admin.bucket.empty',
          'admin.bucket.delete-folder',
          'admin.bucket.download',
          'admin.bucket.anonymous-access.get-rules',
          'admin.bucket.anonymous-access.write-rule',
          'admin.bucket.anonymous-access.delete-rule',
          'admin.access-key.list',
          'admin.access-key.create',
          'admin.access-key.update',
          'admin.access-key.regenerate-secret',
          'admin.access-key.delete',
        ],
        'exp': expireAt.millisecondsSinceEpoch ~/ 1000,
      });

      return ResponseEntity.ok(
        body: LoginResponse(
          accessToken: token,
          expiresIn: expiresAfter.inMilliseconds,
          expireAt: expireAt,
        ),
      );
    } catch (e) {
      // A body that isn't the expected JSON keeps its 400 with the field
      if (e is ApiException || e is DeserializationException) rethrow;
      throw S3Exception(
        S3ErrorCode.invalidRequest,
        message: intl.errors.admin.invalidLoginRequest,
      );
    }
  }

  /// Compares without stopping at the first difference.
  static bool _sameText(String given, String expected) {
    final a = utf8.encode(given);
    final b = utf8.encode(expected);
    var diff = a.length ^ b.length;
    for (var i = 0; i < b.length; i++) {
      diff |= (i < a.length ? a[i] : 0) ^ b[i];
    }
    return diff == 0;
  }
}
