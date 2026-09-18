/// How much of something — and how the app steps it.
///
/// Countable things move one at a time; a kilo of tomatoes moves in quarters.
/// Every product carries its own step, so the plus and minus buttons only ever
/// land on amounts the store actually sells.
class Quantity {
  const Quantity._();

  static const int scale = 3;

  /// "1.5", "2" — three decimals at most, trailing zeros gone.
  static String format(double value) {
    final rounded = _round(value);

    return rounded == rounded.roundToDouble()
        ? rounded.toInt().toString()
        : rounded.toString();
  }

  /// Rounds onto the product's step, never below zero.
  static double snap(double value, double step) {
    if (step <= 0) return _round(value);
    if (value <= 0) return 0;

    return _round((value / step).round() * step);
  }

  /// One step up, kept on the grid.
  static double next(double value, double step) =>
      snap(value + (step <= 0 ? 1 : step), step);

  /// One step down; reaching zero means the line goes.
  static double previous(double value, double step) {
    final lowered = value - (step <= 0 ? 1 : step);

    return lowered <= 0 ? 0 : snap(lowered, step);
  }

  static double _round(double value) =>
      double.parse(value.toStringAsFixed(scale));
}
