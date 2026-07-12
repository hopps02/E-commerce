import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/direction.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onNext;
  final VoidCallback onLogin;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    required this.onNext,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisAlignment: .end,
        crossAxisAlignment: .start,
        children: [
          DisplayedText(title: title, description: description),

          SizedBox(height: 32.h),

          Buttons(onNext: onNext, onLogin: onLogin),

          SizedBox(height: context.bottomSafeAreaPadding + 15.h),
        ],
      ),
    );
  }
}

class DisplayedText extends StatelessWidget {
  const DisplayedText({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      spacing: 8.h,
      children: [
        Text(
          title,
          style: context.labelLarge.copyWith(
            fontSize: 28.sp,
            fontWeight: .bold,
            color: ColorM.white,
            height: 1.5,
          ),
        ).premiumAppear(index: 0),
        Text(
          description,
          style: context.bodyLarge.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeightM.medium,
            color: ColorM.gray300,
            height: 1.5,
          ),
        ).premiumAppear(index: 1),
      ],
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key, required this.onNext, required this.onLogin});

  final VoidCallback onNext;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15.w,
      children: [
        Expanded(
          child: CustomInkButton(
            onTap: onNext,
            backgroundColor: ColorM.white,
            borderRadius: SizeM.commonBorderRadius.r,
            height: 52.h,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4.w,
              children: [
                Text(
                  Translation.next.tr,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeightM.medium,
                    color: ColorM.gray800,
                  ),
                ),
                Direction(
                  init: .ltr,
                  child: SvgPicture.asset(
                    Assets.svg.arrowLeftLong.path,
                    width: 20.r,
                    height: 20.r,
                    colorFilter: ColorFilter.mode(
                      ColorM.gray800,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ).premiumAppear(index: 2),
        ),

        Expanded(
          child: CustomInkButton(
            onTap: onLogin,
            backgroundColor: ColorM.primary900,
            borderRadius: SizeM.commonBorderRadius.r,
            height: 52.h,
            alignment: Alignment.center,
            side: GradientBorderSide(color: ColorM.primary700, width: 1.w),
            child: Text(
              Translation.login.tr,
              style: context.bodyLarge.copyWith(
                fontWeight: FontWeightM.medium,
                color: ColorM.white,
              ),
            ),
          ).premiumAppear(index: 3),
        ),
      ],
    );
  }
}
