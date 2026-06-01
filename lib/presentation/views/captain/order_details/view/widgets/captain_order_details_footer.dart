import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/captain/delivery_outcome/view/screens/captain_delivery_outcome_view.dart';
import 'package:for_u/presentation/views/captain/order_details/riverpod/captain_order_details_controller.dart';
import 'package:for_u/presentation/views/captain/order_details/view/widgets/delivery_failure_reason_sheet.dart';

class CaptainOrderDetailsFooter extends ConsumerWidget {
  final CaptainOrderStatus status;
  const CaptainOrderDetailsFooter({super.key, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (status.isReadOnly) return const SizedBox.shrink();
    final notifier = ref.read(captainOrderDetailsController.notifier);

    return Container(
      padding: EdgeInsetsDirectional.only(bottom: context.bottomSafeAreaPadding),
      decoration: BoxDecoration(
        color: ColorM.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            blurRadius: 5.05,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: ColorM.gray100, width: 1.w),
      ),
      child: GeneralPadding(
        child: Padding(
          padding: EdgeInsets.only(top: 14.h, bottom: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buttonsFor(context, ref, notifier),
          ),
        ),
      ),
    );
  }

  List<Widget> _buttonsFor(
    BuildContext context,
    WidgetRef ref,
    CaptainOrderDetailsNotifier notifier,
  ) {
    switch (status) {
      case CaptainOrderStatus.upcoming:
        return [
          _PrimaryButton(
            label: Translation.accept_and_receive_order.tr,
            backgroundColor: ColorM.primary500,
            icon: Icons.check_circle_outline_rounded,
            onTap: notifier.acceptOrder,
          ),
        ];
      case CaptainOrderStatus.received:
        return [
          _PrimaryButton(
            label: Translation.start_delivery.tr,
            backgroundColor: ColorM.primary500,
            icon: Icons.check_circle_outline_rounded,
            onTap: notifier.startDelivery,
          ),
          12.verticalSpace,
          _FailureButton(orderId: _orderIdFromState(ref)),
        ];
      case CaptainOrderStatus.inDelivery:
        final orderId = _orderIdFromState(ref);
        return [
          _PrimaryButton(
            label: Translation.confirm_order_delivery.tr,
            backgroundColor: const Color(0xFF109642),
            icon: Icons.check_circle_outline_rounded,
            onTap: () => _onConfirmDelivery(context, notifier, orderId),
          ),
          12.verticalSpace,
          _FailureButton(orderId: orderId),
        ];
      case CaptainOrderStatus.delivered:
      case CaptainOrderStatus.cancelled:
        return const [];
    }
  }

  String _orderIdFromState(WidgetRef ref) =>
      ref.read(captainOrderDetailsController).orderId;

  Future<void> _onConfirmDelivery(
    BuildContext context,
    CaptainOrderDetailsNotifier notifier,
    String orderId,
  ) async {
    notifier.markDelivered();
    await context.pushNamed(
      Routes.captainDeliveryOutcome,
      arguments: CaptainDeliveryOutcomeArgs(
        kind: CaptainDeliveryOutcomeKind.success,
        orderId: orderId,
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      height: 56.h,
      borderRadius: 16.r,
      smoothness: 1,
      backgroundColor: backgroundColor,
      alignment: Alignment.center,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20.w, color: ColorM.white),
          8.horizontalSpace,
          Text(
            label,
            style: context.bodyLarge.copyWith(
              color: ColorM.white,
              fontWeight: FontWeightM.semiBold,
              fontSize: 16.sp,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _FailureButton extends ConsumerWidget {
  final String orderId;
  const _FailureButton({required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomInkButton(
      onTap: () => _onTap(context, ref),
      height: 56.h,
      borderRadius: 16.r,
      smoothness: 1,
      backgroundColor: const Color(0xFFFEE2E2),
      alignment: Alignment.center,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cancel_outlined,
            size: 16.w,
            color: const Color(0xFFEF4444),
          ),
          8.horizontalSpace,
          Text(
            Translation.delivery_failed.tr,
            style: context.bodyLarge.copyWith(
              color: const Color(0xFFEF4444),
              fontWeight: FontWeightM.semiBold,
              fontSize: 16.sp,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTap(BuildContext context, WidgetRef ref) async {
    final reason = await DeliveryFailureReasonSheet.show(context);
    if (reason == null || !context.mounted) return;
    ref.read(captainOrderDetailsController.notifier).markCancelled(reason);
    await context.pushNamed(
      Routes.captainDeliveryOutcome,
      arguments: CaptainDeliveryOutcomeArgs(
        kind: CaptainDeliveryOutcomeKind.failure,
        orderId: orderId,
      ),
    );
  }
}
