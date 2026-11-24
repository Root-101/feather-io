import 'package:console/app_exporter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('RouteConfig.afterLogin', () {
    final browser = BrowserScreen.navigator.path;

    test('Goes back to the page asked for, with its query', () {
      expect(RouteConfig.afterLogin('/keys'), '/keys');
      expect(
        RouteConfig.afterLogin('/buckets?bucket=backups&tab=access'),
        '/buckets?bucket=backups&tab=access',
      );
    });

    test('Without a page, goes to the browser', () {
      expect(RouteConfig.afterLogin(null), browser);
      expect(RouteConfig.afterLogin(''), browser);
    });

    test('Never leaves the console (no open redirect)', () {
      expect(RouteConfig.afterLogin('https://evil.example/phish'), browser);
      expect(RouteConfig.afterLogin('//evil.example/phish'), browser);
      expect(RouteConfig.afterLogin('javascript:alert(1)'), browser);
      expect(RouteConfig.afterLogin('keys'), browser);
    });

    test('Never goes back to the login itself', () {
      expect(RouteConfig.afterLogin(LoginScreen.navigator.path), browser);
    });
  });

  group('RouteConfig.closePopupsOnNavigation', () {
    late GlobalKey<NavigatorState> key;
    late GoRouter router;

    Future<void> openDialog(WidgetTester tester) async {
      showGeneralDialog(
        context: key.currentContext!,
        pageBuilder: (_, _, _) => const Text('dialog'),
      );
      await tester.pumpAndSettle();
      expect(find.text('dialog'), findsOneWidget);
    }

    setUp(() {
      key = GlobalKey<NavigatorState>();
      router = RouteConfig.closePopupsOnNavigation(
        GoRouter(
          navigatorKey: key,
          initialLocation: '/a',
          routes: [
            GoRoute(path: '/a', builder: (_, _) => const Text('page a')),
            GoRoute(path: '/b', builder: (_, _) => const Text('page b')),
          ],
        ),
        key,
      );
    });

    testWidgets('Closes a dialog left open when the location changes', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await openDialog(tester);

      router.go('/b');
      await tester.pumpAndSettle();

      expect(find.text('dialog'), findsNothing);
      expect(find.text('page b'), findsOneWidget);
    });

    testWidgets('Keeps it while the location stays', (tester) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await openDialog(tester);

      router.refresh();
      await tester.pumpAndSettle();

      expect(find.text('dialog'), findsOneWidget);
    });
  });
}
