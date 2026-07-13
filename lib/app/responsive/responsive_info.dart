import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'app_platform.dart';
import 'responsive_config.dart';

/// An immutable snapshot of the current responsive state: both the real
/// [platform] axis and the size-based [screenSize] axis, plus orientation and
/// raw dimensions. Read it via `context.responsive`.
///
/// The two axes are independent on purpose — you can branch on either or both:
///   if (info.isWeb && info.isDesktopSize) ...   // web, wide window
///   if (info.isMobilePlatform) ...              // real phone, any size
@immutable
class ResponsiveInfo {
  const ResponsiveInfo({
    required this.platform,
    required this.hostTargetPlatform,
    required this.screenSize,
    required this.orientation,
    required this.size,
    required this.pixelRatio,
  });

  /// Builds an info from a context, using [LayoutBuilder] constraints when
  /// available and falling back to `MediaQuery`/`View`. Used by `ResponsiveScope`
  /// and by the context extension when no scope is present.
  factory ResponsiveInfo.resolve(
    BuildContext context,
    ResponsiveConfig config, {
    Size? sizeOverride,
  }) {
    final mq = MediaQuery.maybeOf(context);
    final view = View.maybeOf(context);
    final size = sizeOverride ??
        mq?.size ??
        (view != null ? view.physicalSize / view.devicePixelRatio : Size.zero);
    final pixelRatio = mq?.devicePixelRatio ?? view?.devicePixelRatio ?? 1.0;

    return ResponsiveInfo(
      platform: currentAppPlatform(),
      hostTargetPlatform: defaultTargetPlatform,
      screenSize: config.sizeForWidth(size.width),
      orientation:
          size.width >= size.height ? Orientation.landscape : Orientation.portrait,
      size: size,
      pixelRatio: pixelRatio,
    );
  }

  /// Real runtime platform ([AppPlatform.web] wins on web).
  final AppPlatform platform;

  /// The OS behind the current target — on web this is the browser's host OS
  /// (e.g. iOS in mobile Safari); off web it matches [platform].
  final TargetPlatform hostTargetPlatform;

  /// Width-based form factor.
  final ScreenSize screenSize;

  final Orientation orientation;

  /// Logical size the responsive decision was made against (the wrapped box's
  /// constraints inside `ResponsiveScope`).
  final Size size;

  final double pixelRatio;

  double get width => size.width;
  double get height => size.height;

  // ---- Platform axis ---------------------------------------------------------
  bool get isWeb => platform == AppPlatform.web;
  bool get isAndroid => platform == AppPlatform.android;
  bool get isIOS => platform == AppPlatform.ios;
  bool get isWindows => platform == AppPlatform.windows;
  bool get isMacOS => platform == AppPlatform.macos;
  bool get isLinux => platform == AppPlatform.linux;
  bool get isFuchsia => platform == AppPlatform.fuchsia;

  /// A native mobile OS build (Android/iOS). Does NOT include web.
  bool get isMobilePlatform => isAndroid || isIOS;

  /// A native desktop OS build (Windows/macOS/Linux). Does NOT include web.
  bool get isDesktopPlatform => isWindows || isMacOS || isLinux;

  // ---- Size axis -------------------------------------------------------------
  bool get isWatchSize => screenSize == ScreenSize.watch;
  bool get isMobileSize => screenSize == ScreenSize.mobile;
  bool get isTabletSize => screenSize == ScreenSize.tablet;
  bool get isDesktopSize => screenSize == ScreenSize.desktop;
  bool get isLargeDesktopSize => screenSize == ScreenSize.largeDesktop;

  /// watch + mobile — anything a phone-sized layout targets.
  bool get isHandsetSize => screenSize.index <= ScreenSize.mobile.index;
  bool get isAtLeastTablet => screenSize.index >= ScreenSize.tablet.index;
  bool get isAtLeastDesktop => screenSize.index >= ScreenSize.desktop.index;

  // ---- Orientation -----------------------------------------------------------
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  // ---- Selectors -------------------------------------------------------------

  /// Pick a value by form factor. [mobile] is the required base; any unspecified
  /// tier falls back toward [mobile] (larger tiers cascade down through the
  /// smaller specified ones).
  T bySize<T>({
    T? watch,
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    switch (screenSize) {
      case ScreenSize.watch:
        return watch ?? mobile;
      case ScreenSize.mobile:
        return mobile;
      case ScreenSize.tablet:
        return tablet ?? mobile;
      case ScreenSize.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenSize.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile;
    }
  }

  /// Pick a value by real platform. Resolution order for each platform:
  /// specific value -> group ([mobile]/[desktop]) -> [fallback].
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
  }) {
    switch (platform) {
      case AppPlatform.web:
        return web ?? fallback;
      case AppPlatform.android:
        return android ?? mobile ?? fallback;
      case AppPlatform.ios:
        return ios ?? mobile ?? fallback;
      case AppPlatform.windows:
        return windows ?? desktop ?? fallback;
      case AppPlatform.macos:
        return macos ?? desktop ?? fallback;
      case AppPlatform.linux:
        return linux ?? desktop ?? fallback;
      case AppPlatform.fuchsia:
        return fallback;
    }
  }

  @override
  bool operator ==(Object other) =>
      other is ResponsiveInfo &&
      other.platform == platform &&
      other.hostTargetPlatform == hostTargetPlatform &&
      other.screenSize == screenSize &&
      other.orientation == orientation &&
      other.size == size &&
      other.pixelRatio == pixelRatio;

  @override
  int get hashCode => Object.hash(
        platform,
        hostTargetPlatform,
        screenSize,
        orientation,
        size,
        pixelRatio,
      );

  @override
  String toString() =>
      'ResponsiveInfo(platform: $platform, screenSize: $screenSize, '
      'orientation: $orientation, size: $size)';
}
