import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jar/app/extensions/widget_extensions.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.svg.appLogo.path,
      width: 155.w,
    ).premiumAppear(index: 0);
  }
}
