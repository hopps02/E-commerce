import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

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
          : GradientBorderSide(color: ColorM.primary50, width: 1),
      borderRadius: RadiusM.xl.r,
      padding: EdgeInsets.symmetric(horizontal: SpaceM.s6, vertical: SpaceM.s2.h),
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
