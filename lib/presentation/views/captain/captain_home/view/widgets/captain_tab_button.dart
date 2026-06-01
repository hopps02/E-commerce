import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';

class CaptainTabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CaptainTabButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomInkButton(
        onTap: onTap,
        borderRadius: 29.r,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        height: 42.h,
        tap: const ButtonAnimationSettings(
          ButtonAnimation.scaleTap,
          intensity: .2,
        ),
        backgroundColor: isSelected ? ColorM.primary500 : ColorM.white,
        side: isSelected
            ? GradientBorderSide.none
            : const GradientBorderSide(color: ColorM.primary50, width: 1),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: context.labelMedium.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeightM.semiBold,
              color: isSelected ? ColorM.white : ColorM.gray800,
              height: 20 / 12,
            ),
          ),
        ),
      ),
    );
  }
}
