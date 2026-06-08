import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/confirm_order/view/widgets/order_item.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_delivery_address.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_price_summary.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_status_section.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/rate_order_button.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const OrderStatusSection(step: 3).premiumAppear(index: 0),
                  24.verticalSpace,
                  const OrderDeliveryAddress().premiumAppear(index: 1),
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
                    itemCount: 3,
                    separatorBuilder: (context, index) => 16.verticalSpace,
                    itemBuilder: (context, index) {
                      return const Order(
                        title: "جزر أصفر (Hills Farm) · جزر شانتينيه",
                        weight: "2 kg",
                        price: "12",
                        count: "2",
                        image: "",
                      ).premiumAppear(index: 3 + index);
                    },
                  ),
                  32.verticalSpace,
                  const OrderPriceSummary(
                    totalProducts: 12,
                    shippingCost: 12,
                    discount: 12,
                  ).premiumAppear(index: 6),
                ],
              ),
            ),
          ),
          const RateOrderButton().premiumAppear(index: 7),
        ],
      ),
    );
  }
}
