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

    return Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Count & product info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Translation.product_count.trNamed({'count': '2'}),
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

                // Cart button
                CustomInkButton(
                  onTap: () {
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
                          Direction(
                            init: .rtl,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20.sp,
                              color: ColorM.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 3.w,
                        children: [
                          Text(
                            price.toString(),
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
          // Home indicator safe area space
          SizedBox(height: context.bottomSafeAreaPadding),
        ],
      ),
    );
  }
}
