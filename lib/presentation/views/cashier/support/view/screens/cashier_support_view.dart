import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/views/cashier/support/view/widgets/cashier_support_app_bar.dart';
import 'package:for_u/presentation/views/cashier/support/view/widgets/cashier_support_body.dart';
import 'package:for_u/presentation/views/cashier/support/view/widgets/cashier_support_send_button.dart';

import '../../riverpod/cashier_support_controller.dart' show cashierSupportController;

class CashierSupportView extends ConsumerWidget {
  const CashierSupportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(cashierSupportController, (previous, next) {
      if(next){
        context.pop();
      }
    });
    return Scaffold(
      backgroundColor: ColorM.white,
      body: SafeArea(
        child: Column(
          children: [
            const CashierSupportAppBar().premiumAppear(index: 0),
            const Expanded(child: CashierSupportBody()),
            const CashierSupportSendButton(),
          ],
        ),
      ),
    );
  }
}
