import 'package:console/app_exporter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<LanguageState>
    with GlobalEventBusCommunication<LanguageState> {
  final LanguageRepo repo;

  static final LanguageModel defaultLanguage = LanguageModel(
    icon: app.assets.icons.language.en,
    key: 'en',
    name: 'English',
  );

  List<LanguageModel> languages = [
    defaultLanguage,
    LanguageModel(
      icon: app.assets.icons.language.es,
      key: 'es',
      name: 'Español',
    ),
  ];

  LanguageModel _current = defaultLanguage;

  LanguageModel get currentSelectedLanguage => _current;

  /// The texts of the app (`app.intl`) follow the language picked
  set currentSelectedLanguage(LanguageModel language) {
    _current = language;
    AppIntl.current = AppIntl.resolve(language.key);
  }

  LanguageCubit({required this.repo})
    : super(LanguageInitialState(current: defaultLanguage, allLanguages: [])) {
    // Starts in the browser's language, not English, until the saved one loads
    currentSelectedLanguage = _resolve(key: null);
    emit(
      LanguageInitialState(current: currentSelectedLanguage, allLanguages: []),
    );
    init();
  }

  Future init() async {
    String? key = await repo.loadKey();
    currentSelectedLanguage = _resolve(key: key);

    emit(
      LanguageChangedState(
        current: currentSelectedLanguage,
        allLanguages: languages,
      ),
    );
  }

  void changeLanguageKey({required String languageKey}) {
    LanguageModel? language = languages
        .where((element) => element.key == languageKey)
        .firstOrNull;
    changeLanguage(language: language);
  }

  void changeLanguage({LanguageModel? language}) {
    if (language == null) {
      return;
    }
    currentSelectedLanguage = language;
    repo.save(model: currentSelectedLanguage);

    emit(
      LanguageChangedState(
        current: currentSelectedLanguage,
        allLanguages: languages,
      ),
    );

    // this is what refreshes the widget tree without rebuilding every class
    WidgetsBinding.instance.reassembleApplication();
  }

  LanguageModel _resolve({required String? key}) {
    // Nothing chosen yet: the browser's language
    key ??= AppIntl.browser.languageCode;
    return languages.firstWhere(
      (element) => element.key == key,
      orElse: () => defaultLanguage,
    );
  }

  Locale get locale => Locale(currentSelectedLanguage.key);
}

// states
abstract class LanguageState {
  final LanguageModel current;
  final List<LanguageModel> allLanguages;

  const LanguageState({required this.current, required this.allLanguages});
}

class LanguageInitialState extends LanguageState {
  const LanguageInitialState({
    required super.current,
    required super.allLanguages,
  });
}

class LanguageChangedState extends LanguageState {
  const LanguageChangedState({
    required super.current,
    required super.allLanguages,
  });
}
