import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/custom_ink_button.dart';
import 'package:for_u/app/ui_components/gradient_border_side.dart';
import 'package:for_u/presentation/res/color_manager.dart';

class MyOrderTapButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String title;
  const MyOrderTapButton({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      backgroundColor: isSelected ? ColorM.primary600 : ColorM.white,
      side: isSelected
          ? GradientBorderSide.none
          : const GradientBorderSide(color: ColorM.primary50, width: 1),
      borderRadius: 29.r,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Text(
        title,
        style: context.labelMedium.copyWith(
          color: isSelected ? ColorM.white : ColorM.gray700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
