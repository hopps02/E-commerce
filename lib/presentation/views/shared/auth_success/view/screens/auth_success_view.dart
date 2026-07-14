import 'package:flutter/material.dart';
import 'package:store/app/enums/enums.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/shared/auth_success/view/widgets/body.dart';
import 'package:store/presentation/views/shared/auth_success/view/widgets/loading.dart';

class AuthSuccessArgs {
  final SuccessViewType successViewType;

  /// Set on order success: the CTA opens this order's details.
  final int? orderId;
  final String? orderNumber;

  const AuthSuccessArgs({
    required this.successViewType,
    this.orderId,
    this.orderNumber,
  });
}

class AuthSuccessView extends StatelessWidget {
  final AuthSuccessArgs args;
  const AuthSuccessView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: args.successViewType.isOrder
          ? ColorM.greenPrimary
          : ColorM.white,
      body: SafeArea(
        child: ResponsiveConstrained(
          maxWidth: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              Loading(),

              const Spacer(),

              Body(
                successViewType: args.successViewType,
                orderId: args.orderId,
                orderNumber: args.orderNumber,
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
