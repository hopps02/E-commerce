import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/custom_cached_image.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/cashier/order_details/riverpod/cashier_order_details_controller.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/mark_unavailable_bottom_sheet.dart';

class OrderProductsTable extends ConsumerWidget {
  final CashierOrderDetailsState state;
  const OrderProductsTable({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cashierOrderDetailsController.notifier);
    final headerStyle = context.labelLarge.copyWith(
      color: ColorM.gray600,
      fontSize: 12,
      height: 16 / 12,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 181,
              child: Text(Translation.product.tr, style: headerStyle),
            ),
            SizedBox(
              width: 43,
              child: Center(
                child: Text(Translation.quantity.tr, style: headerStyle),
              ),
            ),
            SizedBox(
              width: 43,
              child: Center(
                child: Text(Translation.prepared.tr, style: headerStyle),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Container(height: 1, color: ColorM.gray250),
        for (final product in state.products) ...[
          12.verticalSpace,
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            // Long-press marks the item unavailable; the layout itself is left
            // untouched. The sheet confirms before the (irreversible) backend call.
            onLongPress: state.status.isProductsEditable
                ? () async {
                    final reason = await MarkUnavailableBottomSheet.show(
                      context,
                      itemName: product.name,
                    );
                    if (reason == null) return;
                    await notifier.markUnavailable(
                      product.id,
                      reason: reason.isEmpty ? null : reason,
                    );
                  }
                : null,
            child: _ProductRow(
              product: product,
              editable: state.status.isProductsEditable,
              onToggle: () => notifier.togglePrepared(product.id),
            ),
          ),
          12.verticalSpace,
          Container(height: 1, color: ColorM.gray250),
        ],
      ],
    );
  }
}

class _ProductRow extends StatelessWidget {
  final CashierOrderProduct product;
  final bool editable;
  final VoidCallback onToggle;

  const _ProductRow({
    required this.product,
    required this.editable,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 181,
          child: Row(
            children: [
              Container(
                width: 38,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  border: Border.all(color: ColorM.gray250, width: 0.7.w),
                ),
                clipBehavior: Clip.antiAlias,
                child: CustomCachedImage(
                  imageUrl: product.imageUrl,
                  width: 38,
                  height: 34,
                ),
              ),
              6.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      style: context.labelSmall.copyWith(
                        color: ColorM.gray900,
                        fontSize: 10,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    6.verticalSpace,
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.saudiRiyalSymbol.path,
                          width: 7,
                          height: 8,
                          colorFilter: const ColorFilter.mode(
                            ColorM.primary700,
                            BlendMode.srcIn,
                          ),
                        ),
                        2.horizontalSpace,
                        Text(
                          Money.amount(product.priceHalalas),
                          style: context.labelSmall.copyWith(
                            color: ColorM.primary700,
                            fontWeight: FontWeightM.semiBold,
                            fontSize: 10.7,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 43,
          child: Text(
            '${product.quantity}',
            textAlign: TextAlign.center,
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ),
        SizedBox(
          width: 43,
          child: InkResponse(
            onTap: editable ? onToggle : null,
            radius: 18.r,
            child: _Checkbox(checked: product.isPrepared),
          ),
        ),
      ],
    );
  }
}

class _Checkbox extends StatelessWidget {
  final bool checked;
  const _Checkbox({required this.checked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: checked ? ColorM.primary500 : ColorM.transparent,
        border: Border.all(
          color: checked ? ColorM.primary500 : ColorM.gray300,
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: checked
          ? Icon(Icons.check_rounded, size: 10, color: ColorM.white)
          : null,
    );
  }
}
