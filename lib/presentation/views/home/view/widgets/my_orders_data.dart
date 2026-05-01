import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/ui_components/customized_smart_refresh.dart';
import 'package:jar/presentation/common/fast_state_render.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/views/home/riverpod/my_orders_tab_controller.dart';
import 'package:jar/presentation/views/home/view/widgets/order_card.dart';

enum MyOrdersDataType { current, previous }

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
      onRetry: () {},
      child: CustomizedSmartRefresh(
        controller: refreshController,
        enableLoading: true,
        enableRefresh: true,
        classicFooterPadding: EdgeInsets.only(
            bottom: widget.bottomSafeAreaPadding,
          ),
        onLoading: () {
          Timer(const Duration(seconds: 2), () {
            refreshController.loadComplete();
          });
        },
        onRefresh: () {
          Timer(const Duration(seconds: 2), () {
            refreshController.refreshCompleted();
          });
        },
        child: ListView.separated(
          padding: EdgeInsets.only(
            left: SizeM.pagePadding.w,
            right: SizeM.pagePadding.w,
            top: 8.h,
            bottom: SizeM.pagePadding.h,
          ),
          itemCount: 3,
          separatorBuilder: (context, index) => 16.verticalSpace,
          itemBuilder: (context, index) => OrderCard(step: (index % 3) + 1),
        ),
      ),
    );
  }
}
