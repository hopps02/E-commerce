import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/views/auth_success/view/screens/auth_success_view.dart';
import 'package:for_u/presentation/views/cart/view/widgets/cart_summary_bottom_bar.dart';
import 'package:for_u/presentation/views/confirm_order/view/widgets/confirm_order_app_bar.dart';
import 'package:for_u/presentation/views/confirm_order/view/widgets/delivery_to.dart';
import 'package:for_u/presentation/views/confirm_order/view/widgets/orders.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

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

          Orders(),
        ],
      ),

      bottomNavigationBar: CartSummaryBottomBar(
        totalProducts: 200,
        shippingCost: 10,
        discount: 30,
        onConfirm: () {
          context.pushNamedAndKeepUntil(
            Routes.authSuccess,
            keepUntilName: Routes.home,
            arguments: AuthSuccessArgs(successViewType: SuccessViewType.order),
          );
        },
      ).containerSlideUp(),
    );
  }
}
