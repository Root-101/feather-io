import 'dart:math';

import 'package:console/app_exporter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class LoginScreenNavigator {
  String get name => RouteNames.login;

  String get path => '/login';

  Widget builder(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

class LoginScreen extends StatefulWidget {
  static final LoginScreenNavigator navigator = LoginScreenNavigator();

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// From this width the brand goes next to the form; below it, above it and
/// without the pitch
const double wideBreakpoint = 1200;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _accessController = TextEditingController();
  final TextEditingController _secretController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// After the first submit attempt it validates on every change, so an error
  /// goes away as soon as the field is filled
  bool _submitted = false;

  @override
  void dispose() {
    _accessController.dispose();
    _secretController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (!_submitted) setState(() => _submitted = true);
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
        access: _accessController.text,
        secret: _secretController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // On success the router leaves the login by itself (it listens to
        // AuthCubit), to the page asked for before logging in. Closing the
        // autofill context first lets the browser offer to save the keys
        if (state is AuthProcessingOKState) {
          TextInput.finishAutofillContext();
        } else if (state is AuthProcessingErrorState) {
          app.snack.showError(message: state.message, context: context);
        }
      },
      child: Scaffold(
        backgroundColor: app.colors.primary.background1,
        // Scaffold gives its body loose constraints: the dots cover it all
        body: SizedBox.expand(
          child: CustomPaint(
            painter: GridDotPainter(
              radius: 1.5,
              color: app.colors.neutral.white.withValues(alpha: 0.07),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= wideBreakpoint;
                final form = ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: ClipRRect(
                    borderRadius: app.dimensions.border.borderRadius.m,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) => LoadingOverlay(
                        visible: state is AuthProcessInProgressState,
                        overlayWidgetBuilder: LoadingOverlayStyles.form,
                        child: _buildPanel(),
                      ),
                    ),
                  ),
                );
                final padding = app.dimensions.padding.xxl;
                // Scrolls when the window is too short; otherwise the content is
                // centered and the footer sits at the bottom
                final content = SingleChildScrollView(
                  padding: EdgeInsets.all(padding),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: max(0, constraints.maxHeight - 2 * padding),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // As tall as the footer, so the content stays centered
                        SizedBox(height: padding + 18),
                        if (wide)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 600,
                                child: _Brand(wide: true),
                              ),
                              const SizedBox(width: 128),
                              SizedBox(width: 400, child: form),
                            ],
                          )
                        else
                          Column(
                            children: [
                              const _Brand(wide: false),
                              const SizedBox(height: 40),
                              form,
                            ],
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: padding),
                          child: const _Credit(),
                        ),
                      ],
                    ),
                  ),
                );
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    content,
                    Positioned(
                      top: padding,
                      right: padding,
                      child: const LanguageWidget(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return Container(
      padding: EdgeInsets.all(app.dimensions.padding.xxl),
      decoration: BoxDecoration(
        color: app.colors.primary.background2,
        borderRadius: app.dimensions.border.borderRadius.m,
        border: Border.all(color: app.colors.primary.background3),
        boxShadow: [
          BoxShadow(
            color: app.colors.neutral.black.withValues(alpha: 0.5),
            offset: const Offset(0, 40),
            blurRadius: 100,
          ),
        ],
      ),
      // The keys go to the browser's password manager (it offers to save them
      // and fills them in), never to the console's own storage
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          autovalidateMode: _submitted
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                app.intl.login.title,
                style: app.textTheme.headlineSmall?.copyWith(
                  color: app.colors.neutral.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              app.dimensions.padding.xs.gap(),
              Text(
                app.intl.login.description,
                style: app.textTheme.bodyMedium?.copyWith(
                  color: app.colors.neutral.grey3,
                ),
              ),
              app.dimensions.padding.xxl.gap(),
              AppFormInput(
                controller: _accessController,
                label: app.intl.login.accessKey,
                hint: app.intl.login.accessKeyHint,
                validator: (v) =>
                    v?.isEmpty == true ? app.intl.common.required : null,
                autofillHints: const [AutofillHints.username],
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _onLogin(),
              ),
              app.dimensions.padding.m.gap(),
              AppFormPasswordInput(
                controller: _secretController,
                label: app.intl.login.secretKey,
                hint: app.intl.login.secretKeyHint,
                validator: (v) =>
                    v?.isEmpty == true ? app.intl.common.required : null,
                autofillHints: const [AutofillHints.password],
                onSubmitted: (_) => _onLogin(),
              ),
              app.dimensions.padding.xxl.gap(),
              PrimaryButton.primary(
                onPressed: _onLogin,
                title: app.intl.login.button,
              ),
              app.dimensions.padding.l.gap(),
              const _EnvHint(),
            ],
          ),
        ),
      ),
    );
  }
}

