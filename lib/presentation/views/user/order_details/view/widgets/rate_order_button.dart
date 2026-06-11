import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/order_details/riverpod/order_details_controller.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/rate_order_bottom_sheet.dart';

/// Bottom CTA on the order details screen that opens the rating sheet and
/// submits the four-axis rating to the backend.
class RateOrderButton extends ConsumerWidget {
  const RateOrderButton({super.key});

  Future<void> _rate(BuildContext context, WidgetRef ref) async {
    final result = await RateOrderBottomSheet.show(context);
    if (result == null) return;

    await ref
        .read(orderDetailsController.notifier)
        .rate(
          overall: result.overall,
          captain: result.deliveryRep,
          orderAccuracy: result.orderMatch,
          deliverySpeed: result.deliverySpeed,
          comment: result.comment,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.w,
        16.h,
        16.w,
        context.bottomSafeAreaPadding + 16.h,
      ),
      child: CustomInkButton(
        onTap: () => _rate(context, ref),
        height: 56.h,
        width: double.infinity,
        borderRadius: SizeM.commonBorderRadius.r,
        backgroundColor: ColorM.orange,
        alignment: Alignment.center,
        tap: const ButtonAnimationSettings(
          ButtonAnimation.scaleTap,
          intensity: 0.2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Translation.rate.tr,
              style: context.bodyLarge.copyWith(
                color: ColorM.white,
                fontWeight: FontWeightM.medium,
                height: 1.2,
              ),
            ),
            8.horizontalSpace,
            SvgPicture.asset(
              Assets.svg.star.path,
              width: 18.sp,
              colorFilter: const ColorFilter.mode(
                ColorM.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
