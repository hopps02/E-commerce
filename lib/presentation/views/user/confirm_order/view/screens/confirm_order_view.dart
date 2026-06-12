import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/utils/money.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/views/shared/auth_success/view/screens/auth_success_view.dart';
import 'package:for_u/presentation/views/user/addresses/view/widgets/address_picker_bottom_sheet.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/checkout_controller.dart';
import 'package:for_u/presentation/views/user/cart/view/widgets/cart_summary_bottom_bar.dart';
import 'package:for_u/presentation/views/user/confirm_order/view/widgets/confirm_order_app_bar.dart';
import 'package:for_u/presentation/views/user/confirm_order/view/widgets/delivery_to.dart';
import 'package:for_u/presentation/views/user/confirm_order/view/widgets/orders.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class ConfirmOrderView extends ConsumerStatefulWidget {
  const ConfirmOrderView({super.key});

  @override
  ConsumerState<ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends ConsumerState<ConfirmOrderView> {
  @override
  void initState() {
    super.initState();
    // Normally primed by the cart screen; a cold open still self-loads.
    Future.microtask(() {
      if (!ref.read(checkoutController).reqState.isSuccess) {
        ref.read(checkoutController.notifier).load();
      }
    });
  }

  Future<void> _changeAddress() async {
    final picked = await AddressPickerBottomSheet.show(context);
    if (picked == null || !mounted) return;
    await ref.read(checkoutController.notifier).selectAddress(picked);
  }

  Future<void> _placeOrder() async {
    final order = await ref.read(checkoutController.notifier).placeOrder();
    if (order == null || !mounted) return;

    context.pushNamedAndKeepUntil(
      Routes.authSuccess,
      keepUntilName: Routes.home,
      arguments: AuthSuccessArgs(
        successViewType: SuccessViewType.order,
        orderId: order.id,
        orderNumber: order.orderNumber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartController);
    final checkout = ref.watch(checkoutController);

    return Scaffold(
      body: Column(
        children: [
          // Status bar space
          SizedBox(height: context.topSafeAreaPadding),

          // App Bar
          ConfirmOrderAppBar().premiumAppear(index: 0),

          GestureDetector(
            onTap: _changeAddress,
            behavior: HitTestBehavior.opaque,
            child: DeliveryTo(address: checkout.addressLine),
          ).premiumAppear(index: 1),

          18.verticalSpace,

          Orders(lines: cart.lines),
        ],
      ),

      bottomNavigationBar: checkout.reqState.isSuccess
          ? CartSummaryBottomBar(
              totalProducts: Money.asRiyals(cart.subtotalHalalas),
              shippingCost: Money.asRiyals(
                checkout.totals.deliveryFeeHalalas,
              ),
              discount: Money.asRiyals(cart.discountHalalas),
              onConfirm: _placeOrder,
            ).containerSlideUp()
          : null,
    );
  }
}
