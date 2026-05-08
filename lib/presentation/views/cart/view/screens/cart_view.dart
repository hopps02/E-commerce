import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/views/cart/riverpod/cart_controller.dart';
import 'package:jar/presentation/views/cart/view/widgets/cart_app_bar.dart';
import 'package:jar/presentation/views/cart/view/widgets/cart_data.dart';
import 'package:jar/presentation/views/cart/view/widgets/cart_summary_bottom_bar.dart';
import 'package:jar/app/extensions/widget_extensions.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cartController);
    final notifier = ref.read(cartController.notifier);

    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          // Status bar space
          SizedBox(height: context.topSafeAreaPadding),

          // App Bar
          CartAppBar().premiumAppear(index: 0),

          // Thin divider
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),

          // Scrollable body
          CartData(state: state, notifier: notifier),
        ],
      ),

      // Summary Bottom Bar
      bottomNavigationBar: state.reqState.isSuccess
          ? CartSummaryBottomBar(
              totalProducts: 200,
              shippingCost: 10,
              discount: 30,
              onCheckout: () {
                context.pushNamed(RoutesManager.confirmOrder.route);
              },
            ).containerSlideUp()
          : null,
    );
  }
}
