import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/user_home/riverpod/profile_controller.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class ProfileInfo extends ConsumerWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileController);
    return GeneralPadding(
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(
            Translation.profile.tr,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeightM.bold,
              color: ColorM.gray900,
            ),
          ),
          SpaceM.s8.verticalSpace,
          Container(
            height: 86,
            width: 86,
            decoration: BoxDecoration(
              color: ColorM.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorM.primary200.withValues(alpha: 0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: ColorM.primary100, width: 2),
            ),
            alignment: Alignment.center,
            child: Container(
              height: 76,
              width: 76,
              decoration: BoxDecoration(
                color: ColorM.primary50,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                profile.initial,
                style: context.headlineMedium.copyWith(
                  color: ColorM.primary500,
                  fontWeight: FontWeightM.bold,
                ),
              ),
            ),
          ),
          SpaceM.s5.verticalSpace,
          Text(
            profile.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: context.headlineSmall.copyWith(
              fontWeight: FontWeightM.bold,
              color: ColorM.gray900,
            ),
          ),
          SpaceM.s2.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: SpaceM.s4, vertical: SpaceM.s2.h),
            decoration: BoxDecoration(
              color: ColorM.gray50,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              profile.phone,
              textDirection: TextDirection.ltr,
              style: context.bodyLarge.copyWith(
                color: ColorM.gray500,
                fontWeight: FontWeightM.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
