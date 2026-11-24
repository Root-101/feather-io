import 'package:service/feather.dart';

class AuthController {
  final AuthService authService = di.find();

  Future<ResponseEntity> login(RequestEntity request) async {
    // Per IP (an IPv6 by its /64), as the general limit; behind your own
    // proxies, see TRUSTED_PROXIES
    final client = defaultClientId(request);
    // Before reading the body: a locked client doesn't get to send one
    authService.checkLock(client);
    final login = await request.body<LoginRequest>();
    return ResponseEntity.ok(body: await authService.login(login, client));
  }
}
