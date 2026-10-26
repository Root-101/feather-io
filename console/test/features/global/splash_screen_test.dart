import 'package:console/app_exporter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should show the same texts as the splash of index.html', (
    tester,
  ) async {
    await tester.pumpWidget(const SplashScreen());
    await tester.pump(const Duration(milliseconds: 600));
    final intl = messagesOf(const Locale('en'));
    expect(find.text(intl.app.splashText), findsOneWidget);
    expect(find.text(intl.app.credit), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
