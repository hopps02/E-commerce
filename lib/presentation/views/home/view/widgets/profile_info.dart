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
          style: context.titleLarge.copyWith(
            fontWeight: FontWeightM.bold,
            color: ColorM.gray900,
          ),
        ),
        32.verticalSpace,
        Container(
          height: 86.w,
          width: 86.w,
          decoration: BoxDecoration(
            color: ColorM.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorM.primary200.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: ColorM.primary100, width: 2),
          ),
          alignment: Alignment.center,
          child: Container(
            height: 76.w,
            width: 76.w,
            decoration: const BoxDecoration(
              color: ColorM.primary50,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'L',
              style: context.headlineMedium.copyWith(
                color: ColorM.primary500,
                fontWeight: FontWeightM.bold,
              ),
            ),
          ),
        ),
        20.verticalSpace,
        Text(
          'Leonardo',
          style: context.headlineSmall.copyWith(
            fontWeight: FontWeightM.bold,
            color: ColorM.gray900,
          ),
        ),
        6.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: ColorM.gray50,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            'Leonardo@gmail.com',
            style: context.bodyLarge.copyWith(
              color: ColorM.gray500,
              fontWeight: FontWeightM.medium,
            ),
          ),
        ),
      ],
    );
  }
}
