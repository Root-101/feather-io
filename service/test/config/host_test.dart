@TestOn('vm')
library;

import 'package:service/feather.dart';
import 'package:test/test.dart';

import '../support/test_app.dart';

void main() {
  final server = TestApp(name: 'host', port: 8117);

  setUpAll(server.start);
  tearDownAll(server.stop);

  group('HOST', () {
    test('Should listen on every interface by default', () {
      expect(env.host, '::');
    });

    // Railway's private network reaches the service over IPv6 only
    for (final host in ['127.0.0.1', '[::1]']) {
      test('Should answer over $host', () async {
        final response = await server.client.get(
          Uri.parse('http://$host:${server.port!}/${env.adminPrefix}/health'),
        );
        expect(response.statusCode, 200);
      });
    }
  });
}
