import 'package:console/app_exporter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  late BuildContext inner;

  Future<void> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1536, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeConfig.theme,
        localizationsDelegates: appLocalizationsDelegates,
        supportedLocales: appSupportedLocales,
        home: Builder(
          builder: (context) {
            inner = context;
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Future<void> expectShown(WidgetTester tester, String message) async {
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.takeException(), isNull);
    expect(find.text(message), findsOneWidget);
    // Lets the notice go away, so no timer is left pending
    await tester.pump(const Duration(seconds: 10));
    await tester.pump(const Duration(seconds: 1));
  }

  // The dialogs that close themselves pass `app.context`, the navigator
  // itself: its overlay is below it (it crashed in the release build)
  testWidgets('Should show a notice from the navigator context', (
    tester,
  ) async {
    await pump(tester);
    app.snack.showSuccess(message: 'Renamed', context: app.context);
    await expectShown(tester, 'Renamed');
  });

  testWidgets('Should show a notice from a context inside a screen', (
    tester,
  ) async {
    await pump(tester);
    app.snack.showError(message: 'Failed', context: inner);
    await expectShown(tester, 'Failed');
  });
}
