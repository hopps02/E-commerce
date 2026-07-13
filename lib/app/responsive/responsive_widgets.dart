import 'package:flutter/widgets.dart';

import 'responsive_config.dart';
import 'responsive_extensions.dart';
import 'responsive_info.dart';

/// Builds a different widget per form factor. Only [mobile] is required; larger
/// tiers cascade down to it when omitted (see [ResponsiveInfo.bySize]).
///
/// ```dart
/// ResponsiveLayout(
///   mobile:  (c) => const MobileHome(),
///   tablet:  (c) => const TabletHome(),
///   desktop: (c) => const DesktopHome(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.watch,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? watch;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final WidgetBuilder? largeDesktop;

  @override
  Widget build(BuildContext context) {
    final builder = context.bySize<WidgetBuilder>(
      watch: watch,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
    return builder(context);
  }
}

/// Builds a different widget per real platform. [fallback] is required; specific
/// platforms fall back to the [mobile]/[desktop] group, then to [fallback]
/// (see [ResponsiveInfo.byPlatform]).
///
/// ```dart
/// PlatformLayout(
///   web:      (c) => const WebNav(),
///   mobile:   (c) => const BottomNav(),
///   desktop:  (c) => const SidebarNav(),
///   fallback: (c) => const BottomNav(),
/// )
/// ```
class PlatformLayout extends StatelessWidget {
  const PlatformLayout({
    super.key,
    required this.fallback,
    this.web,
    this.android,
    this.ios,
    this.windows,
    this.macos,
    this.linux,
    this.mobile,
    this.desktop,
  });

  final WidgetBuilder fallback;
  final WidgetBuilder? web;
  final WidgetBuilder? android;
  final WidgetBuilder? ios;
  final WidgetBuilder? windows;
  final WidgetBuilder? macos;
  final WidgetBuilder? linux;
  final WidgetBuilder? mobile;
  final WidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    final builder = context.byPlatform<WidgetBuilder>(
      web: web,
      android: android,
      ios: ios,
      windows: windows,
      macos: macos,
      linux: linux,
      mobile: mobile,
      desktop: desktop,
      fallback: fallback,
    );
    return builder(context);
  }
}

/// Hands you the full [ResponsiveInfo] so you can branch on any combination of
/// platform, size, and orientation in one place.
///
/// ```dart
/// ResponsiveBuilder(
///   builder: (context, info) {
///     if (info.isWeb && info.isDesktopSize) return const DesktopView();
///     if (info.isMobileSize)                return const MobileView();
///     return const TabletView();
///   },
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, ResponsiveInfo info) builder;

  @override
  Widget build(BuildContext context) => builder(context, context.responsive);
}

/// Shows [child] only on the given form factors, otherwise renders
/// [replacement] (an empty box by default).
///
/// ```dart
/// ResponsiveVisibility(
///   visibleWhen: const [ScreenSize.desktop, ScreenSize.largeDesktop],
///   child: const Sidebar(),
/// )
/// ```
class ResponsiveVisibility extends StatelessWidget {
  const ResponsiveVisibility({
    super.key,
    required this.child,
    this.visibleWhen = ScreenSize.values,
    this.replacement = const SizedBox.shrink(),
  });

  final Widget child;
  final List<ScreenSize> visibleWhen;
  final Widget replacement;

  @override
  Widget build(BuildContext context) =>
      visibleWhen.contains(context.screenSize) ? child : replacement;
}

/// Caps content width on bigger screens and leaves phones full-width.
///
/// Full-width on mobile (and watch); from tablet up it centres [child] and
/// caps it to [maxWidth] logical pixels. This replaces the repeated
/// `Container(constraints: context.bySize(mobile: null, tablet: ...))` block.
///
/// ```dart
/// ResponsiveConstrained(
///   maxWidth: 450,
///   child: MyScreenBody(),
/// )
/// ```
class ResponsiveConstrained extends StatelessWidget {
  const ResponsiveConstrained({
    super.key,
    required this.child,
    this.maxWidth = 450,
    this.constrainOnMobile = false,
    this.alignment = Alignment.center,
    this.padding,
  });

  final Widget child;

  /// Max width in logical pixels applied from tablet up (raw px, not `.w`, so
  /// the cap stays stable across the per-tier design canvases).
  final double maxWidth;

  /// Also cap on mobile/watch when true (default: mobile stays full-width).
  final bool constrainOnMobile;

  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Widget content = child;
    if (padding != null) content = Padding(padding: padding!, child: content);

    final shouldCap = constrainOnMobile || context.isAtLeastTablet;
    if (!shouldCap) return content;

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: content,
      ),
    );
  }
}

/// Constrains [child] to [maxWidth] and centres it, optionally painting a
/// [backgroundColor] on the surrounding gutters. Handy for keeping content
/// readable (and, if you want, a phone-width column) on wide desktop windows.
///
/// ```dart
/// MaxWidthBox(maxWidth: 480, child: MyForm())   // centred column on desktop
/// ```
class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    super.key,
    required this.maxWidth,
    required this.child,
    this.alignment = Alignment.topCenter,
    this.backgroundColor,
  });

  final double maxWidth;
  final Widget child;
  final AlignmentGeometry alignment;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final content = Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
    if (backgroundColor == null) return content;
    return ColoredBox(color: backgroundColor!, child: content);
  }
}