/// The visual identity next to (or above) the form: icon with its glow,
/// wordmark, tagline, the pitch (only when [wide]) and the tags
class _Brand extends StatelessWidget {
  final bool wide;

  const _Brand({required this.wide});

  @override
  Widget build(BuildContext context) {
    final iconSize = wide ? 104.0 : 72.0;
    final yellow = app.colors.primary.secondary;
    return Column(
      crossAxisAlignment: wide
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: iconSize,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // The glow of the brand yellow behind the icon (docs/brand.md)
                  IgnorePointer(
                    child: OverflowBox(
                      maxWidth: iconSize * 5,
                      maxHeight: iconSize * 5,
                      child: Container(
                        width: iconSize * 5,
                        height: iconSize * 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              yellow.withValues(alpha: 0.22),
                              yellow.withValues(alpha: 0.08),
                              yellow.withValues(alpha: 0),
                            ],
                            stops: const [0, 0.35, 0.7],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    app.assets.appIcon,
                    width: iconSize,
                    height: iconSize,
                  ),
                ],
              ),
            ),
            SizedBox(width: wide ? 28 : 20),
            // Shrinks rather than overflow when a narrow column can't hold it
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: AppWordmark(
                  name: app.intl.app.name,
                  fontSize: wide ? 88 : 56,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: wide ? 32 : 24),
        Text(
          app.intl.login.tagline,
          textAlign: wide ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: wide ? 40 : 28,
            fontWeight: FontWeight.w700,
            letterSpacing: wide ? -0.8 : -0.5,
            height: 1.1,
            color: yellow,
          ),
        ),
        if (wide) ...[
          app.dimensions.padding.m.gap(),
          SizedBox(
            width: 520,
            child: Text(
              app.intl.login.pitch,
              style: app.textTheme.bodyLarge?.copyWith(
                color: app.colors.neutral.grey3,
                fontSize: 18,
                height: 28 / 18,
              ),
            ),
          ),
        ],
        SizedBox(height: wide ? 32 : 20),
        Wrap(
          spacing: app.dimensions.padding.s,
          runSpacing: app.dimensions.padding.s,
          alignment: wide ? WrapAlignment.start : WrapAlignment.center,
          children: [
            for (final tag in app.intl.login.tags)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: app.colors.neutral.grey5),
                  borderRadius: app.dimensions.border.borderRadius.s,
                ),
                child: Text(
                  tag,
                  style: app.textTheme.bodyMedium?.copyWith(
                    color: app.colors.neutral.grey2,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Where the keys come from, with the names of the variables in monospace
class _EnvHint extends StatelessWidget {
  static const _access = 'FEATHER_ACCESS';
  static const _secret = 'FEATHER_SECRET';

  const _EnvHint();

  @override
  Widget build(BuildContext context) {
    final text = app.intl.login.envHint(access: _access, secret: _secret);
    final style = app.textTheme.bodySmall?.copyWith(
      color: app.colors.neutral.grey4,
      height: 18 / 12,
    );
    final mono = style?.copyWith(
      fontFamily: 'monospace',
      color: app.colors.neutral.grey2,
    );
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          for (final part in text.split(
            RegExp('(?=$_access|$_secret)|(?<=$_access|$_secret)'),
          ))
            TextSpan(
              text: part,
              style: part == _access || part == _secret ? mono : null,
            ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

/// The credit at the bottom, a link to Root101's site
class _Credit extends StatelessWidget {
  static const url = 'https://root101.dev';

  const _Credit();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      child: InkWell(
        onTap: () => BrowserWindow.openUrl(url),
        borderRadius: app.dimensions.border.borderRadius.xs,
        child: Padding(
          padding: EdgeInsets.all(app.dimensions.padding.xs),
          child: Text(
            app.intl.app.splashFooter,
            style: app.textTheme.bodySmall?.copyWith(
              color: app.colors.neutral.grey4,
              height: 18 / 13,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
