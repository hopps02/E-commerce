import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/captain/order_details/riverpod/delivery_failure_reason_controller.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../../../../res/gen/assets.gen.dart';

/// What the captain picked: the BACKEND reason value plus the free-text note
/// (required when the reason is `other`).
typedef PickedFailureReason = ({String reason, String? note});

class DeliveryFailureReasonSheet extends ConsumerWidget {
  const DeliveryFailureReasonSheet({super.key});

  /// Returns the picked reason + note, or `null` if dismissed.
  static Future<PickedFailureReason?> show(BuildContext context) {
    return showModalBottomSheet<PickedFailureReason>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.32),
      useSafeArea: true,
      builder: (_) => const DeliveryFailureReasonSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deliveryFailureReasonController);
    final notifier = ref.read(deliveryFailureReasonController.notifier);

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: context.bottomViewInsetsMedia),
        padding: EdgeInsets.fromLTRB(24.w, 10.h, 24.w, 24.h),
        decoration: ShapeDecoration(
          color: ColorM.white,
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            16.verticalSpace,
            _Header(onClose: () => Navigator.of(context).maybePop()),
            22.verticalSpace,
            Container(height: 1.h, color: ColorM.primary50),
            16.verticalSpace,
            // Reasons list is a fixed enum today, but FastStateRender lets us
            // swap to an API call without restructuring the sheet.
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 200.h),
              child: FastStateRender(
                reqState: state.reqState,
                errorMessage: state.msgError,
                onRetry: notifier.retry,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (
                      int i = 0;
                      i < DeliveryFailureReason.values.length;
                      i++
                    ) ...[
                      _ReasonRow(
                        label: _labelFor(DeliveryFailureReason.values[i]),
                        isSelected: state.selectedIndex == i,
                        onTap: () => notifier.selectReason(i),
                      ),
                      8.verticalSpace,
                    ],
                    AnimatedVisibility(
                      visible: state.isOtherSelected,
                      enter:
                          expandVertically(curve: Curves.ease) +
                          fadeIn(curve: Curves.ease),
                      exit:
                          shrinkVertically(curve: Curves.ease) +
                          fadeOut(curve: Curves.ease),
                      enterDuration: const Duration(milliseconds: 200),
                      exitDuration: const Duration(milliseconds: 200),
                      child: Column(
                        children: [
                          4.verticalSpace,
                          _OtherReasonField(
                            controller: state.otherReasonController,
                            onChanged: notifier.onOtherNoteChanged,
                          ),
                          8.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            16.verticalSpace,
            Container(height: 1.h, color: ColorM.primary50),
            16.verticalSpace,
            // `other` needs the free text — the backend rejects it without
            // a note, so don't let the captain submit an empty one.
            _SendButton(
              enabled:
                  state.selectedIndex != null &&
                  (!state.isOtherSelected || state.otherNote.trim().isNotEmpty),
              onTap: () => _onSend(context, state),
            ),
          ],
        ),
      ),
    );
  }

  String _labelFor(DeliveryFailureReason reason) {
    switch (reason) {
      case DeliveryFailureReason.customerNotAvailable:
        return Translation.customer_not_available.tr;
      case DeliveryFailureReason.notAnsweringPhone:
        return Translation.not_answering_phone.tr;
      case DeliveryFailureReason.incorrectAddress:
        return Translation.incorrect_address.tr;
      case DeliveryFailureReason.customerRefused:
        return Translation.customer_refused_receipt.tr;
      case DeliveryFailureReason.other:
        return Translation.other_reason.tr;
    }
  }

  void _onSend(BuildContext context, DeliveryFailureReasonState state) {
    final idx = state.selectedIndex;
    if (idx == null) return;
    final picked = DeliveryFailureReason.values[idx];
    final note = state.otherReasonController.text.trim();

    Navigator.of(
      context,
    ).pop((reason: _backendValue(picked), note: note.isEmpty ? null : note));
  }

  /// The backend's DeliveryFailureReason enum values — what mark-failed
  /// actually accepts; localized labels are display-only.
  String _backendValue(DeliveryFailureReason reason) => switch (reason) {
    DeliveryFailureReason.customerNotAvailable => 'customer_not_available',
    DeliveryFailureReason.notAnsweringPhone => 'no_answer',
    DeliveryFailureReason.incorrectAddress => 'wrong_address',
    DeliveryFailureReason.customerRefused => 'customer_refused',
    DeliveryFailureReason.other => 'other',
  };
}

class _Header extends StatelessWidget {
  final VoidCallback onClose;
  const _Header({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: const Color(0xFFFFE2E2),
                shape: SmoothRectangleBorder(
                  smoothness: 1,
                  borderRadius: BorderRadius.circular(11.r),
                ),
              ),
              child: SvgPicture.asset(
                Assets.svg.info.path,
                width: 18.w,
                height: 18.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFEF4444),
                  BlendMode.srcIn,
                ),
              ),
            ),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Translation.delivery_failure_reason.tr,
                  style: context.bodyLarge.copyWith(
                    color: ColorM.gray900,
                    fontWeight: FontWeightM.semiBold,
                    fontSize: 15.sp,
                    height: 1.2,
                  ),
                ),
                6.verticalSpace,
                Text(
                  Translation.select_undelivered_reason.tr,
                  style: context.labelMedium.copyWith(
                    color: ColorM.gray600,
                    fontSize: 12.sp,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: onClose,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 28.w,
            height: 28.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.close_rounded, size: 18.w, color: ColorM.white),
          ),
        ),
      ],
    );
  }
}

class _ReasonRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReasonRow({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
        decoration: ShapeDecoration(
          color: ColorM.gray100,
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: context.labelMedium.copyWith(
                color: ColorM.gray700,
                fontWeight: FontWeightM.medium,
                fontSize: 13.sp,
                height: 1.2,
              ),
            ),
            _RadioDot(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool isSelected;
  const _RadioDot({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? ColorM.primary500 : Colors.transparent,
        border: Border.all(
          color: isSelected ? ColorM.primary500 : ColorM.gray300,
          width: 1.5.w,
        ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? Icon(Icons.check_rounded, size: 10.sp, color: ColorM.white)
          : null,
    );
  }
}

class _OtherReasonField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _OtherReasonField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SimpleForm(
      controller: controller,
      onChanged: onChanged,
      hintText: Translation.mention_reason_hint.tr,
      height: 70.h,
      maxLines: 3,
      borderRadius: 15.r,
      backgroundColor: ColorM.gray100,
      borderColor: ColorM.gray100,
      alignment: AlignmentDirectional.topStart,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
      textAlign: TextAlign.start,
      keyboardType: TextInputType.multiline,
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;
  const _SendButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: enabled ? onTap : null,
      enabled: enabled,
      height: 56.h,
      width: double.infinity,
      borderRadius: 16.r,
      smoothness: 1,
      backgroundColor: enabled ? ColorM.primary500 : ColorM.gray200,
      alignment: Alignment.center,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Text(
        Translation.send.tr,
        style: context.bodyLarge.copyWith(
          color: enabled ? ColorM.white : ColorM.gray600,
          fontWeight: FontWeightM.medium,
          fontSize: 16.sp,
          height: 1.5,
        ),
      ),
    );
  }
}
