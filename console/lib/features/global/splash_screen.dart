import 'package:console/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// Shown while the app initializes, right after the splash of `web/index.html`
/// (`web/splash.js` removes it on the first frame): the same icon, wordmark,
/// text and bar, so the hand-over doesn't show
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: appSupportedLocales,
      builder: (context, child) => Scaffold(
        backgroundColor: app.colors.primary.background1,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(app.assets.appIcon, width: 96, height: 96),
              app.dimensions.padding.xxl.gap(),
              AppWordmark(name: context.intl.app.name, fontSize: 56),
              app.dimensions.padding.l.gap(),
              Text(
                context.intl.app.splashText,
                style: TextTheme.of(context).bodyLarge?.copyWith(
                  color: app.colors.neutral.grey3,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 28),
              const _LoadingBar(),
            ],
          ),
        ),
      ),
    );
  }
}

/// The bar of `.loader` in `web/index.html`: a segment of 40 % that crosses
/// the track every 1.2 s, or the whole track at half opacity when the system
/// asks for less motion
class _LoadingBar extends StatefulWidget {
  const _LoadingBar();

  @override
  State<_LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<_LoadingBar>
    with SingleTickerProviderStateMixin {
  static const double _width = 220;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final still = MediaQuery.of(context).disableAnimations;
    final bar = app.colors.primary.primaryFaded;
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: _width,
        height: 4,
        color: app.colors.primary.background3,
        child: still
            ? ColoredBox(color: bar.withValues(alpha: 0.5))
            : AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  // `ease`, from -40 % to 100 % of the track
                  final t = Curves.ease.transform(_controller.value);
                  return Stack(
                    children: [
                      Positioned(
                        left: _width * (-0.4 + 1.4 * t),
                        width: _width * 0.4,
                        top: 0,
                        bottom: 0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: bar,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
