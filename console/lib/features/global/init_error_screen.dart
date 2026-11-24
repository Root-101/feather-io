import 'package:console/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Shown when the app couldn't start (`Init` failed): what happened and
/// «Try again», which starts it over. In the browser's language, like the splash
class InitErrorScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const InitErrorScreen({required this.onRetry, super.key});

  AppTexts get _texts => AppIntl.of(AppIntl.browser);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      locale: Locale(AppIntl.browser.languageCode),
      localizationsDelegates: AppIntl.delegates,
      supportedLocales: AppIntl.supportedLocales,
      builder: (context, child) => Scaffold(
        backgroundColor: app.colors.primary.background1,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(app.dimensions.padding.xxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(app.assets.appIcon, width: 72, height: 72),
                app.dimensions.padding.xxl.gap(),
                Text(
                  _texts.app.initErrorTitle,
                  textAlign: TextAlign.center,
                  style: TextTheme.of(context).titleLarge,
                ),
                app.dimensions.padding.m.gap(),
                Text(
                  _texts.app.initErrorHint,
                  textAlign: TextAlign.center,
                  style: TextTheme.of(context).bodyMedium
                      ?.copyWith(color: app.colors.neutral.grey3),
                ),
                (2 * app.dimensions.padding.xxl).gap(),
                // PrimaryButton.primary reads the theme of the router's
                // navigator, which doesn't exist when the app couldn't start
                PrimaryButton(
                  onPressed: onRetry,
                  color: app.colors.primary.purple.brighten(0.15),
                  title: _texts.common.tryAgain,
                  titleStyle: TextTheme.of(
                    context,
                  ).titleMedium?.copyWith(color: app.colors.neutral.white),
                  h: 50,
                  w: 260,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
