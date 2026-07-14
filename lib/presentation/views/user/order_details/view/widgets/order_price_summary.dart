import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';

class OrderPriceSummary extends StatelessWidget {
  final int subtotalHalalas;
  final int shippingHalalas;
  final int discountHalalas;

  const OrderPriceSummary({
    super.key,
    required this.subtotalHalalas,
    required this.shippingHalalas,
    required this.discountHalalas,
  });

  int get totalHalalas => (subtotalHalalas + shippingHalalas) - discountHalalas;

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
        16.verticalSpace,
        _SummaryRow(
          title: Translation.total_products.tr,
          halalas: subtotalHalalas,
        ),
        12.verticalSpace,
        _SummaryRow(
          title: Translation.shipping_cost.tr,
          halalas: shippingHalalas,
        ),
        12.verticalSpace,
        _SummaryRow(title: Translation.discount.tr, halalas: discountHalalas),
        24.verticalSpace,
        Container(height: 1, color: ColorM.gray200),
        24.verticalSpace,
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
              spacing: 3,
              children: [
                Text(
                  Money.amount(totalHalalas),
                  style: context.titleMedium.copyWith(
                    color: ColorM.primary700,
                    fontWeight: FontWeightM.bold,
                  ),
                ),
                SvgPicture.asset(
                  Assets.svg.saudiRiyalSymbol.path,
                  width: 14,
                  colorFilter: const ColorFilter.mode(
                    ColorM.primary700,
                    BlendMode.srcIn,
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
          spacing: 3,
          children: [
            Text(
              Money.amount(halalas),
              style: context.bodyMedium.copyWith(
                color: ColorM.gray600,
                fontWeight: FontWeightM.medium,
              ),
            ),
            SvgPicture.asset(
              Assets.svg.saudiRiyalSymbol.path,
              width: 12,
              colorFilter: const ColorFilter.mode(
                ColorM.gray600,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
