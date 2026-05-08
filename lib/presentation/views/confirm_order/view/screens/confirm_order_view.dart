import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/enums/enums.dart';
import 'package:jar/app/extensions/navigation_extension.dart';
import 'package:jar/app/extensions/view_extensions.dart';
import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/views/auth_success/view/screens/auth_success_view.dart';
import 'package:jar/presentation/views/cart/view/widgets/cart_summary_bottom_bar.dart';
import 'package:jar/presentation/views/confirm_order/view/widgets/confirm_order_app_bar.dart';
import 'package:jar/presentation/views/confirm_order/view/widgets/delivery_to.dart';
import 'package:jar/presentation/views/confirm_order/view/widgets/orders.dart';
import 'package:jar/app/extensions/widget_extensions.dart';

class ConfirmOrderView extends StatefulWidget {
  const ConfirmOrderView({super.key});

  @override
  State<ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends State<ConfirmOrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Status bar space
          SizedBox(height: context.topSafeAreaPadding),

          // App Bar
          ConfirmOrderAppBar().premiumAppear(index: 0),

          DeliveryTo().premiumAppear(index: 1),

          18.verticalSpace,

          Orders()
          
        ],
      ),

      bottomNavigationBar: CartSummaryBottomBar(
              totalProducts: 200,
              shippingCost: 10,
              discount: 30,
              onConfirm: () {
                context.pushNamedAndRemoveUntil(
                  RoutesManager.authSuccess.route,
                  (route) => route.settings.name == RoutesManager.home.route,
                  arguments: AuthSuccessArgs(
                    successViewType: SuccessViewType.order,
                  ),
                );
              },
            ).containerSlideUp(),
    );
  }
}
