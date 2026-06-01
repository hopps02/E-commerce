import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/custom_cached_image.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/order_details/riverpod/cashier_order_details_controller.dart';

class OrderProductsTable extends ConsumerWidget {
  final CashierOrderDetailsState state;
  const OrderProductsTable({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cashierOrderDetailsController.notifier);
    final headerStyle = context.labelLarge.copyWith(
      color: ColorM.gray600,
      fontSize: 12.sp,
      height: 16 / 12,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 181.w,
              child: Text(Translation.product.tr, style: headerStyle),
            ),
            SizedBox(
              width: 43.w,
              child: Center(
                child: Text(Translation.quantity.tr, style: headerStyle),
              ),
            ),
            SizedBox(
              width: 43.w,
              child: Center(
                child: Text(Translation.prepared.tr, style: headerStyle),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Container(height: 1.h, color: ColorM.gray250),
        for (final product in state.products) ...[
          12.verticalSpace,
          _ProductRow(
            product: product,
            editable: state.status.isProductsEditable,
            onToggle: () => notifier.togglePrepared(product.id),
          ),
          12.verticalSpace,
          Container(height: 1.h, color: ColorM.gray250),
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
          width: 181.w,
          child: Row(
            children: [
              Container(
                width: 38.w,
                height: 34.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  border: Border.all(color: ColorM.gray250, width: 0.7.w),
                ),
                clipBehavior: Clip.antiAlias,
                child: CustomCachedImage(
                  imageUrl: product.imageUrl,
                  width: 38.w,
                  height: 34.h,
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
                        fontSize: 10.sp,
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
                          width: 7.w,
                          height: 8.h,
                          colorFilter: const ColorFilter.mode(
                            ColorM.primary700,
                            BlendMode.srcIn,
                          ),
                        ),
                        2.horizontalSpace,
                        Text(
                          product.price.toStringAsFixed(0),
                          style: context.labelSmall.copyWith(
                            color: ColorM.primary700,
                            fontWeight: FontWeightM.semiBold,
                            fontSize: 10.7.sp,
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
          width: 43.w,
          child: Text(
            '${product.quantity}',
            textAlign: TextAlign.center,
            style: context.labelLarge.copyWith(
              color: ColorM.gray600,
              fontSize: 12.sp,
              height: 1.2,
            ),
          ),
        ),
        SizedBox(
          width: 43.w,
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
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: checked ? ColorM.primary500 : ColorM.transparent,
        border: Border.all(
          color: checked ? ColorM.primary500 : ColorM.gray300,
          width: 1.5.w,
        ),
      ),
      alignment: Alignment.center,
      child: checked
          ? Icon(Icons.check_rounded, size: 10.sp, color: ColorM.white)
          : null,
    );
  }
}
