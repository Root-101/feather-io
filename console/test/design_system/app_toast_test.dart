import 'package:console/app_exporter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  Future<void> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1536, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        theme: AppTheme.dark,
        localizationsDelegates: AppIntl.delegates,
        supportedLocales: AppIntl.supportedLocales,
        home: const SizedBox(),
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

  // From anywhere, also from the dialogs that close themselves: it goes on the
  // overlay of the root navigator (it crashed in the release build)
  testWidgets('Should show a success notice', (tester) async {
    await pump(tester);
    app.toast.success('Renamed');
    await expectShown(tester, 'Renamed');
  });

  testWidgets('Should show an error notice', (tester) async {
    await pump(tester);
    app.toast.error('Failed');
    await expectShown(tester, 'Failed');
  });
}
