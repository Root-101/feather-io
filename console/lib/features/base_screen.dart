import 'dart:ui' show lerpDouble;

import 'package:console/app_exporter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

/// Base screen with the navigation rail
class BaseScreen extends StatefulWidget {
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  const BaseScreen(this.navigationShell, {super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool _isRailExpanded = false;

  void _toggleRail() {
    setState(() {
      _isRailExpanded = !_isRailExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // the notch sits on the divider, so the rail and the divider go together
          Stack(
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: NavigationRail(
                      extended: _isRailExpanded,
                      minWidth: _RailFooter.collapsedWidth,
                      minExtendedWidth: _RailFooter.expandedWidth,
                      selectedIndex: widget.navigationShell.currentIndex,
                      onDestinationSelected: _onTap,
                      leading: const _RailBrand(),
                      destinations: [
                        NavigationRailDestination(
                          icon: app.assets.icons.storage.folder.build(
                            color: app.colors.neutral.grey3,
                          ),
                          selectedIcon: app.assets.icons.storage.folder.build(
                            color: app.colors.neutral.white,
                          ),
                          label: Text(app.intl.nav.browser),
                        ),
                        NavigationRailDestination(
                          icon: app.assets.icons.storage.bucket.build(
                            color: app.colors.neutral.grey3,
                          ),
                          selectedIcon: app.assets.icons.storage.bucket.build(
                            color: app.colors.neutral.white,
                          ),
                          label: Text(app.intl.nav.buckets),
                        ),
                        NavigationRailDestination(
                          icon: app.assets.icons.actions.key.build(
                            color: app.colors.neutral.grey3,
                          ),
                          selectedIcon: app.assets.icons.actions.key.build(
                            color: app.colors.neutral.white,
                          ),
                          label: Text(app.intl.nav.accessKeys),
                        ),
                      ],
                      trailing: Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: app.dimensions.padding.l,
                            ),
                            child: const _RailFooter(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: app.colors.neutral.grey5,
                  ),
                ],
              ),
              Positioned(
                top: _RailNotch.top,
                right: 0,
                child: _RailNotch(
                  expanded: _isRailExpanded,
                  onPressed: _toggleRail,
                ),
              ),
            ],
          ),
          Expanded(child: widget.navigationShell),
        ],
      ),
    );
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(index);
  }
}

/// Rail footer: transfers, language and log out, three identical [RailButton]s.
/// With the rail collapsed they go in a column and expanded in a row; each one
/// slides from one place to the other with the rail's own animation
class _RailFooter extends StatelessWidget {
  static const double collapsedWidth = 80;

  /// The footer row plus `padding-l` on each side
  static const double expandedWidth = _rowWidth + 2 * 16;

  static const double _gap = 12;
  static const double _size = RailButton.size;
  static const double _rowWidth = 3 * _size + 2 * _gap;

  const _RailFooter();

  @override
  Widget build(BuildContext context) {
    final animation = NavigationRail.extendedAnimation(context);
    final buttons = [
      const TransfersIndicator(),
      const LanguageWidget(),
      RailButton(
        tooltip: app.intl.nav.logout,
        onPressed: (_) => app.di.find<AuthCubit>().logout(),
        child: app.assets.icons.actions.logout.build(
          size: 18,
          color: app.colors.neutral.grey2,
        ),
      ),
    ];
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        // with "reduce motion" they jump from the column to the row
        final t = MediaQuery.disableAnimationsOf(context)
            ? animation.value.roundToDouble()
            : animation.value;
        final width = lerpDouble(collapsedWidth, expandedWidth, t)!;
        // the column is as tall as the row is wide
        final height = lerpDouble(_rowWidth, _size, t)!;
        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var i = 0; i < buttons.length; i++)
                Positioned(
                  left: lerpDouble(
                    (collapsedWidth - _size) / 2,
                    (expandedWidth - _rowWidth) / 2 + i * (_size + _gap),
                    t,
                  ),
                  top: lerpDouble(i * (_size + _gap), 0, t),
                  child: buttons[i],
                ),
            ],
          ),
        );
      },
    );
  }
}

/// The rail's `leading`: the icon, and the name while it is expanded. It takes
/// the whole width of the rail and stays on the left, in the same place as with
/// the rail collapsed, so it doesn't move when expanding it
class _RailBrand extends StatelessWidget {
  static const double height = 48;
  static const double _icon = 32;

  const _RailBrand();

  @override
  Widget build(BuildContext context) {
    final animation = NavigationRail.extendedAnimation(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => SizedBox(
        width: lerpDouble(
          _RailFooter.collapsedWidth,
          _RailFooter.expandedWidth,
          animation.value,
        ),
        height: height,
        child: Padding(
          padding: const EdgeInsets.only(
            left: (_RailFooter.collapsedWidth - _icon) / 2,
          ),
          child: Row(
            children: [
              Image.asset(app.assets.appIcon, width: _icon, height: _icon),
              if (animation.value > 0)
                Flexible(
                  child: Opacity(
                    opacity: animation.value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: AppWordmark(name: app.intl.app.name, fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Expand/collapse: a 14×34 notch on the rail's border at the height of the
/// icon, in the page's background with the border all around (the right side
/// keeps the divider whole) and a chevron towards where the rail goes
class _RailNotch extends StatefulWidget {
  static const double width = 14;
  static const double height = 34;

  /// Centered on the brand, below the rail's own top padding
  static const double top = 8 + (_RailBrand.height - height) / 2;

  final bool expanded;
  final VoidCallback onPressed;

  const _RailNotch({required this.expanded, required this.onPressed});

  @override
  State<_RailNotch> createState() => _RailNotchState();
}

class _RailNotchState extends State<_RailNotch> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.horizontal(left: Radius.circular(10));
    final active = _hovered;
    return Tooltip(
      message: widget.expanded ? app.intl.nav.collapse : app.intl.nav.expand,
      child: Material(
        color: app.colors.neutral.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          onHover: (hovered) => setState(() => _hovered = hovered),
          borderRadius: radius,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: _RailNotch.width,
            height: _RailNotch.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active
                  ? app.colors.primary.background3
                  : app.colors.primary.background1,
              border: Border.all(color: app.colors.neutral.grey5),
              borderRadius: radius,
            ),
            child:
                (widget.expanded
                        ? app.assets.icons.navigation.left
                        : app.assets.icons.navigation.right)
                    .build(
                      size: 12,
                      color: active
                          ? app.colors.neutral.white
                          : app.colors.neutral.grey3,
                    ),
          ),
        ),
      ),
    );
  }
}
