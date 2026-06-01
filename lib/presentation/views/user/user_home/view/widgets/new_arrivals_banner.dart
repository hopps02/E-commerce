import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class NewArrivalsBanner extends StatelessWidget {
  final VoidCallback? onShopNowTap;

  const NewArrivalsBanner({super.key, this.onShopNowTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      child: SizedBox(
        height: 329.h,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ── Background fruit/vegetable image ──────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Assets.images.newArrivals.image(
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),

            // ── Text + button column ───────────────────────────────────
            Positioned(
              top: 24.h,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Subtitle
                  Text(
                    Translation.discover_latest_products.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeightM.bold,
                      color: ColorM.white,
                      height: 1.4,
                    ),
                  ),
                  6.verticalSpace,
                  // Main headline
                  Text(
                    Translation.fresh_100_percent.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeightM.semiBold,
                      color: ColorM.white,
                      height: 1.5,
                    ),
                  ),
                  16.h.verticalSpace,
                  // Shop Now button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomInkButton(
                        onTap: onShopNowTap,
                        backgroundColor: ColorM.white,
                        borderRadius: 23.r,
                        // width: 127.w,
                        height: 36.h,
                        padding: EdgeInsets.symmetric(horizontal: 23.w),
                        alignment: Alignment.center,
                        child: Text(
                          Translation.start_shopping_now.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeightM.medium,
                            color: ColorM.primary500,
                          ),
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
    );
  }
}
