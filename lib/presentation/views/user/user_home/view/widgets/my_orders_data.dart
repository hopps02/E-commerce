import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/navigation_extension.dart';
import 'package:store/app/extensions/widget_extensions.dart';
import 'package:store/app/ui_kit/customized_smart_refresh.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/views/user/order_details/view/screens/order_details_view.dart';
import 'package:store/presentation/views/user/user_home/riverpod/my_orders_tab_controller.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/order_card.dart';

import '../../../../../res/router/app_router.dart';

enum MyOrdersDataType {
  current,
  previous;

  String get group => this == MyOrdersDataType.current
      ? MyOrdersTabNotifier.currentGroup
      : MyOrdersTabNotifier.previousGroup;
}

class MyOrdersData extends ConsumerStatefulWidget {
  final double bottomSafeAreaPadding;
  final MyOrdersDataType myOrdersDataType;
  const MyOrdersData({
    super.key,
    required this.bottomSafeAreaPadding,
    required this.myOrdersDataType,
  });
  @override
  ConsumerState<MyOrdersData> createState() => _MyOrdersDataState();
}

class _MyOrdersDataState extends ConsumerState<MyOrdersData>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(
      myOrdersTabController.select(
        (state) => widget.myOrdersDataType == MyOrdersDataType.current
            ? state.currentData
            : state.previousData,
      ),
    );
    final notifier = ref.read(myOrdersTabController.notifier);
    final refreshController =
        widget.myOrdersDataType == MyOrdersDataType.current
        ? notifier.currentRefreshController
        : notifier.previousRefreshController;
    return FastStateRender(
      reqState: state.reqState,
      errorMessage: state.msgError,
      alignment: Alignment(0, -0.4),
      onRetry: () => notifier.refreshGroup(widget.myOrdersDataType.group),
      child: CustomizedSmartRefresh(
        controller: refreshController,
        enableLoading: true,
        enableRefresh: true,
        classicFooterPadding: EdgeInsets.only(
          bottom: widget.bottomSafeAreaPadding,
        ),
        onLoading: () => notifier.loadMore(widget.myOrdersDataType.group),
        onRefresh: () => notifier.refreshGroup(widget.myOrdersDataType.group),
        child: ListView.separated(
          padding: EdgeInsets.only(
            left: SizeM.pagePadding,
            right: SizeM.pagePadding,
            top: 8,
            bottom: SizeM.pagePadding,
          ),
          itemCount: state.orders.length,
          separatorBuilder: (context, index) => 16.verticalSpace,
          itemBuilder: (context, index) {
            final order = state.orders[index];
            return OrderCard(
              order: order,
              onTapDetails: () => context.pushNamed(
                Routes.orderDetails,
                arguments: OrderDetailsArgs(orderId: order.id),
              ),
            );
          },
        ),
      ).premiumAppear(),
    );
  }
}
