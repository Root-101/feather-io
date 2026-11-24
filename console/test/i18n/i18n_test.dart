import 'package:console/app_exporter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Should pick the texts of the language, and English for an unknown one',
    () {
      expect(AppIntl.of(AppLocale.es).common.cancel, 'Cancelar');
      expect(AppIntl.resolve('es'), AppLocale.es);
      expect(AppIntl.resolve('fr'), AppLocale.en);
      expect(AppIntl.resolve(null), AppLocale.en);
      expect(AppIntl.supportedLocales, [
        const Locale('en'),
        const Locale('es'),
      ]);
    },
  );

  test('Should use the plural form and the named placeholders', () {
    final en = AppIntl.of(AppLocale.en);
    expect(en.objects.moved(count: 1), '1 object moved');
    expect(en.objects.moved(count: 3), '3 objects moved');
    expect(en.bucketAdmin.stats(count: 2, size: '1 KB'), '2 objects · 1 KB');
    expect(
      AppIntl.of(AppLocale.es).objects.moved(count: 3),
      isNot(contains('{')),
    );
  });
}
