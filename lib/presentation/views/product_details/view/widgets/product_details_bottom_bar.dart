import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/app/ui_components/direction.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/product_details/riverpod/product_details_controller.dart';

/// Bottom bar: item count + "عرض السلة" button with price — matches Figma
class ProductDetailsBottomBar extends ConsumerWidget {
  final double price;
  final String productName;

  const ProductDetailsBottomBar({
    super.key,
    required this.price,
    required this.productName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity =
        ref.watch(productDetailsController.select((s) => s.quantity));

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        decoration: BoxDecoration(
          color: ColorM.white,
          boxShadow: [
            BoxShadow(
              color: ColorM.gray900.withValues(alpha: 0.04),
              blurRadius: 62,
              offset: Offset(0, -17.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: quantity == 0
                  ? _buildAddToCartButton(context, ref)
                  : _buildCartInfoAndViewButton(context, ref, quantity),
            ),
            SizedBox(height: context.bottomSafeAreaPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, WidgetRef ref) {
    return CustomInkButton(
      onTap: () =>
          ref.read(productDetailsController.notifier).incrementQuantity(),
      width: double.infinity,
      height: 56.h,
      borderRadius: 16.r,
      backgroundColor: ColorM.primary,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.w,
          children: [
            Icon(Icons.add_shopping_cart, color: ColorM.white, size: 22.sp),
            Text(
              Translation.add_to_cart.tr,
              style: context.bodyLarge.copyWith(
                color: ColorM.white,
                fontWeight: FontWeightM.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartInfoAndViewButton(
      BuildContext context, WidgetRef ref, int quantity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translation.product_count.trNamed({'count': '$quantity'}),
              style: context.bodyLarge.copyWith(
                fontWeight: FontWeightM.semiBold,
              ),
            ),
            1.verticalSpace,
            Text(
              productName,
              style: context.bodyMedium.copyWith(color: ColorM.gray700),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        16.verticalSpace,
        CustomInkButton(
          onTap: () {
            context.pushNamed(RoutesManager.cart.route);
          },
          width: double.infinity,
          height: 56.h,
          borderRadius: 16.r,
          backgroundColor: ColorM.primary,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4.w,
                children: [
                  Text(
                    Translation.view_cart.tr,
                    style: context.bodyLarge.copyWith(
                      color: ColorM.white,
                      fontWeight: FontWeightM.medium,
                    ),
                  ),
                  Icon(
                    Icons.arrow_back_ios,
                    textDirection:
                        Directionality.of(context) == TextDirection.rtl
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    size: 20.sp,
                    color: ColorM.white,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 3.w,
                children: [
                  Text(
                    (price * quantity).toStringAsFixed(2),
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
    );
  }
}
