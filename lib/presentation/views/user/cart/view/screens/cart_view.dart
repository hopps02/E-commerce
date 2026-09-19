import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/cart/riverpod/checkout_controller.dart';
import 'package:store/presentation/views/user/cart/view/widgets/cart_app_bar.dart';
import 'package:store/presentation/views/user/cart/view/widgets/cart_data.dart';
import 'package:store/presentation/views/user/cart/view/widgets/cart_summary_bottom_bar.dart';
import 'package:store/app/extensions/widget_extensions.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  void initState() {
    super.initState();
    // Re-validate lines and price the order whenever the cart opens.
    Future.microtask(() => ref.read(checkoutController.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartController);
    final checkout = ref.watch(checkoutController);
    final guestMode = ref
        .watch(isGuestProvider)
        .maybeWhen(data: (guest) => guest, orElse: () => false);

    return Scaffold(
      backgroundColor: ColorM.white,
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: Column(
          children: [
            // Status bar space
            SizedBox(height: context.topSafeAreaPadding),

            // App Bar
            CartAppBar().premiumAppear(index: 0),

            // Thin divider
            Container(height: 6, color: ColorM.gray150).premiumAppear(index: 1),

            // Scrollable body
            const CartData(),
          ],
        ),
      ),

      // Summary Bottom Bar — totals are backend-quoted; product/discount rows
      // track local quantity edits live.
      bottomNavigationBar: guestMode && !cart.isEmpty
          ? ResponsiveConstrained(
              maxWidth: 450,
              heightFactor: 1,
              child: GuestCheckoutBottomBar(
                subtotalHalalas: cart.subtotalHalalas,
                discountHalalas: cart.discountHalalas,
                onCheckout: () async {
                  if (!await requireLogin(context, ref)) return;
                  context.pushNamed(Routes.confirmOrder);
                },
              ).containerSlideUp(),
            )
          : checkout.reqState.isSuccess && !cart.isEmpty
          ? ResponsiveConstrained(
              maxWidth: 450,
              heightFactor: 1,
              child: CartSummaryBottomBar(
                subtotalHalalas: cart.subtotalHalalas,
                deliveryFeeHalalas: checkout.totals.deliveryFeeHalalas,
                discountHalalas: cart.discountHalalas,
                vatHalalas: checkout.totals.vatHalalas,
                totalHalalas: checkout.totals.totalHalalas,
                requoting: checkout.requoting,
                onCheckout: () async {
                  if (!await requireLogin(context, ref)) return;
                  context.pushNamed(Routes.confirmOrder);
                },
              ).containerSlideUp(),
            )
          : null,
    );
  }
}
