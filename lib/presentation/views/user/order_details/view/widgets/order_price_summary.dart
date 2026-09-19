import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/ui_kit/currency_mark.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class OrderPriceSummary extends StatelessWidget {
  final int subtotalHalalas;
  final int shippingHalalas;
  final int discountHalalas;
  final int vatHalalas;

  /// What the order was actually charged. It is not recomputed here:
  /// the receipt is the store's, and adding the rows up again is how a
  /// screen ends up disagreeing with it.
  final int totalHalalas;

  const OrderPriceSummary({
    super.key,
    required this.subtotalHalalas,
    required this.shippingHalalas,
    required this.discountHalalas,
    required this.vatHalalas,
    required this.totalHalalas,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Translation.price_summary.tr,
          style: context.bodyLarge.copyWith(
            color: ColorM.gray950,
            fontWeight: FontWeightM.bold,
          ),
        ),
        SpaceM.s4.verticalSpace,
        _SummaryRow(
          title: Translation.total_products.tr,
          halalas: subtotalHalalas,
        ),
        SpaceM.s3.verticalSpace,
        _SummaryRow(
          title: Translation.shipping_cost.tr,
          halalas: shippingHalalas,
        ),
        SpaceM.s3.verticalSpace,
        _SummaryRow(title: Translation.discount.tr, halalas: discountHalalas),
        // Only when the store charged it: a zero row is noise, a missing
        // one leaves the customer adding up to the wrong total.
        if (vatHalalas > 0) ...[
          SpaceM.s2.verticalSpace,
          _SummaryRow(title: Translation.vat.tr, halalas: vatHalalas),
        ],
        SpaceM.s6.verticalSpace,
        Container(height: 1, color: ColorM.gray200),
        SpaceM.s6.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Translation.total_amount.tr,
              style: context.titleMedium.copyWith(
                color: ColorM.gray950,
                fontWeight: FontWeightM.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: SpaceM.s1,
              children: [
                Text(
                  Money.amount(totalHalalas),
                  style: context.titleMedium.copyWith(
                    color: ColorM.primary700,
                    fontWeight: FontWeightM.bold,
                  ),
                ),
                CurrencyMark(size: 14, color: ColorM.primary700),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final int halalas;

  const _SummaryRow({required this.title, required this.halalas});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.bodyMedium.copyWith(color: ColorM.gray600)),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: SpaceM.s1,
          children: [
            Text(
              Money.amount(halalas),
              style: context.bodyMedium.copyWith(
                color: ColorM.gray600,
                fontWeight: FontWeightM.medium,
              ),
            ),
            const CurrencyMark(size: 12, color: ColorM.gray600),
          ],
        ),
      ],
    );
  }
}
