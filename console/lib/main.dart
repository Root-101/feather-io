import 'package:console/app_exporter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart' as old;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:material_ui/material_ui.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final String loadingOverlayGlobalId = 'app-global-loading';

// generate code
// fvm flutter pub run build_runner build --delete-conflicting-outputs
// fvm dart run slang

// versions
// fvm flutter pub outdated
// fvm flutter pub upgrade --major-versions

// migration
// fvm dart fix --dry-run
// fvm dart fix --apply
//
// fvm flutter analyze
class Init {
  Init._();

  static final instance = Init._();

  /// The splash shows at least a second (instead of flashing by), while the
  /// app loads
  Future<void> initialize() async {
    await Future.wait([
      Future.delayed(const Duration(seconds: 1)),
      FeaturesInit.init(),
    ]);
  }
}

void main() {
  // so the .push method of go_router updates the URL
  GoRouter.optionURLReflectsImperativeAPIs = true;

  WidgetsFlutterBinding.ensureInitialized();

  // a right click opens the app's menus, not the browser's
  if (kIsWeb) BrowserContextMenu.disableContextMenu();

  // errors nobody caught go to the log
  FlutterError.onError = (details) =>
      app.logger.e(details.exception, stackTrace: details.stack);
  PlatformDispatcher.instance.onError = (error, stack) {
    app.logger.e(error, stackTrace: stack);
    return true;
  };

  runApp(const Startup());
}

/// The splash while [Init] runs, the app when it is done, and
/// [InitErrorScreen] when it fails (its «Try again» runs it again)
class Startup extends StatefulWidget {
  const Startup({super.key});

  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  late Future<void> _init = Init.instance.initialize();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SplashScreen();
        }
        if (snapshot.hasError) {
          app.logger.e(snapshot.error, stackTrace: snapshot.stackTrace);
          return InitErrorScreen(
            onRetry: () => setState(() => _init = Init.instance.initialize()),
          );
        }
        return MultiBlocProvider(
          providers: [...FeaturesInit.blocProviders],
          child: const App(),
        );
      },
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LanguageListener(
      onLanguageChangeBuilder: (locale) {
        Size size = MediaQuery.of(context).size;
        if (size.width < 800 || size.height < 400) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.dark,
            locale: locale,
            localizationsDelegates: AppIntl.delegates,
            supportedLocales: AppIntl.supportedLocales,
            builder: (context, child) =>
                Scaffold(body: Center(child: Text(app.intl.app.needMoreSpace))),
          );
        } else {
          return MaterialApp.router(
            builder: (BuildContext context, Widget? child) {
              // DateFormat uses it: dates follow the app's language
              // (`06/sept/2026 09:22:32 p. m.` in Spanish)
              Intl.defaultLocale = Localizations.localeOf(context)
                  .toLanguageTag();
              return LoadingOverlay(
                id: loadingOverlayGlobalId,
                overlayWidgetBuilder: LoadingOverlayStyles.global,
                child: MaterialUiCompatibilityBridge(
                  child: old.Material(
                    type: old.MaterialType.transparency,
                    child: child!,
                  ),
                ),
              );
            },
            debugShowCheckedModeBanner: false,
            title: app.intl.app.name,
            theme: AppTheme.dark,
            locale: locale,
            routerConfig: RouteConfig.router,
            localizationsDelegates: AppIntl.delegates,
            supportedLocales: AppIntl.supportedLocales,
          );
        }
      },
    );
  }
}

AppGlobal app = AppGlobal();

class AppGlobal {
  static final AppGlobal _instance = AppGlobal._internal();

  AppGlobal._internal();

  factory AppGlobal() => _instance;

  BuildContext get context => navigatorKey.currentContext!;

  ThemeData get theme => Theme.of(context);

  TextTheme get textTheme => theme.textTheme;

  /// Texts of the app's language (`LanguageCubit` sets it)
  AppTexts get intl => AppIntl.texts;

  Logger logger = Logger();

  LoadingOverlayController loading = LoadingOverlayController();

  DI di = DI();

  NavigatorHelper navigator = NavigatorHelper();

  AppDimensions dimensions = AppDimensions();

  AppColors colors = AppColors();

  AppAssets assets = AppAssets();

  DateFormatter dateFormatter = DateFormatter();

  StorageFormatter storageFormatter = StorageFormatter();

  SnackBarAdapter snack = SnackBarAdapter();

  DialogHelper dialog = DialogHelper();

  MediaQueryData get mediaQuery => MediaQuery.of(context);
}
