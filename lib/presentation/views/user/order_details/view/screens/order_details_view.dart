import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/views/user/order_details/riverpod/order_details_controller.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_details_app_bar.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_details_body.dart';

import '../../../../../../app/extensions/widget_extensions.dart';

class OrderDetailsArgs {
  final int orderId;

  const OrderDetailsArgs({required this.orderId});
}

class OrderDetailsView extends ConsumerStatefulWidget {
  final OrderDetailsArgs args;

  const OrderDetailsView({super.key, required this.args});

  @override
  ConsumerState<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends ConsumerState<OrderDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderDetailsController.notifier).load(widget.args.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailsState = ref.watch(orderDetailsController);
    return Scaffold(
      backgroundColor: ColorM.primary800, // The top app bar background
      body: Column(
        children: [
          const OrderDetailsAppBar(),
          Expanded(
            child: FastStateRender(
              reqState: orderDetailsState.reqState,
              errorMessage: orderDetailsState.errorMessage,
              alignment: const Alignment(0, -0.2),
              onRetry: () => ref
                  .read(orderDetailsController.notifier)
                  .load(widget.args.orderId),
              child: OrderDetailsBody(
                state: orderDetailsState,
              ).containerSlideUp(),
            ),
          ),
        ],
      ),
    );
  }
}
