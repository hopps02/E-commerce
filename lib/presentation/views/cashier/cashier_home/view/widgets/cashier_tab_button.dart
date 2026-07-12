import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';

class CashierTabButton extends StatelessWidget {
  final String title;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const CashierTabButton({
    super.key,
    required this.title,
    required this.count,
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
        backgroundColor: isSelected ? ColorM.primary600 : ColorM.white,
        side: isSelected
            ? GradientBorderSide.none
            : const GradientBorderSide(color: ColorM.primary50, width: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: context.labelMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeightM.semiBold,
                  color: isSelected ? ColorM.white : ColorM.gray800,
                  height: 20 / 14,
                ),
              ),
            ),
            4.horizontalSpace,
            _CountBadge(count: count),
          ],
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  const _CountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14.r,
      height: 14.r,
      decoration: BoxDecoration(
        color: ColorM.primary100,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: TextStyle(
          fontSize: 8.sp,
          fontWeight: FontWeightM.regular,
          color: ColorM.primary500,
          height: 1,
        ),
      ),
    );
  }
}
