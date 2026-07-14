import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/cashier/order_details/riverpod/cashier_order_details_controller.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/cashier_order_top_app_bar.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/order_bottom_bar.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/order_info_panel.dart';
import 'package:store/presentation/views/cashier/order_details/view/widgets/order_products_table.dart';

class CashierOrderDetailsArgs {
  final int orderId;

  const CashierOrderDetailsArgs({required this.orderId});
}

class CashierOrderDetailsView extends ConsumerStatefulWidget {
  final CashierOrderDetailsArgs args;

  const CashierOrderDetailsView({super.key, required this.args});

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
          .load(widget.args.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cashierOrderDetailsController);

    return Scaffold(
      backgroundColor: ColorM.white,
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: SafeArea(
          child: FastStateRender(
            reqState: state.reqState,
            errorMessage: state.msgError,
            onRetry: () => ref
                .read(cashierOrderDetailsController.notifier)
                .load(widget.args.orderId),
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
        ),
      ),
    );
  }
}
