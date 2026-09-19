import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class ProductInfoSection extends StatelessWidget {
  final String name;
  final bool isAvailable;

  /// Printed above the name when the product carries one: "Zara".
  final String brand;

  const ProductInfoSection({
    super.key,
    required this.name,
    this.isAvailable = true,
    this.brand = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SpaceM.s4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (brand.isNotEmpty) ...[
                  Text(
                    brand,
                    style: context.labelMedium.copyWith(
                      color: ColorM.gray500,
                      fontWeight: FontWeightM.medium,
                    ),
                  ),
                  SpaceM.s1.verticalSpace,
                ],
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.titleMedium.copyWith(
                    color: ColorM.gray950,
                    fontWeight: FontWeightM.bold,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          SpaceM.s3.horizontalSpace,
          _AvailabilityBadge(isAvailable: isAvailable),
        ],
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;
  const _AvailabilityBadge({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = isAvailable ? ColorM.primary500 : ColorM.red;
    final Color backgroundColor = isAvailable
        ? ColorM.primary50.withValues(alpha: 0.55)
        : ColorM.red.withValues(alpha: 0.08);

    return Container(
      padding: EdgeInsetsDirectional.only(
        start: SpaceM.s3,
        end: SpaceM.s3,
        top: SpaceM.s2,
        bottom: SpaceM.s2,
      ),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: SmoothRectangleBorder(
          smoothness: 0.8,
          borderRadius: BorderRadius.circular(99.r),
          side: GradientBorderSide(
            color: accentColor.withValues(alpha: 0.18),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: SpaceM.s2,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          Text(
            isAvailable ? Translation.available.tr : Translation.unavailable.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.labelMedium.copyWith(
              color: isAvailable ? ColorM.primary700 : ColorM.red,
              fontWeight: FontWeightM.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
