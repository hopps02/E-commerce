import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/cashier/order_details/riverpod/assign_captain_controller.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/assign_captain_card.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/assign_captain_confirm_button.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/assign_captain_header.dart';

class AssignCaptainBottomSheet extends ConsumerStatefulWidget {
  final int orderId;
  const AssignCaptainBottomSheet({super.key, required this.orderId});

  /// Picks a captain and ASSIGNS them to [orderId] against the backend.
  /// Resolves with the updated order, or null when dismissed / refused.
  static Future<CashierOrder?> show(
    BuildContext context, {
    required int orderId,
  }) {
    return showModalBottomSheet<CashierOrder>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.32),
      useSafeArea: true,
      builder: (_) => AssignCaptainBottomSheet(orderId: orderId),
    );
  }

  @override
  ConsumerState<AssignCaptainBottomSheet> createState() =>
      _AssignCaptainBottomSheetState();
}

class _AssignCaptainBottomSheetState
    extends ConsumerState<AssignCaptainBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(assignCaptainController.notifier).load(widget.orderId);
    });
  }

  Future<void> _confirm() async {
    final order = await ref
        .read(assignCaptainController.notifier)
        .confirm(widget.orderId);
    if (order != null && mounted) Navigator.of(context).pop(order);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(assignCaptainController);
    final notifier = ref.read(assignCaptainController.notifier);

    return Container(
      width: double.infinity,
      height: 668,
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
              onClose: () => Navigator.of(context).maybePop(),
            ),

            Expanded(
              child: FastStateRender(
                reqState: state.displayState,
                errorMessage: state.errorMessage,
                onRetry: () => notifier.load(widget.orderId),
                child: Column(
                  children: [
                    8.verticalSpace,
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
                    12.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: AssignCaptainConfirmButton(
                        selected: state.selectedCaptain,
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
