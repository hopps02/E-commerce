import 'package:flutter/widgets.dart';

import 'responsive_config.dart';
import 'responsive_info.dart';

/// Wrap this once around your app (like `ScreenUtilInit`) to power the whole
/// responsive engine. It measures the available space with a [LayoutBuilder]
/// and publishes a [ResponsiveInfo] down the tree via an [InheritedWidget], so
/// `context.responsive` reads are cheap and rebuild only when the form factor,
/// platform, orientation, or size actually change.
///
/// Placement: it needs no `MediaQuery` ancestor (it reads the box constraints),
/// so it works whether you put it above `MaterialApp`, around `ScreenUtilInit`,
/// or inside `MaterialApp.builder`. Putting it high (e.g. wrapping the app in
/// `main`) makes `context.responsive` available on every route.
///
/// The engine still works without this scope — the context extension falls back
/// to `MediaQuery` — but wrapping is recommended for performance and to make
/// [LayoutBuilder] constraints (not the raw window) the source of truth.
class ResponsiveScope extends StatelessWidget {
  const ResponsiveScope({
    super.key,
    required this.child,
    this.config = const ResponsiveConfig(),
  });

  final Widget child;

  /// Breakpoints for this scope. Override to retune the tiers app-wide.
  final ResponsiveConfig config;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(
          constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : MediaQuery.maybeOf(context)?.size.width ?? 0,
          constraints.maxHeight.isFinite
              ? constraints.maxHeight
              : MediaQuery.maybeOf(context)?.size.height ?? 0,
        );
        final info = ResponsiveInfo.resolve(context, config, sizeOverride: size);
        return InheritedResponsive(info: info, config: config, child: child);
      },
    );
  }
}

/// Carries the [ResponsiveInfo] down the tree. Prefer reading it through
/// `context.responsive`; this is exposed for advanced/manual lookups.
class InheritedResponsive extends InheritedWidget {
  const InheritedResponsive({
    super.key,
    required this.info,
    required this.config,
    required super.child,
  });

  final ResponsiveInfo info;
  final ResponsiveConfig config;

  static InheritedResponsive? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedResponsive>();

  @override
  bool updateShouldNotify(InheritedResponsive oldWidget) =>
      info != oldWidget.info;
}

/// Resolves the active [ResponsiveInfo] for [context]. Uses the nearest
/// [ResponsiveScope] when present; otherwise computes on the fly from
/// `MediaQuery`/`View` so it never throws even without a scope.
ResponsiveInfo responsiveInfoOf(BuildContext context) {
  final inherited = InheritedResponsive.maybeOf(context);
  if (inherited != null) return inherited.info;
  return ResponsiveInfo.resolve(context, const ResponsiveConfig());
}
