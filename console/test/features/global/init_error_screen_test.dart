import 'package:console/app_exporter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should say the console couldn\'t start and try again', (
    tester,
  ) async {
    var retries = 0;
    await tester.pumpWidget(InitErrorScreen(onRetry: () => retries++));
    final intl = AppIntl.of(AppLocale.en);
    expect(find.text(intl.app.initErrorTitle), findsOneWidget);
    expect(find.text(intl.app.initErrorHint), findsOneWidget);

    await tester.tap(find.text(intl.common.tryAgain));
    expect(retries, 1);
  });
}
