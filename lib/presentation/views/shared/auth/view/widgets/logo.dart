import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';

import '../../../../../res/color_manager.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.svg.appLogo.path,
      width: 155.w,
      colorFilter: ColorFilter.mode(ColorM.primary700, BlendMode.srcIn),
    ).premiumAppear(index: 0);
  }
}
