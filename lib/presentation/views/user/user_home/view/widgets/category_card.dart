import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

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
      width: 109,
      height: 112,
      backgroundColor: ColorM.lightGreen,
      borderRadius: RadiusM.sm.r,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(SpaceM.s2.r),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  style: context.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorM.gray900,
                    fontSize: 13,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                SpaceM.s1.verticalSpace,
                Text(
                  subtitle,
                  style: context.labelSmall.copyWith(
                    color: ColorM.gray600,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: -30,
            child: Image.asset(imagePath, height: 55, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
