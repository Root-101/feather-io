import 'package:console/app_exporter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLanguageRepo extends Mock implements LanguageRepo {}

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  final repo = _MockLanguageRepo();
  tearDown(binding.platformDispatcher.clearLocaleTestValue);

  Future<String> languageOf(Locale browser, {String? saved}) async {
    binding.platformDispatcher.localeTestValue = browser;
    when(repo.loadKey).thenAnswer((_) async => saved);
    final cubit = LanguageCubit(repo: repo);
    // Before the saved language loads, too
    expect(cubit.state.current.key, browserLocale.languageCode);
    await cubit.init();
    return cubit.state.current.key;
  }

  test('Should take Spanish from a Spanish browser', () async {
    expect(await languageOf(const Locale('es', 'MX')), 'es');
  });

  test('Should take English from a browser in another language', () async {
    expect(await languageOf(const Locale('fr', 'FR')), 'en');
  });

  test('Should keep the language the user chose', () async {
    expect(await languageOf(const Locale('es'), saved: 'en'), 'en');
  });
}
