import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/services/whatsapp_service.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/utils/failure_reason.dart';
import 'package:store/data/response/customer/customer_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/order_card.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

class OrderStatusSection extends StatelessWidget {
  final int step;
  final String orderNumber;
  final String orderState;

  /// The exact status in the customer's words. Three nodes cannot show seven
  /// states, so this is what changes on every move staff make.
  final String stateLabel;

  /// A ready wa.me link that re-sends this order to the store, for a customer
  /// who closed the success screen before sending it. Empty hides the action.
  final String whatsappUrl;
  final String? failureReason;
  final String? failureNote;
  const OrderStatusSection({
    super.key,
    required this.step,
    required this.orderNumber,
    required this.orderState,
    this.stateLabel = '',
    this.whatsappUrl = '',
    this.failureReason,
    this.failureNote,
  });

  @override
  Widget build(BuildContext context) {
    final isFailed = orderState == 'failed_delivery';
    final reasonLabel = failureReasonLabel(failureReason, note: failureNote);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translation.order_number.tr,
              style: context.labelLarge.copyWith(color: ColorM.gray600),
            ),
            Text(
              '#$orderNumber',
              textDirection: TextDirection.ltr,
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeightM.medium,
                color: ColorM.gray400,
              ),
            ),
          ],
        ),
        if (stateLabel.trim().isNotEmpty) ...[
          SpaceM.s3.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: SpaceM.s3.w, vertical: SpaceM.s2.h),
              decoration: ShapeDecoration(
                color: isFailed ? const Color(0xFFFFECEC) : ColorM.primary50,
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(RadiusM.pill),
                ),
              ),
              child: Text(
                stateLabel,
                style: context.labelLarge.copyWith(
                  color: isFailed ? ColorM.red : ColorM.primary700,
                  fontWeight: FontWeightM.semiBold,
                ),
              ),
            ),
          ),
        ],
        if (whatsappUrl.trim().isNotEmpty && !orderStateIsFinal(orderState)) ...[
          SpaceM.s4.verticalSpace,
          CustomInkButton(
            onTap: () => WhatsAppService.sendOrder(whatsappUrl),
            borderRadius: RadiusM.sm.r,
            height: 46,
            width: double.infinity,
            backgroundColor: ColorM.greenSecondary,
            alignment: Alignment.center,
            child: Text(
              Translation.send_order_on_whatsapp.tr,
              style: context.labelLarge.copyWith(
                color: ColorM.white,
                fontWeight: FontWeightM.semiBold,
              ),
            ),
          ),
        ],
        SpaceM.s6.verticalSpace,
        Row(
          children: [
            Expanded(
              child: TimeLineStep(
                title: Translation.preparing.tr,
                isActive: step >= 1,
                isNextActive: step >= 2,
                isFirst: true,
                isLast: false,
              ),
            ),
            Expanded(
              child: TimeLineStep(
                title: Translation.out_for_delivery.tr,
                isActive: step >= 2,
                isNextActive: step >= 3,
                isFirst: false,
                isLast: false,
                nextFailed: isFailed,
              ),
            ),
            Expanded(
              child: TimeLineStep(
                // A failed delivery replaces the "delivered" node with a red
                // "delivery failed" node so the order never reads as delivered.
                title: isFailed
                    ? Translation.delivery_failed.tr
                    : Translation.delivered.tr,
                isActive: isFailed || step >= 3,
                isFailed: isFailed,
                isNextActive: false,
                isFirst: false,
                isLast: true,
              ),
            ),
          ],
        ),
        if (isFailed && reasonLabel != null) ...[
          SpaceM.s4.verticalSpace,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: SpaceM.s3, vertical: SpaceM.s3.h),
            decoration: ShapeDecoration(
              color: ColorM.red.withValues(alpha: 0.08),
              shape: SmoothRectangleBorder(
                smoothness: 1,
                borderRadius: BorderRadius.circular(RadiusM.sm.r),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.error_outline_rounded, size: 18, color: ColorM.red),
                SpaceM.s2.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Translation.delivery_failure_reason.tr,
                        style: context.labelMedium.copyWith(
                          color: ColorM.red,
                          fontWeight: FontWeightM.semiBold,
                        ),
                      ),
                      SpaceM.s1.verticalSpace,
                      Text(
                        reasonLabel,
                        style: context.bodyMedium.copyWith(
                          color: ColorM.gray800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        SpaceM.s6.verticalSpace,
        Container(height: 1, color: ColorM.gray150),
      ],
    );
  }
}
