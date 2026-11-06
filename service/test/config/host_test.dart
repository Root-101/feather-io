@TestOn('vm')
library;

import 'package:http/http.dart' as http;
import 'package:service/feather.dart';
import 'package:test/test.dart';

import '../support/test_server.dart';

void main() {
  final server = TestServer(port: 8117, name: 'host');

  setUpAll(server.start);
  tearDownAll(server.stop);

  group('HOST', () {
    test('Should listen on every interface by default', () {
      expect(env.host, '::');
    });

    // Railway's private network reaches the service over IPv6 only
    for (final host in ['127.0.0.1', '[::1]']) {
      test('Should answer over $host', () async {
        final response = await http.get(
          Uri.parse('http://$host:${server.port}/${env.adminPrefix}/health'),
        );
        expect(response.statusCode, 200);
      });
    }
  });
}
