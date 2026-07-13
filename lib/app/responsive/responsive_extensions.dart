import 'package:flutter/widgets.dart';

import 'app_platform.dart';
import 'responsive_config.dart';
import 'responsive_info.dart';
import 'responsive_scope.dart';

/// Ergonomic access to the responsive engine from any [BuildContext].
///
/// Get the full snapshot with `context.responsive`, or use the shortcuts below.
/// Raw width/height live on the snapshot (`context.responsive.width`) to avoid
/// clashing with the app's existing `screenWidth`/`screenHeight` getters.
extension ResponsiveContextX on BuildContext {
  /// Full responsive snapshot (both axes + orientation + size).
  ResponsiveInfo get responsive => responsiveInfoOf(this);

  // ---- Axes ------------------------------------------------------------------
  ScreenSize get screenSize => responsive.screenSize;
  AppPlatform get platform => responsive.platform;
  Orientation get screenOrientation => responsive.orientation;

  // ---- Platform axis ---------------------------------------------------------
  bool get isWeb => responsive.isWeb;
  bool get isAndroid => responsive.isAndroid;
  bool get isIOS => responsive.isIOS;
  bool get isWindows => responsive.isWindows;
  bool get isMacOS => responsive.isMacOS;
  bool get isLinux => responsive.isLinux;
  bool get isMobilePlatform => responsive.isMobilePlatform;
  bool get isDesktopPlatform => responsive.isDesktopPlatform;

  // ---- Size axis -------------------------------------------------------------
  bool get isWatchSize => responsive.isWatchSize;
  bool get isMobileSize => responsive.isMobileSize;
  bool get isTabletSize => responsive.isTabletSize;
  bool get isDesktopSize => responsive.isDesktopSize;
  bool get isLargeDesktopSize => responsive.isLargeDesktopSize;
  bool get isHandsetSize => responsive.isHandsetSize;
  bool get isAtLeastTablet => responsive.isAtLeastTablet;
  bool get isAtLeastDesktop => responsive.isAtLeastDesktop;

  // ---- Orientation -----------------------------------------------------------
  bool get isPortrait => responsive.isPortrait;
  bool get isLandscape => responsive.isLandscape;

  // ---- Selectors -------------------------------------------------------------

  /// Pick a value by form factor. See [ResponsiveInfo.bySize].
  T bySize<T>({
    T? watch,
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) =>
      responsive.bySize(
        watch: watch,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      );

  /// Pick a value by real platform. See [ResponsiveInfo.byPlatform].
  T byPlatform<T>({
    T? web,
    T? android,
    T? ios,
    T? windows,
    T? macos,
    T? linux,
    T? mobile,
    T? desktop,
    required T fallback,
  }) =>
      responsive.byPlatform(
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
}
