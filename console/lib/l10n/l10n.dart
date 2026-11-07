import 'package:console/l10n/messages.g.dart';
import 'package:flutter/widgets.dart';

/// One instance per language, built once
final Map<AppMessagesLocale, AppMessages> _cache = {
  for (final locale in AppMessagesLocale.values) locale: locale.buildSync(),
};

/// The languages of the console, for `MaterialApp.supportedLocales`
final List<Locale> appSupportedLocales = [
  for (final locale in AppMessagesLocale.values) Locale(locale.languageCode),
];

/// The browser's language if the console has it, English otherwise (like
/// `web/splash.js`): the language until the user picks one
Locale get browserLocale {
  final code = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  return appSupportedLocales.firstWhere(
    (locale) => locale.languageCode == code,
    orElse: () => Locale(AppMessagesLocale.en.languageCode),
  );
}

/// Texts of [locale]: a region uses its language (`es-MX` → `es`) and an
/// unknown language the base one (`en`)
AppMessages messagesOf(Locale locale) =>
    _cache[AppLocaleUtils.parseLocaleParts(
      languageCode: locale.languageCode,
      countryCode: locale.countryCode,
    )]!;

extension AppLocalizationsX on BuildContext {
  /// Texts of the language of the enclosing `MaterialApp` (rebuilds when it
  /// changes)
  AppMessages get intl => messagesOf(Localizations.localeOf(this));
}
