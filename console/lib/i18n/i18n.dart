import 'package:console/i18n/strings.g.dart';
import 'package:material_ui/material_ui.dart';

export 'package:console/i18n/strings.g.dart' show AppLocale, AppTexts;

/// The texts of the app in the current language, without a `BuildContext`
/// (so they work in the splash, "need more space" and before the router).
/// `LanguageCubit` sets [current]; everything else reads `app.intl`
class AppIntl {
  AppIntl._();

  /// One instance per language, built once
  static final Map<AppLocale, AppTexts> _cache = {
    for (final locale in AppLocale.values) locale: locale.buildSync(),
  };

  /// Until the user picks one, the browser's language
  static AppLocale current = browser;

  static AppTexts get texts => _cache[current]!;

  /// The texts of [locale], whatever the current language
  static AppTexts of(AppLocale locale) => _cache[locale]!;

  /// The language of a code (`es-MX` -> `es`); an unknown one is the base (`en`)
  static AppLocale resolve(String? languageCode) => AppLocale.values.firstWhere(
    (locale) => locale.languageCode == languageCode,
    orElse: () => AppLocale.en,
  );

  /// The browser's language if the console has it, English otherwise (like
  /// `web/splash.js`)
  static AppLocale get browser =>
      resolve(WidgetsBinding.instance.platformDispatcher.locale.languageCode);

  static List<Locale> get supportedLocales =>
      AppLocale.values.map((locale) => Locale(locale.languageCode)).toList();

  /// For every `MaterialApp` of the app. `material_ui`'s Material
  /// localizations, never `flutter_localizations`' (which `material_ui` widgets
  /// can't see: "No MaterialLocalizations found" in any language but English)
  static const List<LocalizationsDelegate<dynamic>> delegates = [
    ...GlobalMaterialLocalizations.delegates,
  ];
}
