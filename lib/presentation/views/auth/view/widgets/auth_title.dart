import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Text(
          Translation.login.tr,
          style: context.titleLarge.copyWith(fontWeight: FontWeightM.semiBold),
        ).pluseAnimation(4),
        6.verticalSpace,
        Text(
          Translation.enter_mobile_to_continue.tr,
          style: context.bodyMedium.copyWith(
            fontSize: 15.sp,
            color: ColorM.gray500,
          ),
        ).pluseAnimation(3),
      ],
    );
  }
}
