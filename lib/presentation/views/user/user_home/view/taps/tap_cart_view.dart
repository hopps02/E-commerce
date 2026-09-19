import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/cart/riverpod/cart_controller.dart';
import 'package:store/presentation/views/user/cart/riverpod/checkout_controller.dart';
import 'package:store/presentation/views/user/cart/view/widgets/cart_data.dart';
import 'package:store/presentation/views/user/cart/view/widgets/cart_summary_bottom_bar.dart';
import 'package:store/presentation/views/user/user_home/riverpod/bottom_navigation_controller.dart';
import 'package:store/app/extensions/widget_extensions.dart';
import 'package:store/presentation/res/spacing_manager.dart';

/// The cart as a first-class tab — keeps the app's bottom navigation visible
/// (unlike the pushed [CartView] reached from product details). Re-prices the
/// order whenever the cart tab is opened.
class TapCartView extends ConsumerStatefulWidget {
  final double bottomSafeAreaPadding;
  const TapCartView({super.key, required this.bottomSafeAreaPadding});

  /// Index of the cart in the bottom nav (home, cart, orders, profile).
  static const int navIndex = 1;

  @override
  ConsumerState<TapCartView> createState() => _TapCartViewState();
}

class _TapCartViewState extends ConsumerState<TapCartView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(checkoutController.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Re-validate and re-price each time the cart tab is reselected.
    ref.listen(bottomNavigationController.select((s) => s.selectedIndex), (
      _,
      next,
    ) {
      if (next == TapCartView.navIndex) {
        ref.read(checkoutController.notifier).load();
      }
    });

    final cart = ref.watch(cartController);
    final checkout = ref.watch(checkoutController);
    final guestMode = ref
        .watch(isGuestProvider)
        .maybeWhen(data: (guest) => guest, orElse: () => false);
    final showSummary = checkout.reqState.isSuccess && !cart.isEmpty;

    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SpaceM.s4.h),
            child: Text(
              Translation.cart.tr,
              style: context.titleMedium.copyWith(fontWeight: FontWeightM.bold),
            ),
          ).premiumAppear(index: 0),
          Container(height: 6, color: ColorM.gray150).premiumAppear(index: 1),
          const CartData(),
          if (guestMode && !cart.isEmpty)
            GuestCheckoutBottomBar(
              subtotalHalalas: cart.subtotalHalalas,
              discountHalalas: cart.discountHalalas,
              bottomPadding: widget.bottomSafeAreaPadding,
              onCheckout: () async {
                if (!await requireLogin(context, ref)) return;
                context.pushNamed(Routes.confirmOrder);
              },
            ).containerSlideUp(),
          if (!guestMode && showSummary)
            CartSummaryBottomBar(
              subtotalHalalas: cart.subtotalHalalas,
              deliveryFeeHalalas: checkout.totals.deliveryFeeHalalas,
              discountHalalas: cart.discountHalalas,
              totalHalalas: checkout.totals.totalHalalas,
              requoting: checkout.requoting,
              bottomPadding: widget.bottomSafeAreaPadding,
              onCheckout: () async {
                if (!await requireLogin(context, ref)) return;
                context.pushNamed(Routes.confirmOrder);
              },
            ).containerSlideUp(),
        ],
      ),
    );
  }
}
