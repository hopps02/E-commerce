import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 214.h,
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ColorM.primary550, ColorM.primary900],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Image (Girl) - Positioned on the LEFT (end in RTL)
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: Transform.scale(
              scaleX: context.isRTL ? 1 : -1,
              child: Assets.tempImages.offerGirl.image(
                height: 200.h,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Content - Positioned on the RIGHT (start in RTL)
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: 18.h,
              start: 10.w,
              bottom: 28.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC7FE7E),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Text(
                    "عروض الخريف",
                    style: context.labelSmall.copyWith(
                      color: const Color(0xFF00422B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                19.verticalSpace,
                // Main Text
                SizedBox(
                  width: 200.w,
                  child: Text(
                    "وفّر حتى 40% على خضار وفواكه طازجة",
                    style: context.headlineSmall.copyWith(
                      color: ColorM.white,
                      fontWeight: FontWeightM.semiBold,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const Spacer(),
                // Button
                CustomInkButton(
                  onTap: () {},
                  width: 110.w,
                  height: 28.h,
                  backgroundColor: ColorM.white,
                  borderRadius: 9999,
                  alignment: .center,
                  child: Text(
                    Translation.shop_now.tr,
                    style: context.labelLarge.copyWith(
                      color: ColorM.primary500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
