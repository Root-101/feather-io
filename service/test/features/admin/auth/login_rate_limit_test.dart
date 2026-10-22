@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:service/feather.dart';
import 'package:test/test.dart';

import '../../../support/test_server.dart';

void main() {
  final server = TestServer(port: 8107, name: 'login_rate_limit');

  setUpAll(() async {
    // Small limits, so the test doesn't wait
    env.put('LOGIN_MAX_FAILURES', '3');
    env.put('LOGIN_LOCK_SECONDS', '2');
    env.put('LOGIN_FAILURE_DELAY_MS', '0');
    await server.start();
  });
  tearDownAll(server.stop);

  Future<http.Response> login(
    String secret, {
    Map<String, String> headers = const {},
  }) => http.post(
    server.url('/${env.adminPrefix}/login'),
    headers: {'content-type': 'application/json', ...headers},
    body: jsonEncode({'access': testAccess, 'secret': secret}),
  );

  group('AdminController - Login rate limit', () {
    test('Should lock the IP after 3 failures, even with good credentials', () async {
      for (var i = 0; i < 3; i++) {
        expect((await login('wrong$i')).statusCode, 403);
      }

      final locked = await login(testSecret);
      expect(locked.statusCode, 429);
      expect(int.parse(locked.headers['retry-after']!), inInclusiveRange(1, 2));

      // X-Forwarded-For doesn't count without TRUSTED_PROXIES: it can't bypass the lock
      final spoofed = await login(
        testSecret,
        headers: {'x-forwarded-for': '203.0.113.7'},
      );
      expect(spoofed.statusCode, 429);

      // A token issued before keeps working during the lock
      final list = await http.get(server.url('/'), headers: server.auth());
      expect(list.statusCode, 200);

      // Once the lock ends, the login works again
      await Future<void>.delayed(const Duration(milliseconds: 2100));
      expect((await login(testSecret)).statusCode, 200);
    });

    test('Should forget the failures after a successful login', () async {
      for (var i = 0; i < 2; i++) {
        expect((await login('wrong$i')).statusCode, 403);
      }
      expect((await login(testSecret)).statusCode, 200);
      for (var i = 0; i < 2; i++) {
        expect((await login('wrong$i')).statusCode, 403);
      }
      expect((await login(testSecret)).statusCode, 200);
    });

    test('Should not let requests that hold back their bodies guess past the lock', () async {
      // Each one sends its headers, so all of them pass the check before any
      // failure is counted, and then the bodies arrive together
      final sockets = [
        for (var i = 0; i < 10; i++)
          await Socket.connect('localhost', server.port),
      ];
      final bodies = <String>[];
      for (final (i, socket) in sockets.indexed) {
        final body = jsonEncode({'access': testAccess, 'secret': 'held$i'});
        bodies.add(body);
        socket.write(
          'POST /${env.adminPrefix}/login HTTP/1.1\r\n'
          'Host: localhost:${server.port}\r\n'
          'Content-Type: application/json\r\n'
          'Content-Length: ${utf8.encode(body).length}\r\n'
          'Connection: close\r\n\r\n',
        );
        await socket.flush();
      }
      await Future<void>.delayed(const Duration(milliseconds: 300));
      for (final (i, socket) in sockets.indexed) {
        socket.write(bodies[i]);
      }

      final statuses = await Future.wait([
        for (final socket in sockets)
          utf8.decoder
              .bind(socket)
              .join()
              .then((raw) => int.parse(raw.split(' ')[1])),
      ]);
      // As many guesses as the limit allows, the rest locked
      expect(statuses.where((s) => s == 403), hasLength(3));
      expect(statuses.where((s) => s == 429), hasLength(7));

      // So that the lock doesn't reach another test
      await Future<void>.delayed(const Duration(milliseconds: 2100));
    });
  });
}
