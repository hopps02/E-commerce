/// Width-based form factor, independent of the real platform.
///
/// A narrow browser window on a desktop machine is [ScreenSize.mobile]; a
/// large tablet in landscape can be [ScreenSize.desktop]. Ordered smallest to
/// largest so `.index` comparisons (`>=`, `<=`) are meaningful.
enum ScreenSize { watch, mobile, tablet, desktop, largeDesktop }

/// Breakpoint configuration. Tune every threshold from one place, then pass a
/// custom instance to `ResponsiveScope(config: ...)`.
///
/// Each value is the *exclusive upper bound* of a tier:
///   width <  [watchMaxWidth]   -> watch
///   width <  [mobileMaxWidth]  -> mobile
///   width <  [tabletMaxWidth]  -> tablet
///   width <  [desktopMaxWidth] -> desktop
///   otherwise                  -> largeDesktop
class ResponsiveConfig {
  const ResponsiveConfig({
    this.watchMaxWidth = 360,
    this.mobileMaxWidth = 600,
    this.tabletMaxWidth = 1024,
    this.desktopMaxWidth = 1440,
  });

  final double watchMaxWidth;
  final double mobileMaxWidth;
  final double tabletMaxWidth;
  final double desktopMaxWidth;

  ScreenSize sizeForWidth(double width) {
    if (width < watchMaxWidth) return ScreenSize.watch;
    if (width < mobileMaxWidth) return ScreenSize.mobile;
    if (width < tabletMaxWidth) return ScreenSize.tablet;
    if (width < desktopMaxWidth) return ScreenSize.desktop;
    return ScreenSize.largeDesktop;
  }

  ResponsiveConfig copyWith({
    double? watchMaxWidth,
    double? mobileMaxWidth,
    double? tabletMaxWidth,
    double? desktopMaxWidth,
  }) {
    return ResponsiveConfig(
      watchMaxWidth: watchMaxWidth ?? this.watchMaxWidth,
      mobileMaxWidth: mobileMaxWidth ?? this.mobileMaxWidth,
      tabletMaxWidth: tabletMaxWidth ?? this.tabletMaxWidth,
      desktopMaxWidth: desktopMaxWidth ?? this.desktopMaxWidth,
    );
  }
}
