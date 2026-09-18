import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/customized_smart_refresh.dart';
import 'package:store/app/utils/money.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/views/user/confirm_order/view/widgets/order_item.dart';
import 'package:store/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:store/presentation/views/user/order_details/riverpod/order_details_controller.dart';
import 'package:store/presentation/views/user/order_details/view/widgets/order_delivery_address.dart';
import 'package:store/presentation/views/user/order_details/view/widgets/order_price_summary.dart';
import 'package:store/presentation/views/user/order_details/view/widgets/order_rated_confirmation.dart';
import 'package:store/presentation/views/user/order_details/view/widgets/order_status_section.dart';
import 'package:store/presentation/views/user/order_details/view/widgets/rate_order_button.dart';

class OrderDetailsBody extends StatelessWidget {
  final OrderDetailsState state;
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  const OrderDetailsBody({
    super.key,
    required this.state,
    required this.refreshController,
    required this.onRefresh,
  });

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
            child: CustomizedSmartRefresh(
              controller: refreshController,
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderStatusSection(
                      step: state.step,
                      orderNumber: state.orderNumber,
                      orderState: state.orderState,
                      stateLabel: state.stateLabel,
                      whatsappUrl: state.whatsappUrl,
                      failureReason: state.failureReason,
                      failureNote: state.failureNote,
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
                          // The shelf row the line was bought from is exactly
                          // what the product screen loads.
                          onTap: item.branchItemId == null
                              ? null
                              : () => context.pushNamed(
                                  Routes.productDetails,
                                  arguments: ProductDetailsViewArgs(
                                    productId: item.branchItemId!,
                                  ),
                                ),
                        ).premiumAppear(index: 3 + index);
                      },
                    ),
                    if (state.removedItems.isNotEmpty) ...[
                      24.verticalSpace,
                      Text(
                        Translation.unavailable_items.tr,
                        style: context.bodyLarge.copyWith(
                          fontWeight: FontWeightM.bold,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        Translation.unavailable_items_note.tr,
                        style: context.labelMedium.copyWith(
                          color: ColorM.gray500,
                        ),
                      ),
                      16.verticalSpace,
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: state.removedItems.length,
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemBuilder: (context, index) {
                          final item = state.removedItems[index];
                          return Opacity(
                            opacity: 0.5,
                            child: Order(
                              title: item.name(arabic),
                              weight: "",
                              price: Money.amount(item.unitPriceHalalas),
                              count: "${item.quantity}",
                              image: item.imageUrl ?? "",
                            ),
                          );
                        },
                      ),
                    ],
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
          ),
          // Eligibility comes from the backend: delivered, unrated, in window.
          if (state.canRate)
            const RateOrderButton().premiumAppear(index: 7)
          else if (state.justRated)
            OrderRatedConfirmation(
              overall: state.ratedOverall,
            ).premiumAppear(index: 7),
        ],
      ),
    );
  }
}
