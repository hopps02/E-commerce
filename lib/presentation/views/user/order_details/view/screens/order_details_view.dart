import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/views/user/order_details/riverpod/order_details_controller.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_details_app_bar.dart';
import 'package:for_u/presentation/views/user/order_details/view/widgets/order_details_body.dart';

import '../../../../../../app/extensions/widget_extensions.dart';

class OrderDetailsView extends ConsumerStatefulWidget {
  const OrderDetailsView({super.key});

  @override
  ConsumerState<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends ConsumerState<OrderDetailsView> {
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
              alignment: const Alignment(0, -0.2),
              onRetry: () {},
              child: const OrderDetailsBody().containerSlideUp(),
            ),
          ),
        ],
      ),
    );
  }
}
