import 'package:console/app_exporter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements AuthRepo {}

void main() {
  Future<void> pump(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeConfig.theme,
        localizationsDelegates: appLocalizationsDelegates,
        supportedLocales: appSupportedLocales,
        home: BlocProvider(
          create: (_) => AuthCubit(_MockRepo()),
          child: const LoginScreen(),
        ),
      ),
    );
  }

  testWidgets(
    'Should put the brand with its pitch next to the form when wide',
    (tester) async {
      await pump(tester, const Size(1536, 720));
      final intl = messagesOf(const Locale('en'));
      expect(find.text(intl.login.pitch), findsOneWidget);
      expect(find.text(intl.login.tagline), findsOneWidget);
      expect(
        tester.getCenter(find.text(intl.login.tagline)).dx,
        lessThan(tester.getCenter(find.text(intl.login.title)).dx),
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Should stack the brand without its pitch above the form when narrow',
    (tester) async {
      await pump(tester, const Size(800, 400));
      final intl = messagesOf(const Locale('en'));
      expect(find.text(intl.login.pitch), findsNothing);
      for (final tag in intl.login.tags) {
        expect(find.text(tag), findsOneWidget);
      }
      expect(
        tester.getCenter(find.text(intl.login.tagline)).dy,
        lessThan(tester.getCenter(find.text(intl.login.title)).dy),
      );
      expect(tester.takeException(), isNull);
    },
  );
}
