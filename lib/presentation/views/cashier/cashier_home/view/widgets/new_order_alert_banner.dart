import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

class NewOrderAlertBanner extends StatelessWidget {
  final int newOrderCount;
  final VoidCallback onViewOrders;
  final VoidCallback onDismiss;

  const NewOrderAlertBanner({
    super.key,
    required this.newOrderCount,
    required this.onViewOrders,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;

    final title = newOrderCount > 1
        ? Translation.new_orders_received.trNamed({
            'count': '$newOrderCount',
          })
        : Translation.new_order_received.tr;

    return DecoratedBox(
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
          colors: [ColorM.orange, ColorM.primary600],
        ),
        shadows: [
          BoxShadow(
            color: ColorM.gray1000.withValues(alpha: .18),
            blurRadius: 18.r,
            offset: Offset(0, 10.h),
          ),
        ],
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(14.w, 14.h, 12.w, 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: ColorM.white.withValues(alpha: .18),
                borderRadius: BorderRadius.circular(14.r),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.notifications_active_rounded,
                color: ColorM.white,
                size: 24.sp,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.titleSmall.copyWith(
                      color: ColorM.white,
                      fontWeight: FontWeightM.bold,
                      height: 1.25,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    Translation.new_order_subtitle.tr,
                    style: context.labelLarge.copyWith(
                      color: ColorM.white.withValues(alpha: .92),
                      height: 1.4,
                    ),
                  ),
                  12.verticalSpace,
                  CustomInkButton(
                    onTap: onViewOrders,
                    height: 38.h,
                    borderRadius: 999.r,
                    backgroundColor: ColorM.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    alignment: Alignment.center,
                    child: Text(
                      Translation.view_orders.tr,
                      style: context.labelLarge.copyWith(
                        color: ColorM.primary800,
                        fontWeight: FontWeightM.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            8.horizontalSpace,
            CustomInkButton(
              onTap: onDismiss,
              width: 34.w,
              height: 34.w,
              borderRadius: 12.r,
              backgroundColor: ColorM.white.withValues(alpha: .14),
              alignment: Alignment.center,
              child: Icon(
                Icons.close_rounded,
                color: ColorM.white,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
