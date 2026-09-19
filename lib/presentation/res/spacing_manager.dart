// dart format off

/// Every gap in the app comes from here.
///
/// The scale is a 4px grid: a step is 4, and the app breathes in eights —
/// 8, 16, 24, 32. A token is named by how many steps it is, so [s4] is four
/// steps, sixteen pixels. Nothing in between is allowed: a 10 or an 18 is
/// what makes two screens look almost but not quite alike.
///
/// The names under the scale say what a step is *for*. Prefer them: when a
/// screen says [section] instead of 24, every screen that says [section]
/// moves together the day that rhythm changes.
abstract class SpaceM {
  /// 4 — a hairline gap, between two lines of the same thought.
  static const double s1  = 4;
  /// 8 — inside a component: an icon and its word, a label and its field.
  static const double s2  = 8;
  /// 12 — between rows of one list, or a heading and what it introduces.
  static const double s3  = 12;
  /// 16 — the everyday gap: a screen's gutter, a card's padding.
  static const double s4  = 16;
  /// 20 — a wide gap inside a block that is already roomy.
  static const double s5  = 20;
  /// 24 — between two sections of a screen.
  static const double s6  = 24;
  /// 28 — a section gap where the two sides carry a lot of ink.
  static const double s7  = 28;
  /// 32 — between parts of a screen that are barely related.
  static const double s8  = 32;
  /// 40 — around a single thing standing on its own.
  static const double s10 = 40;
  /// 48 — the breath before a closing action.
  static const double s12 = 48;
  /// 64 — the clearance a floating bar needs above the content it covers.
  static const double s16 = 64;

  // --- what each step is for -------------------------------------------------

  /// The gutter every screen keeps from the edge of the phone.
  static const double page       = s4;

  /// Between two sections of a screen.
  static const double section    = s6;

  /// From a card's edge to what is inside it.
  static const double card       = s4;

  /// Between a heading and the thing it introduces.
  static const double heading    = s3;

  /// Between rows of the same list.
  static const double row        = s3;

  /// Between an icon and the word beside it.
  static const double icon       = s2;

  /// Between a field's label and the field.
  static const double label      = s2;

  /// Inside a chip, a badge, a small pill.
  static const double chip       = s2;

  /// Under the last thing on a scrolling screen, so the floating bar never
  /// sits on top of it. The safe area is added on top of this.
  static const double bottomBar  = s16;
}
