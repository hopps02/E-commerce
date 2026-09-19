import 'package:store/presentation/res/sizes_manager.dart';

// dart format off

/// Every corner in the app comes from here.
///
/// There is one corner — the store's own, set from the panel — and the rest
/// are steps away from it. Round that one and the whole app rounds with it;
/// sharpen it and everything sharpens, in proportion, without a screen being
/// touched.
///
/// The steps are eight apart, the same eight the spacing breathes in.
abstract class RadiusM {
  /// The store's corner. [SizeM.commonBorderRadius] is what the panel moves.
  static double get base => SizeM.commonBorderRadius;

  /// 8 by default — a badge, a small chip, a tag.
  ///
  /// The small steps fall away with the base rather than sitting below it:
  /// a store that asks for square corners gets square corners everywhere.
  static double get xs => base >= 12 ? base - 8 : base / 2;

  /// 12 — a photo, a block inside a card, a soft edge.
  static double get sm => base >= 12 ? base - 4 : base * 0.75;

  /// 16 — the everyday corner: cards, inputs, buttons.
  static double get md => base;

  /// 24 — a sheet that slides up, a panel that owns the screen.
  static double get lg => base + 8;

  /// 32 — a large, deliberately round container.
  static double get xl => base + 16;

  /// A fully rounded end, whatever the height is.
  static const double pill = 9999;
}
