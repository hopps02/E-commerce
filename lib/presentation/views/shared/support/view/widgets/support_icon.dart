import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';

class SupportIcon extends StatelessWidget {
  const SupportIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Assets.svg.coloredArrow.svg(
        width: 120,
        height: 120,
        fit: BoxFit.contain,
      ),
    );
  }
}
