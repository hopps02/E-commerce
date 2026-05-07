import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Text(
          Translation.profile.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        32.verticalSpace,

        Text(
          'Leonardo',
          style: context.headlineSmall.copyWith(
            fontWeight: FontWeightM.medium,
            color: ColorM.gray900,
          ),
        ),
        4.verticalSpace,
        Text(
          'Leonardo@gmail.com',
          style: context.bodyLarge.copyWith(color: ColorM.gray500),
        ),
      ],
    );
  }
}
