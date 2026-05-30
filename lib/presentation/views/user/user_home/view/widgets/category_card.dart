import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Function() onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      width: 109.w,
      height: 112.h,
      backgroundColor: ColorM.lightGreen,
      borderRadius: 12.r,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  style: context.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorM.gray900,
                    fontSize: 13.sp,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                4.verticalSpace,
                Text(
                  subtitle,
                  style: context.labelSmall.copyWith(
                    color: ColorM.gray600,
                    fontSize: 10.sp,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 0.h,
            start: 0,
            end: -30.w,
            child: Image.asset(imagePath, height: 55.h, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
