import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 214,
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
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
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Content - Positioned on the RIGHT (start in RTL)
          Padding(
            padding: EdgeInsetsDirectional.only(top: SpaceM.s5, start: SpaceM.s3, bottom: SpaceM.s7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag
                Container(
                  padding: EdgeInsets.symmetric(horizontal: SpaceM.s2, vertical: SpaceM.s1.h),
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
                SpaceM.s5.verticalSpace,
                // Main Text
                SizedBox(
                  width: 200,
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
                  width: 110,
                  height: 28,
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
