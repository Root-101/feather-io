import 'package:console/app_exporter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Should pick the texts of the language, its region and English by default',
    () {
      expect(messagesOf(const Locale('es')).common.cancel, 'Cancelar');
      expect(messagesOf(const Locale('es', 'MX')).common.cancel, 'Cancelar');
      expect(messagesOf(const Locale('fr')).common.cancel, 'Cancel');
      expect(appSupportedLocales, [const Locale('en'), const Locale('es')]);
    },
  );

  test('Should use the plural form and the named placeholders', () {
    final en = messagesOf(const Locale('en'));
    expect(en.objects.moved(count: 1), '1 object moved');
    expect(en.objects.moved(count: 3), '3 objects moved');
    expect(en.bucketAdmin.stats(count: 2, size: '1 KB'), '2 objects · 1 KB');
    expect(
      messagesOf(const Locale('es')).objects.moved(count: 3),
      isNot(contains('{')),
    );
  });
}
