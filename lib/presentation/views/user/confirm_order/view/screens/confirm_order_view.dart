import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/enums/enums.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/extensions/navigation_extension.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/common/cart_branch_resolution_state.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/views/shared/auth_success/view/screens/auth_success_view.dart';
import 'package:store/presentation/views/user/addresses/view/widgets/address_picker_bottom_sheet.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/cart/riverpod/checkout_controller.dart';
import 'package:store/presentation/views/user/cart/view/widgets/cart_summary_bottom_bar.dart';
import 'package:store/presentation/views/user/confirm_order/view/widgets/confirm_order_app_bar.dart';
import 'package:store/presentation/views/user/confirm_order/view/widgets/delivery_to.dart';
import 'package:store/presentation/views/user/confirm_order/view/widgets/orders.dart';
import 'package:store/app/extensions/widget_extensions.dart';

class ConfirmOrderView extends ConsumerStatefulWidget {
  const ConfirmOrderView({super.key});

  @override
  ConsumerState<ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends ConsumerState<ConfirmOrderView> {
  @override
  void initState() {
    super.initState();
    // Normally primed by the cart screen. ensureQuote() self-loads on a cold
    // open AND re-prices if the cart was edited between the cart screen and
    // here, so the confirm totals are never stale.
    Future.microtask(_ensureAccessAndLoadQuote);
  }

  /// Opens the saved-address sheet. Returns true once an address is set —
  /// either it already was, or the customer just picked one.
  Future<bool> _changeAddress() async {
    final picked = await AddressPickerBottomSheet.show(context, ref);
    if (picked == null || !mounted) return ref.read(checkoutController).addressId != null;
    await ref.read(checkoutController.notifier).selectAddress(picked);
    return true;
  }

  Future<void> _placeOrder() async {
    if (!await requireLogin(context, ref)) return;

    // Confirming without an address asks for one here rather than refusing:
    // the order is otherwise ready, and this is the last thing missing.
    if (ref.read(checkoutController).addressId == null) {
      if (!await _changeAddress()) return;
      if (!mounted) return;
    }

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

  Future<void> _ensureAccessAndLoadQuote() async {
    if (!await requireLogin(context, ref)) {
      if (mounted) Navigator.of(context).maybePop();
      return;
    }
    await ref.read(checkoutController.notifier).ensureQuote();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartController);
    final checkout = ref.watch(checkoutController);

    return Scaffold(
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: Column(
          children: [
            // Status bar space
            SizedBox(height: context.topSafeAreaPadding),

            // App Bar
            ConfirmOrderAppBar().premiumAppear(index: 0),

            GestureDetector(
              onTap: () => _changeAddress(),
              behavior: HitTestBehavior.opaque,
              child: DeliveryTo(address: checkout.addressLine),
            ).premiumAppear(index: 1),

            18.verticalSpace,

            if (checkout.requiresCartBranchResolution)
              Expanded(
                child: CartBranchResolutionState(
                  message: checkout.errorMessage,
                  onClearCart: () {
                    ref.read(cartController.notifier).clear();
                    context.goNamed(Routes.home);
                  },
                  onDismiss: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).maybePop();
                      return;
                    }
                    context.goNamed(Routes.home);
                  },
                ),
              )
            else
              Orders(lines: cart.lines),
          ],
        ),
      ),

      bottomNavigationBar: checkout.reqState.isSuccess
          ? ResponsiveConstrained(
              maxWidth: 450,
              heightFactor: 1,
              child: CartSummaryBottomBar(
                subtotalHalalas: cart.subtotalHalalas,
                deliveryFeeHalalas: checkout.totals.deliveryFeeHalalas,
                discountHalalas: cart.discountHalalas,
                totalHalalas: checkout.totals.totalHalalas,
                requoting: checkout.requoting,
                onConfirm: _placeOrder,
                isLoading: checkout.placing,
              ).containerSlideUp(),
            )
          : null,
    );
  }
}
