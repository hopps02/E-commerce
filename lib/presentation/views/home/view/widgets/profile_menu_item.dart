import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';

class ProfileMenuItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final bool isDestructive;
  final bool showArrow;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      borderRadius: 0,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
      child: Row(
        children: [
          Container(padding: EdgeInsets.all(8.dg), child: icon),
          4.horizontalSpace,
          Expanded(
            child: Text(
              title,
              style: context.titleMedium.copyWith(
                fontWeight: FontWeightM.medium,
                color: isDestructive ? ColorM.red : ColorM.gray900,
                fontSize: 16.sp,
              ),
            ),
          ),
          if (showArrow)
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.w,
              color: ColorM.gray900,
            ),
        ],
      ),
    );
  }
}
