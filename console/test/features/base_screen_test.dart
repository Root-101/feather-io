import 'package:console/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

class _MockTransferRepo extends Mock implements TransferRepo {}

class _MockAuth extends Mock implements AuthCubit {}

class _MockLanguageRepo extends Mock implements LanguageRepo {}

void main() {
  final languages = _MockLanguageRepo();
  when(languages.loadKey).thenAnswer((_) async => null);
  app.di.put<TransferCubit>(TransferCubit(_MockTransferRepo(), _MockAuth()));

  Future<void> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1536, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    GoRoute page(String path) =>
        GoRoute(path: path, builder: (_, _) => Text(path));
    final router = GoRouter(
      initialLocation: '/browser',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (_, _, shell) => BaseScreen(shell),
          branches: [
            StatefulShellBranch(routes: [page('/browser')]),
            StatefulShellBranch(routes: [page('/buckets')]),
            StatefulShellBranch(routes: [page('/keys')]),
          ],
        ),
      ],
    );
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => LanguageCubit(repo: languages),
        child: MaterialApp.router(
          theme: ThemeConfig.theme,
          localizationsDelegates: appLocalizationsDelegates,
          supportedLocales: appSupportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'Should expand and collapse the rail with the notch, showing the name expanded',
    (tester) async {
      await pump(tester);
      final intl = messagesOf(const Locale('en'));
      final rail = find.byType(NavigationRail);
      expect(find.byTooltip(intl.nav.expand), findsOneWidget);
      expect(find.byType(AppWordmark), findsNothing);
      final collapsed = tester.getSize(rail).width;

      await tester.tap(find.byTooltip(intl.nav.expand));
      await tester.pumpAndSettle();
      expect(find.byTooltip(intl.nav.collapse), findsOneWidget);
      expect(find.byType(AppWordmark), findsOneWidget);
      expect(tester.getSize(rail).width, greaterThan(collapsed));

      await tester.tap(find.byTooltip(intl.nav.collapse));
      await tester.pumpAndSettle();
      expect(find.byType(AppWordmark), findsNothing);
      expect(tester.getSize(rail).width, collapsed);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Should put the notch on the rail\'s border', (tester) async {
    await pump(tester);
    final intl = messagesOf(const Locale('en'));
    final notch = tester.getRect(find.byTooltip(intl.nav.expand));
    final divider = tester.getRect(find.byType(VerticalDivider));
    expect(notch.right, divider.right);
  });
}
