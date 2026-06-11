import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/utils/money.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/confirm_order/view/widgets/order_item.dart';
import 'package:for_u/presentation/views/user/order_details/riverpod/order_details_controller.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_delivery_address.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_price_summary.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_status_section.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/rate_order_button.dart';

class OrderDetailsBody extends StatelessWidget {
  final OrderDetailsState state;
  const OrderDetailsBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final arabic = context.locale.languageCode == 'ar';

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorM.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderStatusSection(
                    step: state.step,
                    orderNumber: state.orderNumber,
                  ).premiumAppear(index: 0),
                  24.verticalSpace,
                  OrderDeliveryAddress(
                    address: state.address,
                  ).premiumAppear(index: 1),
                  24.verticalSpace,
                  Text(
                    Translation.orders.tr,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeightM.bold,
                    ),
                  ).premiumAppear(index: 2),
                  16.verticalSpace,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: state.items.length,
                    separatorBuilder: (context, index) => 16.verticalSpace,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Order(
                        title: item.name(arabic),
                        weight: "",
                        price: Money.amount(item.unitPriceHalalas),
                        count: "${item.quantity}",
                        image: item.imageUrl ?? "",
                      ).premiumAppear(index: 3 + index);
                    },
                  ),
                  32.verticalSpace,
                  OrderPriceSummary(
                    subtotalHalalas: state.totals.subtotalHalalas,
                    shippingHalalas: state.totals.deliveryFeeHalalas,
                    discountHalalas: state.totals.discountHalalas,
                  ).premiumAppear(index: 6),
                ],
              ),
            ),
          ),
          // Eligibility comes from the backend: delivered, unrated, in window.
          if (state.canRate) const RateOrderButton().premiumAppear(index: 7),
        ],
      ),
    );
  }
}
