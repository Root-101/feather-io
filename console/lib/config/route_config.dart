import 'package:console/app_exporter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static final GoRouter router = closePopupsOnNavigation(
    GoRouter(
      initialLocation: BrowserScreen.navigator.path,
      navigatorKey: navigatorKey,
      refreshListenable: GoRouterRefreshStream(app.di.find<AuthCubit>().stream),
      redirect: (context, state) {
        final auth = app.di.find<AuthCubit>();
        final isLoggingIn = state.matchedLocation == LoginScreen.navigator.path;

        if (auth.auth == null) {
          if (isLoggingIn) return null;
          // Remember where the user was going, to open it after logging in
          return Uri(
            path: LoginScreen.navigator.path,
            queryParameters: {RouteNames.loginFromParam: state.uri.toString()},
          ).toString();
        }

        if (isLoggingIn) {
          return afterLogin(
            state.uri.queryParameters[RouteNames.loginFromParam],
          );
        }

        return null;
      },
      routes: [
        ...LoginScreen.navigator.routes(),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return BaseScreen(navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                ///   /browser
                ...BrowserScreen.navigator.routes(),
              ],
            ),
            StatefulShellBranch(
              routes: [
                ///   /buckets
                ...BucketAdminScreen.navigator.routes(),
              ],
            ),
            StatefulShellBranch(
              routes: [
                ///   /keys
                ...AccessKeysScreen.navigator.routes(),
              ],
            ),
          ],
        ),
      ],
    ),
    navigatorKey,
  );

  /// A dialog or drawer belongs to the screen that opened it: when the location
  /// changes under it (the browser's back, a typed URL) it closes. The ones that
  /// navigate close themselves first, so then there is nothing left to close
  static GoRouter closePopupsOnNavigation(
    GoRouter router,
    GlobalKey<NavigatorState> navigatorKey,
  ) {
    var location = router.routeInformationProvider.value.uri;
    router.routerDelegate.addListener(() {
      final next = router.routeInformationProvider.value.uri;
      if (next == location) return;
      location = next;
      // after the frame: the router is still building the new location
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => navigatorKey.currentState?.popUntil(
          (route) => route is! PopupRoute,
        ),
      );
    });
    return router;
  }

  /// The location saved in `?from=` if it is one of ours (a path, not the login
  /// itself); otherwise the browser
  static String afterLogin(String? from) {
    final uri = from == null ? null : Uri.tryParse(from);
    final valid =
        uri != null &&
        !uri.hasScheme &&
        !uri.hasAuthority &&
        uri.path.startsWith('/') &&
        uri.path != LoginScreen.navigator.path;
    return valid ? from! : BrowserScreen.navigator.path;
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    stream.listen((_) => notifyListeners());
  }
}
