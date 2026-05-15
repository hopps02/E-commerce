import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

/// "عن المنتج" description section from Figma
class ProductDescription extends StatelessWidget {
  final String description;

  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.about_product.tr,
            style: context.bodyLarge.copyWith(
              color: ColorM.gray800,
              fontWeight: FontWeightM.medium,
            ),
          ),
          11.verticalSpace,
          Text(
            description,
            style: context.bodyMedium.copyWith(
              color: ColorM.gray600,
              height: 1.5,
              fontWeight: FontWeightM.regular,
            ),
          ),
        ],
      ),
    );
  }
}
