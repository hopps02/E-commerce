import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';

class CartSummaryBottomBar extends StatelessWidget {
  final int subtotalHalalas;
  final int deliveryFeeHalalas;
  final int discountHalalas;

  /// Backend-authoritative grand total (totals.total_halalas). Never re-derived
  /// on the client, so the customer always approves the server's number.
  final int totalHalalas;

  /// True while the delivery fee + total are being re-priced after a cart or
  /// address edit. The two server-priced rows show an "updating" spinner so a
  /// stale number is never displayed as final.
  final bool requoting;

  final VoidCallback? onCheckout;
  final VoidCallback? onConfirm;

  /// Shows the in-button spinner on the CTA while the order is being placed.
  final bool isLoading;

  /// Trailing space below the bar — defaults to the home-indicator inset; the
  /// cart tab passes the floating nav height so the bar clears it.
  final double? bottomPadding;

  const CartSummaryBottomBar({
    super.key,
    required this.subtotalHalalas,
    required this.deliveryFeeHalalas,
    required this.discountHalalas,
    required this.totalHalalas,
    this.requoting = false,
    this.onCheckout,
    this.onConfirm,
    this.isLoading = false,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorM.white,
        boxShadow: [
          BoxShadow(
            color: ColorM.gray900.withValues(alpha: 0.04),
            blurRadius: 31, // Same as product details
            offset: Offset(0, -17.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price Summary Title
                Text(
                  Translation.price_summary.tr,
                  style: context.bodyLarge.copyWith(
                    color: ColorM.gray900,
                    fontWeight: FontWeightM.medium,
                  ),
                ),
                10.verticalSpace,

                // Summary Items — product/discount rows track local edits live;
                // the shipping row is server-priced (spinner while re-quoting).
                _SummaryRow(
                  title: Translation.total_products.tr,
                  halalas: subtotalHalalas,
                ),
                6.verticalSpace,
                _SummaryRow(
                  title: Translation.shipping_cost.tr,
                  halalas: deliveryFeeHalalas,
                  loading: requoting,
                ),
                6.verticalSpace,
                _SummaryRow(
                  title: Translation.discount.tr,
                  halalas: discountHalalas,
                ),

                10.verticalSpace,

                // Divider
                Divider(color: const Color(0xFFDFDFDF), height: 1.h),

                10.verticalSpace,

                // Total Amount — backend-authoritative; "updating" while stale.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translation.total_amount.tr,
                      style: context.titleMedium.copyWith(
                        color: ColorM.gray900,
                        fontWeight: FontWeightM.medium,
                      ),
                    ),
                    _PriceWidget(
                      halalas: totalHalalas,
                      color: ColorM.primary700,
                      fontWeight: FontWeightM.semiBold,
                      loading: requoting,
                    ),
                  ],
                ),

                20.verticalSpace,

                // Checkout Button — disabled while re-quoting so the customer
                // can never confirm against an "updating" total.
                CustomInkButton(
                  onTap: onCheckout ?? onConfirm,
                  isLoading: isLoading || requoting,
                  width: double.infinity,
                  height: 56,
                  backgroundColor: ColorM.primary,
                  borderRadius: 16.r,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  alignment: Alignment.center,
                  child: Text(
                    onCheckout != null
                        ? Translation.order_now.tr
                        : Translation.confirm_order.tr,
                    style: context.bodyLarge.copyWith(
                      color: ColorM.white,
                      fontWeight: FontWeightM.medium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Safe Area spacing (or the floating-nav clearance in the cart tab).
          SizedBox(height: bottomPadding ?? context.bottomSafeAreaPadding),
        ],
      ),
    );
  }
}

class GuestCheckoutBottomBar extends StatelessWidget {
  final int subtotalHalalas;
  final int discountHalalas;
  final VoidCallback onCheckout;
  final double? bottomPadding;

  const GuestCheckoutBottomBar({
    super.key,
    required this.subtotalHalalas,
    required this.discountHalalas,
    required this.onCheckout,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorM.white,
        boxShadow: [
          BoxShadow(
            color: ColorM.gray900.withValues(alpha: 0.04),
            blurRadius: 31,
            offset: Offset(0, -17.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translation.price_summary.tr,
                  style: context.bodyLarge.copyWith(
                    color: ColorM.gray900,
                    fontWeight: FontWeightM.medium,
                  ),
                ),
                10.verticalSpace,
                _SummaryRow(
                  title: Translation.total_products.tr,
                  halalas: subtotalHalalas,
                ),
                6.verticalSpace,
                _SummaryRow(
                  title: Translation.discount.tr,
                  halalas: discountHalalas,
                ),
                12.verticalSpace,
                Text(
                  Translation.login_required_subtitle.tr,
                  style: context.bodyMedium.copyWith(color: ColorM.gray600),
                ),
                20.verticalSpace,
                CustomInkButton(
                  onTap: onCheckout,
                  width: double.infinity,
                  height: 56,
                  backgroundColor: ColorM.primary,
                  borderRadius: 16.r,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  alignment: Alignment.center,
                  child: Text(
                    Translation.order_now.tr,
                    style: context.bodyLarge.copyWith(
                      color: ColorM.white,
                      fontWeight: FontWeightM.medium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: bottomPadding ?? context.bottomSafeAreaPadding),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final int halalas;
  final bool loading;

  const _SummaryRow({
    required this.title,
    required this.halalas,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.bodyLarge.copyWith(
            color: ColorM.gray600,
            fontWeight: FontWeightM.regular,
          ),
        ),
        _PriceWidget(
          halalas: halalas,
          color: ColorM.gray600,
          fontWeight: FontWeightM.medium,
          loading: loading,
        ),
      ],
    );
  }
}

class _PriceWidget extends StatelessWidget {
  final int halalas;
  final Color color;
  final FontWeight fontWeight;
  final bool loading;

  const _PriceWidget({
    required this.halalas,
    required this.color,
    required this.fontWeight,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 1.8, color: color),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 3,
      children: [
        Text(
          Money.amount(halalas),
          style: context.bodyLarge.copyWith(
            color: color,
            fontWeight: fontWeight,
          ),
        ),
        SvgPicture.asset(
          Assets.svg.saudiRiyalSymbol.path,
          width: 12,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ],
    );
  }
}
