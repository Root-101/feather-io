import 'package:service/feather.dart';

/// The console's login with the root key (`FEATHER_ACCESS`/`FEATHER_SECRET`),
/// rate limited per client by [LoginRateLimiter].
class AuthService {
  /// How long a token lasts: there is no refresh, the console logs in again.
  static const Duration tokenLifetime = Duration(hours: 12);

  final JwtService jwtService = di.find();
  final LoginRateLimiter rateLimiter = di.find();

  /// 429 with `Retry-After` while [client] is locked out by its failures.
  void checkLock(String client) {
    final locked = rateLimiter.lockedFor(client);
    if (locked != null) {
      throw TooManyRequestsException(
        detail: intl.errors.admin.tooManyLoginAttempts,
        retryAfter: (locked.inMilliseconds / 1000).ceil(),
      );
    }
  }

  /// A token with every permission when [request] has the root key; a failure
  /// counts against [client] (an IP, an IPv6 by its /64).
  Future<LoginResponse> login(LoginRequest request, String client) async {
    // Again once the body is read: requests that passed the first check while
    // their bodies were held back would each get a guess past the lock.
    // Nothing awaits from here to the count of the failure, so it is atomic
    checkLock(client);

    // Always both comparisons: the response time gives nothing away
    final validAccess = Secrets.sameText(request.access!, env.access);
    final validSecret = Secrets.sameText(request.secret!, env.secret);
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

    final expireAt = DateTime.now().add(tokenLifetime);
    final token = jwtService.generateToken({
      'sub': request.access,
      'roles': ['admin'],
      'permissions': Permissions.all.toList(),
      'exp': expireAt.millisecondsSinceEpoch ~/ 1000,
    });
    return LoginResponse(
      accessToken: token,
      expiresIn: tokenLifetime.inMilliseconds,
      expireAt: expireAt,
    );
  }
}
