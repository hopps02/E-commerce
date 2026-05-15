import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/custom_cached_image.dart';
import 'package:for_u/presentation/res/color_manager.dart';

class CategoryGridItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const CategoryGridItem({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CustomCachedImage(
            imageUrl: imageUrl,
            width: 70.w,
            height: 70.w,
            errorBackgroundColor: ColorM.gray50,
          ),
          8.verticalSpace,
          SizedBox(
            width: 70.w,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.labelMedium.copyWith(
                color: ColorM.gray900,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
