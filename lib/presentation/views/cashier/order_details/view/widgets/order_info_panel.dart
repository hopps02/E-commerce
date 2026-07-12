import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/enums/enums.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/custom_cached_image.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/cashier/order_details/riverpod/cashier_order_details_controller.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/change_captain_bottom_sheet.dart';

class OrderInfoPanel extends StatelessWidget {
  final CashierOrderDetailsState state;
  const OrderInfoPanel({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      color: ColorM.gray100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoRow(
            label: Translation.location_label.tr,
            valueIcon: Assets.svg.borderLocation.path,
            value: state.location,
          ),
          10.verticalSpace,
          _InfoRow(
            label: Translation.order_time_label.tr,
            valueIcon: Assets.svg.calendar.path,
            value: easy.DateFormat(
              'd MMMM yyyy',
              context.locale.languageCode,
            ).format(state.orderTime),
          ),
          if (state.status.showsCaptainRow && state.captainName != null) ...[
            10.verticalSpace,
            _CaptainRow(state: state),
          ],
          if (state.status.showsStatusBadge) ...[
            9.verticalSpace,
            _StatusBadge(status: state.status),
          ],
          if (state.failureReason != null) ...[
            9.verticalSpace,
            _FailureReasonBox(reason: state.failureReason!),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String valueIcon;
  final String value;

  const _InfoRow({
    required this.label,
    required this.valueIcon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 64.w,
          child: Text(
            label,
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              fontSize: 12.sp,
              height: 16 / 12,
            ),
          ),
        ),
        6.horizontalSpace,
        SvgPicture.asset(
          valueIcon,
          width: 16.w,
          height: 16.w,
          colorFilter: const ColorFilter.mode(ColorM.gray600, BlendMode.srcIn),
        ),
        6.horizontalSpace,
        Expanded(
          child: Text(
            value,
            softWrap: true,
            maxLines: 100,
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              height: 16 / 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _CaptainRow extends ConsumerWidget {
  final CashierOrderDetailsState state;
  const _CaptainRow({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canChange = state.status.canReassignCaptain;

    final content = Row(
      children: [
        SizedBox(
          width: 64.w,
          child: Text(
            Translation.captain_label.tr,
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              fontSize: 12.sp,
              height: 16 / 12,
            ),
          ),
        ),
        6.horizontalSpace,
        ClipOval(
          child: CustomCachedImage(
            imageUrl: state.captainAvatarUrl ?? '',
            width: 21.w,
            height: 21.w,
          ),
        ),
        6.horizontalSpace,
        Expanded(
          child: Text(
            state.captainName ?? '',
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              height: 16 / 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (canChange) ...[6.horizontalSpace, const _ChangePill()],
      ],
    );

    if (!canChange) return content;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openChangeSheet(context, ref),
      child: content,
    );
  }

  Future<void> _openChangeSheet(BuildContext context, WidgetRef ref) async {
    final postPickup =
        state.orderRawState == 'out_for_delivery' ||
        state.orderRawState == 'received_by_captain';

    final order = await ChangeCaptainBottomSheet.show(
      context,
      orderId: state.orderId,
      currentCaptainId: state.captainId,
      currentCaptainName: state.captainName,
      postPickup: postPickup,
    );

    if (order != null) {
      ref.read(cashierOrderDetailsController.notifier).applyAssigned(order);
      DI().snackBarHelper.showMessage(
        Translation.captain_changed.tr,
        ErrorMessage.snackBar,
      );
    }
  }
}

class _ChangePill extends StatelessWidget {
  const _ChangePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorM.primary50,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit_outlined, size: 12.sp, color: ColorM.primary700),
          3.horizontalSpace,
          Text(
            Translation.change.tr,
            style: context.labelMedium.copyWith(
              color: ColorM.primary700,
              fontWeight: FontWeightM.medium,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final CashierOrderStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      CashierOrderStatus.inDelivery => (
        const Color(0xFFF59E0B),
        Translation.out_for_delivery.tr,
      ),
      CashierOrderStatus.delivered => (
        const Color(0xFF10B981),
        Translation.delivered.tr,
      ),
      CashierOrderStatus.failedDelivery => (
        ColorM.red,
        Translation.delivery_failed.tr,
      ),
      CashierOrderStatus.cancelled => (ColorM.red, Translation.cancelled.tr),
      CashierOrderStatus.rejectedByMerchant => (
        ColorM.red,
        Translation.rejected_by_merchant.tr,
      ),
      _ => (Colors.transparent, ''),
    };

    if (label.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 34.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(26.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.labelLarge.copyWith(
              color: color,
              fontWeight: FontWeightM.medium,
              height: 1.2,
            ),
          ),
          3.horizontalSpace,
          Container(
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}

class _FailureReasonBox extends StatelessWidget {
  final String reason;
  const _FailureReasonBox({required this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorM.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded, size: 18.w, color: ColorM.red),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.delivery_failure_reason.tr,
                  style: context.labelMedium.copyWith(
                    color: ColorM.red,
                    fontWeight: FontWeightM.semiBold,
                    height: 1.2,
                  ),
                ),
                2.verticalSpace,
                Text(
                  reason,
                  style: context.bodyMedium.copyWith(
                    color: ColorM.gray800,
                    height: 1.2,
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
