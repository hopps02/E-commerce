import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

/// Product name, availability badge, and price row — matches Figma section
class ProductInfoSection extends StatelessWidget {
  final String name;
  final double price;
  final double? oldPrice;
  final bool isAvailable;

  const ProductInfoSection({
    super.key,
    required this.name,
    required this.price,
    this.oldPrice,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Right side (start in RTL): Name + Prices
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product name
              Text(
                name,
                style: context.titleLarge.copyWith(
                  color: ColorM.gray1000,
                  fontWeight: FontWeightM.semiBold,
                ),
              ),
              9.verticalSpace,
              // Prices row (aligned to start for RTL)
              Row(
                mainAxisAlignment: .start,
                children: [
                  // Current price
                  _PriceTag(
                    price: price,
                    color: ColorM.primary550,
                    fontSize: 20.sp,
                    fontWeight: FontWeightM.semiBold,
                  ),
                  if (oldPrice != null) ...[
                    8.horizontalSpace,
                    // Old price (strikethrough)
                    _PriceTag(
                      price: oldPrice!,
                      color: ColorM.gray500,
                      fontSize: 16.sp,
                      fontWeight: FontWeightM.medium,
                      strikethrough: true,
                    ),
                  ],
                ],
              ),
            ],
          ),

          // Left side (end in RTL): Availability badge
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorM.primary50,
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(color: ColorM.primary100, width: 1.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          Container(
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(
              color: isAvailable ? ColorM.primary400 : ColorM.red,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          Text(
            isAvailable ? Translation.available.tr : Translation.unavailable.tr,
            style: context.bodySmall.copyWith(
              color: ColorM.primary400,
              fontWeight: FontWeightM.medium,
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final bool strikethrough;

  const _PriceTag({
    required this.price,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.strikethrough = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 3.w,
      children: [
        Text(
          "${price % 1 == 0 ? price.toInt() : price}",
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            decoration: strikethrough ? TextDecoration.lineThrough : null,
            decorationColor: color,
          ),
        ),
        SvgPicture.asset(
          Assets.svg.saudiRiyalSymbol.path,
          width: strikethrough ? 12.w : 14.w,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ],
    );
  }
}
