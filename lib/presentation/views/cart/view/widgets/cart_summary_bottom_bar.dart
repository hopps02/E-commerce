import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/app/ui_components/direction.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class CartSummaryBottomBar extends StatelessWidget {
  final double totalProducts;
  final double shippingCost;
  final double discount;
  final VoidCallback onCheckout;

  const CartSummaryBottomBar({
    super.key,
    required this.totalProducts,
    required this.shippingCost,
    required this.discount,
    required this.onCheckout,
  });

  double get totalAmount => (totalProducts + shippingCost) - discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorM.white,
        boxShadow: [
          BoxShadow(
            color: ColorM.gray900.withValues(alpha: 0.04),
            blurRadius: 31, // Same as product details
            offset: Offset(0, -17.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price Summary Title
                Text(
                  Translation.price_summary.tr,
                  style: context.bodyLarge.copyWith(
                    color: ColorM.gray900,
                    fontWeight: FontWeightM.medium,
                  ),
                ),
                10.verticalSpace,

                // Summary Items
                _SummaryRow(
                  title: Translation.total_products.tr,
                  price: totalProducts,
                ),
                6.verticalSpace,
                _SummaryRow(
                  title: Translation.shipping_cost.tr,
                  price: shippingCost,
                ),
                6.verticalSpace,
                _SummaryRow(title: Translation.discount.tr, price: discount),

                10.verticalSpace,

                // Divider
                Divider(color: const Color(0xFFDFDFDF), height: 1.h),

                10.verticalSpace,

                // Total Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translation.total_amount.tr,
                      style: context.titleMedium.copyWith(
                        color: ColorM.gray900,
                        fontWeight: FontWeightM.medium,
                      ),
                    ),
                    _PriceWidget(
                      price: totalAmount,
                      color: ColorM.primary700,
                      fontWeight: FontWeightM.semiBold,
                    ),
                  ],
                ),

                20.verticalSpace,

                // Checkout Button
                CustomInkButton(
                  onTap: onCheckout,
                  width: double.infinity,
                  height: 56.h,
                  backgroundColor: ColorM.primary,
                  borderRadius: 16.r,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // View Cart text + Icon (Right side in RTL)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.w,
                        children: [
                          Text(
                            Translation
                                .checkout
                                .tr, // Figma uses view_cart text here too
                            style: context.bodyLarge.copyWith(
                              color: ColorM.white,
                              fontWeight: FontWeightM.medium,
                            ),
                          ),
                          Icon(
                            Icons.arrow_back_ios,
                            textDirection: Directionality.of(context) == TextDirection.rtl
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                            size: 20.sp,
                            color: ColorM.white,
                          ),
                        ],
                      ),
                      // Price (Left side in RTL)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 3.w,
                        children: [
                          Text(
                            "$totalAmount",
                            style: context.titleLarge.copyWith(
                              color: ColorM.white,
                              fontWeight: FontWeightM.semiBold,
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.svg.saudiRiyalSymbol.path,
                            width: 15.sp,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Safe Area spacing
          SizedBox(height: context.bottomSafeAreaPadding),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final double price;

  const _SummaryRow({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.bodyLarge.copyWith(
            color: ColorM.gray600,
            fontWeight: FontWeightM.regular,
          ),
        ),
        _PriceWidget(
          price: price,
          color: ColorM.gray600,
          fontWeight: FontWeightM.medium,
        ),
      ],
    );
  }
}

class _PriceWidget extends StatelessWidget {
  final double price;
  final Color color;
  final FontWeight fontWeight;

  const _PriceWidget({
    required this.price,
    required this.color,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 3.w,
      children: [
        Text(
          "${price % 1 == 0 ? price.toInt() : price}",
          style: context.bodyLarge.copyWith(
            color: color,
            fontWeight: fontWeight,
          ),
        ),
        SvgPicture.asset(
          Assets.svg.saudiRiyalSymbol.path,
          width: 12.w,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ],
    );
  }
}
