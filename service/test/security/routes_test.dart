@TestOn('vm')
library;

import 'package:http/http.dart' as http;
import 'package:service/feather.dart';
import 'package:test/test.dart';

import '../support/test_server.dart';

/// Every route of [route], with its full path and method.
List<(String, HttpMethod, Route)> allRoutes(Route route, [String prefix = '']) {
  final path = (prefix + route.path).replaceAll('//', '/');
  return [
    if (route.method != null) (path, route.method!, route),
    for (final child in route.routes) ...allRoutes(child, path),
  ];
}

/// The permissions a route asks for: the `hasPermission(…)` of its
/// `AuthFilter` (none for a public route).
Set<String> permissionsOf(Route route) => {
  for (final filter in route.filterConfig.filters)
    if (filter is AuthFilter && filter.rule != null)
      for (final m in RegExp(
        r'hasPermission\(([^)]+)\)',
      ).allMatches(filter.rule!.describe()))
        m.group(1)!,
};

void main() {
  final server = TestServer(port: 8118, name: 'routes');
  setUpAll(server.start);
  tearDownAll(server.stop);

  /// Answer without a token: the login, the health check and the docs.
  const public = {
    'admin.auth.login',
    AdminController.healthKey,
    'admin.openapi',
    'admin.docs',
  };

  // Once the app is up: the controllers come from its DI
  List<(String, HttpMethod, Route)> routes() => [
    ...allRoutes(AdminController().routing),
    ...allRoutes(S3Controller().routing),
  ];

  test('Should give every route its own key', () {
    final keys = [for (final (_, _, route) in routes()) route.key];
    expect(keys.toSet(), hasLength(keys.length));
  });

  test('Should ask every private route for a permission of the list', () {
    for (final (path, method, route) in routes()) {
      final asked = permissionsOf(route);
      if (public.contains(route.key)) {
        expect(asked, isEmpty, reason: '$method $path (${route.key})');
        continue;
      }
      expect(asked, isNotEmpty, reason: '$method $path (${route.key})');
      for (final permission in asked) {
        final known =
            Permissions.all.contains(permission) ||
            Permissions.s3.any((p) => Permissions.anonymous(p) == permission);
        expect(known, isTrue, reason: '$permission of ${route.key}');
      }
    }
  });

  test('Should give every permission a route', () {
    final asked = {
      for (final (_, _, route) in routes()) ...permissionsOf(route),
    };
    expect(Permissions.all.where((p) => !asked.contains(p)), isEmpty);
  });

  test('Should name every route of a single permission after it', () {
    for (final (_, _, route) in routes()) {
      final own = permissionsOf(route).where(Permissions.all.contains);
      // s3.post-object (CreateMultipartUpload, CompleteMultipartUpload) needs
      // s3.put-object, the permission of uploading an object
      if (own.length == 1 && route.key != 's3.post-object') {
        expect(route.key, own.single);
      }
    }
  });

  test('Should answer 401 on every admin route but the public ones without a token', () async {
    final admin = allRoutes(AdminController().routing);
    expect(admin, hasLength(greaterThan(15)));
    for (final (path, method, route) in admin) {
      if (public.contains(route.key)) continue;
      // Any value for the path params: the token is checked before them
      final concrete = path.replaceAllMapped(
        RegExp(r'\{(\w+)\}'),
        (m) => 'scan-${m.group(1)}',
      );
      final request =
          http.Request(method.name.toUpperCase(), server.url(concrete))
            ..headers['content-type'] = 'application/json'
            ..body = '{}';
      final response = await request.send();
      expect(response.statusCode, 401, reason: '$method $path (${route.key})');
    }
  });
}
