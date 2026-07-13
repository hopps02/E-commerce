import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Presents the mobile UI inside a centred, phone-width frame on wide web
/// windows so the app doesn't stretch edge-to-edge on desktop browsers.
///
/// The app is built mobile-first with `flutter_screenutil`, whose scale factor
/// is derived from the real window width. Left alone, a desktop browser makes
/// every `.w`/`.sp`/`.sh` value scale off a ~1400px window and the UI looks
/// huge. Here we clamp the size screenutil (and `MediaQuery`) see to a phone
/// width, then centre that frame on a neutral backdrop.
///
/// On real phones and narrow browser windows (width <= [maxWidth]) this is a
/// no-op passthrough, so mobile behaviour is unchanged.
class ResponsiveWebFrame extends StatelessWidget {
  const ResponsiveWebFrame({
    super.key,
    required this.child,
    required this.designSize,
    this.maxWidth = 460,
  });

  final Widget child;

  /// Must match the `designSize` passed to `ScreenUtilInit` so the re-config
  /// keeps the same design baseline.
  final Size designSize;

  /// Frame width used on wide screens; also the threshold below which the
  /// frame is disabled and the app fills the window normally.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // Real phones / narrow browser windows: leave the app untouched.
    if (!kIsWeb || size.width <= maxWidth) return child;

    final frameSize = Size(maxWidth, size.height);
    final clampedMediaQuery = MediaQuery.of(context).copyWith(size: frameSize);

    // Re-point screenutil at the phone-width frame so .w/.sp/.sh scale as they
    // do on a device, not off the full desktop window. This runs below
    // ScreenUtilInit's own configure() in the same build pass, so screens
    // below us read this (clamped) config.
    ScreenUtil.configure(data: clampedMediaQuery, designSize: designSize);

    return ColoredBox(
      color: const Color(0xFFE9EAEC),
      child: Center(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: SizedBox(
            width: maxWidth,
            height: size.height,
            child: MediaQuery(data: clampedMediaQuery, child: child),
          ),
        ),
      ),
    );
  }
}
