import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart'
    hide SmoothRectangleBorder;
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

class SwitchBranchBottomSheet extends StatelessWidget {
  const SwitchBranchBottomSheet({super.key});

  static Future<bool?> show(BuildContext context) async {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => const SwitchBranchBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.all(SizeM.pagePadding.dg) +
          EdgeInsets.only(
            bottom: context.bottomViewInsets + context.bottomSafeAreaPadding,
          ),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: ColorM.white,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(RadiusM.xl.r),
            topRight: Radius.circular(RadiusM.xl.r),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: ColorM.gray300,
              borderRadius: BorderRadius.circular(RadiusM.pill.r),
            ),
          ),
          SpaceM.s8.verticalSpace,
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: ColorM.primary50,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.storefront_rounded,
              size: 36,
              color: ColorM.primary600,
            ),
          ),
          SpaceM.s6.verticalSpace,
          Text(
            Translation.new_cart_title.tr,
            textAlign: TextAlign.center,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeightM.semiBold,
              color: ColorM.gray900,
            ),
          ),
          SpaceM.s3.verticalSpace,
          Text(
            Translation.new_cart_subtitle.tr,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(color: ColorM.gray500),
          ),
          SpaceM.s8.verticalSpace,
          CustomInkButton(
            onTap: () => Navigator.pop(context, true),
            backgroundColor: ColorM.primary500,
            height: 56,
            borderRadius: SizeM.commonBorderRadius.r,
            alignment: Alignment.center,
            child: Text(
              Translation.start_new_cart.tr,
              style: context.bodyLarge.copyWith(
                color: ColorM.white,
                fontWeight: FontWeightM.medium,
              ),
            ),
          ),
          SpaceM.s3.verticalSpace,
          CustomInkButton(
            onTap: () => Navigator.pop(context, false),
            backgroundColor: ColorM.transparent,
            side: GradientBorderSide(color: ColorM.primary500, width: 1),
            height: 56,
            borderRadius: SizeM.commonBorderRadius.r,
            alignment: Alignment.center,
            child: Text(
              Translation.cancel.tr,
              style: context.bodyLarge.copyWith(
                color: ColorM.primary700,
                fontWeight: FontWeightM.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
