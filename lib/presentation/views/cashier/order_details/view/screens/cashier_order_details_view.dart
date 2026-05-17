import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/default_app_bar.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/cashier/order_details/riverpod/cashier_order_details_controller.dart';
import 'package:for_u/presentation/views/cashier/order_details/view/widgets/cashier_order_top_app_bar.dart';
import 'package:for_u/presentation/views/cashier/order_details/view/widgets/order_bottom_bar.dart';
import 'package:for_u/presentation/views/cashier/order_details/view/widgets/order_info_panel.dart';
import 'package:for_u/presentation/views/cashier/order_details/view/widgets/order_products_table.dart';

class CashierOrderDetailsView extends ConsumerStatefulWidget {
  final CashierOrderStatus initialStatus;

  const CashierOrderDetailsView({
    super.key,
    this.initialStatus = CashierOrderStatus.preparing,
  });

  @override
  ConsumerState<CashierOrderDetailsView> createState() =>
      _CashierOrderDetailsViewState();
}

class _CashierOrderDetailsViewState
    extends ConsumerState<CashierOrderDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(cashierOrderDetailsController.notifier)
          .seed(widget.initialStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cashierOrderDetailsController);

    return Scaffold(
      backgroundColor: ColorM.white,
      body: SafeArea(
        child: Column(
          children: [
            CashierOrderTopAppBar().premiumAppear(index: 0),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OrderInfoPanel(state: state).premiumAppear(index: 1),
                    16.verticalSpace,
                    GeneralPadding(
                      child: OrderProductsTable(state: state),
                    ).premiumAppear(index: 2),
                  ],
                ),
              ),
            ),
            OrderBottomBar(state: state).premiumAppear(index: 3),
          ],
        ),
      ),
    );
  }
}
