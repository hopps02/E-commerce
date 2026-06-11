import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/order_details/riverpod/cashier_order_details_controller.dart';
import 'package:for_u/presentation/views/cashier/order_details/view/widgets/assign_captain_bottom_sheet.dart';

class OrderBottomBar extends StatelessWidget {
  final CashierOrderDetailsState state;
  const OrderBottomBar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorM.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x0A000000),
            blurRadius: 31,
            offset: const Offset(0, -17),
          ),
        ],
      ),
      child: GeneralPadding(
        child: Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TotalsPanel(
                productsCount: state.productsCount,
                totalAmount: state.totalAmount,
              ),
              if (state.status.showsActionButton) ...[
                10.verticalSpace,
                _ActionButton(
                  status: state.status,
                  allPrepared: state.allPrepared,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TotalsPanel extends StatelessWidget {
  final int productsCount;
  final double totalAmount;

  const _TotalsPanel({required this.productsCount, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Translation.products_count_label.tr,
                style: context.bodyLarge.copyWith(
                  color: ColorM.gray600,
                  height: 1.2,
                ),
              ),
              Text(
                '$productsCount',
                style: context.bodyLarge.copyWith(
                  color: ColorM.gray600,
                  fontWeight: FontWeightM.medium,
                  fontSize: 16.45.sp,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        Container(height: 1.h, color: const Color(0xFFDFDFDF)),
        8.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translation.total_amount.tr,
              style: context.bodyLarge.copyWith(
                color: ColorM.gray900,
                fontWeight: FontWeightM.medium,
                fontSize: 18.sp,
                height: 1.5,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Assets.svg.saudiRiyalSymbol.path,
                  width: 12.w,
                  height: 13.h,
                  colorFilter: const ColorFilter.mode(
                    ColorM.primary700,
                    BlendMode.srcIn,
                  ),
                ),
                3.horizontalSpace,
                Text(
                  totalAmount.toStringAsFixed(0),
                  style: context.bodyLarge.copyWith(
                    color: ColorM.primary700,
                    fontWeight: FontWeightM.semiBold,
                    fontSize: 16.45.sp,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends ConsumerWidget {
  final CashierOrderStatus status;
  final bool allPrepared;

  const _ActionButton({required this.status, required this.allPrepared});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPreparing = status.isPreparing;
    final enabled = isPreparing ? allPrepared : true;

    return CustomInkButton(
      onTap: enabled ? () => _onTap(context, ref) : null,
      enabled: enabled,
      height: 56.h,
      width: double.infinity,
      borderRadius: SizeM.commonBorderRadius.r,
      backgroundColor: enabled ? ColorM.primary500 : ColorM.gray200,
      alignment: Alignment.center,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Text(
        isPreparing
            ? Translation.confirm_readiness.tr
            : Translation.assign_captain.tr,
        style: context.bodyLarge.copyWith(
          color: enabled ? ColorM.white : ColorM.gray600,
          fontWeight: FontWeightM.medium,
          height: 1.5,
        ),
      ),
    );
  }

  Future<void> _onTap(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(cashierOrderDetailsController.notifier);
    if (status.isPreparing) {
      notifier.confirmReadiness();
      return;
    }
    final picked = await AssignCaptainBottomSheet.show(context);
    if (picked != null) {
      notifier.assignCaptain(name: picked.name, avatarUrl: picked.avatarUrl);
    }
  }
}
