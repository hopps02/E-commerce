import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/user/order_details/riverpod/order_details_controller.dart';
import 'package:store/presentation/views/user/order_details/view/widgets/order_details_app_bar.dart';
import 'package:store/presentation/views/user/order_details/view/widgets/order_details_body.dart';
import 'package:store/presentation/views/user/order_details/view/widgets/rate_order_bottom_sheet.dart';

import '../../../../../../app/extensions/widget_extensions.dart';

class OrderDetailsArgs {
  final int orderId;

  /// Set when the screen is opened from the "order delivered — tap to rate"
  /// notification: once the order loads and rating is still allowed, the rating
  /// sheet opens on its own so the customer lands straight on the prompt.
  final bool openRating;

  const OrderDetailsArgs({required this.orderId, this.openRating = false});
}

class OrderDetailsView extends ConsumerStatefulWidget {
  final OrderDetailsArgs args;

  const OrderDetailsView({super.key, required this.args});

  @override
  ConsumerState<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends ConsumerState<OrderDetailsView> {
  final RefreshController _refreshController = RefreshController();

  // Guards the deep-link auto-open so the sheet pops at most once per visit.
  bool _ratingAutoOpened = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderDetailsController.notifier).load(widget.args.orderId);
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(orderDetailsController.notifier).silentRefresh();
    _refreshController.refreshCompleted();
  }

  /// When opened from the "tap to rate" notification, pop the rating sheet as
  /// soon as the order has loaded and rating is still allowed.
  void _maybeAutoOpenRating(OrderDetailsState state) {
    if (!widget.args.openRating || _ratingAutoOpened || !state.canRate) return;
    _ratingAutoOpened = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => _openRatingSheet());
  }

  Future<void> _openRatingSheet() async {
    if (!mounted) return;
    final result = await RateOrderBottomSheet.show(context);
    if (result == null || !mounted) return;
    await ref
        .read(orderDetailsController.notifier)
        .rate(
          overall: result.overall,
          captain: result.deliveryRep,
          orderAccuracy: result.orderMatch,
          deliverySpeed: result.deliverySpeed,
          comment: result.comment,
        );
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailsState = ref.watch(orderDetailsController);
    ref.listen(orderDetailsController, (_, next) => _maybeAutoOpenRating(next));
    return Scaffold(
      backgroundColor: ColorM.primary800, // The top app bar background
      body: ResponsiveConstrained(
        maxWidth: 600,
        child: Column(
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
                  refreshController: _refreshController,
                  onRefresh: _onRefresh,
                ).containerSlideUp(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
