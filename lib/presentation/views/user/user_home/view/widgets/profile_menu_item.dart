import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

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
    return Container(
      margin: EdgeInsets.only(bottom: SpaceM.s4.h),
      decoration: BoxDecoration(
        color: ColorM.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorM.gray200.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: ColorM.gray150, width: 1),
      ),
      child: CustomInkButton(
        onTap: onTap,
        borderRadius: 20.r,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: SpaceM.s4, horizontal: SpaceM.s4.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(SpaceM.s3.dg),
              decoration: BoxDecoration(
                color: isDestructive
                    ? ColorM.red.withOpacity(0.08)
                    : ColorM.primary50,
                shape: BoxShape.circle,
              ),
              child: icon,
            ),
            SpaceM.s4.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeightM.semiBold,
                  color: isDestructive ? ColorM.red : ColorM.gray900,
                  fontSize: 16,
                ),
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: ColorM.gray300,
              ),
          ],
        ),
      ),
    );
  }
}
