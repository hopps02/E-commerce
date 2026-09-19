import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/indicators/error_widget.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

/// Shown on the cart and confirm-order screens when checkout fails because the
/// cart's branch no longer matches the store serving the delivery address
/// (cart_branch_mismatch / multi_branch_cart). Replaces the old dead-end retry
/// with a real resolution: clear the cart and shop from the serving store.
class CartBranchResolutionState extends StatelessWidget {
  final String message;
  final VoidCallback onClearCart;
  final VoidCallback onDismiss;

  const CartBranchResolutionState({
    super.key,
    required this.message,
    required this.onClearCart,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.22),
      child: GeneralPadding(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyErrorWidget(titleMessage: message),
            SpaceM.s7.verticalSpace,
            CustomInkButton(
              onTap: onClearCart,
              width: double.infinity,
              height: 56,
              backgroundColor: ColorM.primary500,
              borderRadius: SizeM.commonBorderRadius.r,
              alignment: Alignment.center,
              child: Text(
                Translation.clear_cart_shop_here.tr,
                textAlign: TextAlign.center,
                style: context.bodyLarge.copyWith(
                  color: ColorM.white,
                  fontWeight: FontWeightM.medium,
                ),
              ),
            ),
            SpaceM.s3.verticalSpace,
            CustomInkButton(
              onTap: onDismiss,
              width: double.infinity,
              height: 56,
              backgroundColor: ColorM.transparent,
              side: GradientBorderSide(
                color: ColorM.primary500,
                width: 1,
              ),
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
      ),
    );
  }
}
