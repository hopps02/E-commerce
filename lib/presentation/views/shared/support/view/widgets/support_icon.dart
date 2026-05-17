import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';

class SupportIcon extends StatelessWidget {
  const SupportIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: Assets.svg.coloredArrow.svg(
        width: 120.w,
        height: 120.w,
        fit: BoxFit.contain,
      ),
    );
  }
}
