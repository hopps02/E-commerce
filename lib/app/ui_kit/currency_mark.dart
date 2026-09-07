import 'package:flutter/material.dart';

/// The currency mark that sits beside every price.
///
/// Egypt writes its currency as an abbreviation rather than a glyph, so this is
/// text: it picks up the app's Arabic face, scales with [size], and takes only
/// the width the two letters need. It replaced an SVG that flutter_svg could
/// not draw — the renderer ignores `<text>` elements, so the mark silently
/// vanished and prices read as bare numbers.
class CurrencyMark extends StatelessWidget {
  const CurrencyMark({super.key, required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      'ج.م',
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.w600,
        height: 1,
      ),
    );
  }
}
