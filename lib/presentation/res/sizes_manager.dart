import 'package:store/presentation/res/spacing_manager.dart';
/// Sizes of things. Gaps between them live in [SpaceM].
abstract class SizeM {
  /// The screen gutter, kept here for the screens that already ask for it
  /// by this name. It is the spacing scale that decides the number.
  static const double pagePadding = SpaceM.page;
  static double commonBorderRadius = 16;
}
