import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/ui_kit/currency_mark.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/custom_cached_image.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class Order extends StatelessWidget {
  final String title;
  final String weight;
  final String price;
  final String count;
  final String image;

  /// Set where the row leads somewhere: the order screens open the product.
  final VoidCallback? onTap;

  const Order({
    super.key,
    required this.title,
    required this.weight,
    required this.price,
    required this.count,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final row = Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: ColorM.white),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          // Image Thumbnail (Back to original size)
          Container(
            width: 73,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: ColorM.gray150, width: 1.w),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(SpaceM.s2.w),
            child: CustomCachedImage(imageUrl: image, fit: BoxFit.contain),
          ),

          SpaceM.s3.horizontalSpace,

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    color: ColorM.gray950,
                    fontWeight: FontWeightM.medium,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SpaceM.s4.verticalSpace,
                Row(
                  children: [
                    // Weight (sizes live inside product names, so this chip
                    // only renders when a value is actually provided)
                    if (weight.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SpaceM.s2,
                          vertical: SpaceM.s1,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorM.gray200, width: 1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          weight,
                          style: context.labelMedium.copyWith(
                            fontWeight: FontWeightM.semiBold,
                          ),
                        ),
                      ),
                    const Spacer(),
                    // Price & Count in the same row
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "x$count",
                          style: context.labelSmall.copyWith(
                            color: ColorM.gray400,
                            fontWeight: FontWeightM.medium,
                          ),
                        ),
                        SpaceM.s2.horizontalSpace,
                        Text(
                          price,
                          style: context.bodyLarge.copyWith(
                            color: ColorM.primary700,
                            fontWeight: FontWeightM.semiBold,
                          ),
                        ),
                        SpaceM.s1.horizontalSpace,
                        CurrencyMark(size: 11, color: ColorM.primary700),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return row;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: row,
    );
  }
}
