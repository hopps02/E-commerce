/// Responsive engine — two independent axes (real platform + width-based form
/// factor) with selectors and layout widgets for full per-target control.
///
/// Setup: wrap the app once in `ResponsiveScope` (see its docs for placement).
/// Then read `context.responsive` / the shortcuts, or use the layout widgets.
///
/// ```dart
/// import 'package:store/app/responsive/responsive.dart';
/// ```
library;

export 'app_platform.dart';
export 'responsive_config.dart';
export 'responsive_info.dart';
export 'responsive_scope.dart';
export 'responsive_extensions.dart';
export 'responsive_widgets.dart';
