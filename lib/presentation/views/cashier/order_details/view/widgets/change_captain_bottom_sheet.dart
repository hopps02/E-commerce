import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/enums/enums.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/cashier/order_details/riverpod/change_captain_controller.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/assign_captain_card.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/assign_captain_header.dart';

String _reasonLabel(ReassignReason reason) => switch (reason) {
  ReassignReason.captainUnavailable =>
    Translation.reason_captain_unavailable.tr,
  ReassignReason.captainSick => Translation.reason_captain_sick.tr,
  ReassignReason.captainBrokeDown => Translation.reason_captain_broke_down.tr,
  ReassignReason.customerRequest => Translation.reason_customer_request.tr,
  ReassignReason.other => Translation.reason_other.tr,
};

class ChangeCaptainBottomSheet extends ConsumerStatefulWidget {
  final int orderId;
  final int? currentCaptainId;
  final String? currentCaptainName;
  final bool postPickup;

  const ChangeCaptainBottomSheet({
    super.key,
    required this.orderId,
    required this.currentCaptainId,
    required this.currentCaptainName,
    required this.postPickup,
  });

  /// Picks a different captain and REASSIGNS [orderId] against the backend.
  /// Resolves with the updated order, or null when dismissed / refused.
  static Future<CashierOrder?> show(
    BuildContext context, {
    required int orderId,
    required int? currentCaptainId,
    required String? currentCaptainName,
    required bool postPickup,
  }) {
    return showModalBottomSheet<CashierOrder>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.32),
      useSafeArea: true,
      builder: (_) => ChangeCaptainBottomSheet(
        orderId: orderId,
        currentCaptainId: currentCaptainId,
        currentCaptainName: currentCaptainName,
        postPickup: postPickup,
      ),
    );
  }

  @override
  ConsumerState<ChangeCaptainBottomSheet> createState() =>
      _ChangeCaptainBottomSheetState();
}

class _ChangeCaptainBottomSheetState
    extends ConsumerState<ChangeCaptainBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(changeCaptainController.notifier)
          .load(widget.orderId, widget.currentCaptainId);
    });
  }

  Future<void> _confirm() async {
    final order = await ref
        .read(changeCaptainController.notifier)
        .confirm(widget.orderId);
    if (order != null && mounted) Navigator.of(context).pop(order);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changeCaptainController);
    final notifier = ref.read(changeCaptainController.notifier);

    return Container(
      width: double.infinity,
      height: 720,
      margin: EdgeInsets.only(bottom: context.bottomViewInsetsMedia, top: 10.h),
      decoration: BoxDecoration(
        color: ColorM.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36.r),
          topRight: Radius.circular(36.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            8.verticalSpace,
            AssignCaptainHeader(
              title: Translation.change_captain.tr,
              onClose: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: FastStateRender(
                reqState: state.displayState,
                errorMessage: state.reqState.isEmpty
                    ? Translation.no_other_captain_available.tr
                    : state.errorMessage,
                onRetry: () =>
                    notifier.load(widget.orderId, widget.currentCaptainId),
                child: Column(
                  children: [
                    8.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _CurrentCaptainBanner(
                        name: widget.currentCaptainName ?? '',
                        postPickup: widget.postPickup,
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SimpleForm(
                        height: 44,
                        fontSize: 14,
                        borderRadius: 38.r,
                        borderColor: ColorM.primary50,
                        hintText: Translation.search_hint.tr,
                        keyboardType: TextInputType.text,
                        controller: notifier.searchController,
                        onChanged: notifier.setQuery,
                        prefixWidget: SvgPicture.asset(
                          Assets.svg.search.path,
                          width: 18,
                          height: 18,
                          colorFilter: const ColorFilter.mode(
                            ColorM.gray600,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    11.verticalSpace,
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: state.filtered.length,
                        separatorBuilder: (_, _) => 11.verticalSpace,
                        itemBuilder: (context, i) {
                          final (index, captain) = state.filtered[i];
                          return AssignCaptainCard(
                            captain: captain,
                            isSelected: index == state.selectedIndex,
                            onTap: () => notifier.selectCaptain(index),
                          );
                        },
                      ),
                    ),
                    _ReasonPicker(
                      selected: state.reason,
                      noteController: notifier.noteController,
                      onSelect: notifier.selectReason,
                      onNote: notifier.setNote,
                    ),
                    12.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _ConfirmButton(
                        enabled: state.canConfirm,
                        onConfirm: _confirm,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentCaptainBanner extends StatelessWidget {
  final String name;
  final bool postPickup;
  const _CurrentCaptainBanner({required this.name, required this.postPickup});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorM.gray100,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 18,
                color: ColorM.gray600,
              ),
              6.horizontalSpace,
              Text(
                '${Translation.current_captain.tr}: ',
                style: context.labelLarge.copyWith(color: ColorM.gray600),
              ),
              Expanded(
                child: Text(
                  name,
                  style: context.labelLarge.copyWith(
                    color: const Color(0xFF231F20),
                    fontWeight: FontWeightM.semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (postPickup) ...[
            8.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: const Color(0xFFB45309),
                  ),
                  6.horizontalSpace,
                  Expanded(
                    child: Text(
                      Translation.change_captain_handoff_note.tr,
                      style: context.labelMedium.copyWith(
                        color: const Color(0xFFB45309),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReasonPicker extends StatelessWidget {
  final ReassignReason? selected;
  final TextEditingController noteController;
  final ValueChanged<ReassignReason> onSelect;
  final ValueChanged<String> onNote;

  const _ReasonPicker({
    required this.selected,
    required this.noteController,
    required this.onSelect,
    required this.onNote,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.change_reason_label.tr,
            style: context.labelLarge.copyWith(
              color: const Color(0xFF231F20),
              fontWeight: FontWeightM.semiBold,
            ),
          ),
          8.verticalSpace,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final reason in ReassignReason.values)
                _ReasonChip(
                  label: _reasonLabel(reason),
                  isSelected: selected == reason,
                  onTap: () => onSelect(reason),
                ),
            ],
          ),
          if (selected?.isOther ?? false) ...[
            10.verticalSpace,
            SimpleForm(
              height: 44,
              fontSize: 14,
              borderRadius: 14.r,
              borderColor: ColorM.primary50,
              hintText: Translation.change_reason_note_hint.tr,
              keyboardType: TextInputType.text,
              controller: noteController,
              onChanged: onNote,
            ),
          ],
        ],
      ),
    );
  }
}

class _ReasonChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReasonChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9.h),
      borderRadius: 30.r,
      smoothness: 1,
      backgroundColor: isSelected ? ColorM.primary50 : ColorM.white,
      side: GradientBorderSide(
        color: isSelected ? ColorM.primary500 : ColorM.primary50,
        width: 1,
      ),
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.15,
      ),
      child: Text(
        label,
        style: context.labelLarge.copyWith(
          color: isSelected ? ColorM.primary700 : ColorM.gray600,
          fontWeight: isSelected ? FontWeightM.semiBold : FontWeightM.regular,
          height: 1.2,
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onConfirm;

  const _ConfirmButton({required this.enabled, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: enabled ? onConfirm : null,
      enabled: enabled,
      height: 56,
      width: double.infinity,
      borderRadius: SizeM.commonBorderRadius.r,
      backgroundColor: enabled ? ColorM.primary500 : const Color(0xFF9CA3AF),
      alignment: Alignment.center,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Text(
        Translation.confirm_change.tr,
        style: context.bodyLarge.copyWith(
          color: ColorM.white,
          fontWeight: FontWeightM.medium,
          height: 1.5,
        ),
      ),
    );
  }
}
