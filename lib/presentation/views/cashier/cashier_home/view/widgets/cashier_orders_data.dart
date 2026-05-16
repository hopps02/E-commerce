import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/ui_components/customized_smart_refresh.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/riverpod/cashier_tab_controller.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_order_card.dart';

enum CashierOrdersDataType {
  preparation,
  onTheWay;
  bool get isPreparation => this == CashierOrdersDataType.preparation;
  bool get isOnTheWay => this == CashierOrdersDataType.onTheWay;
}

class CashierOrdersData extends ConsumerStatefulWidget {
  final CashierOrdersDataType type;

  const CashierOrdersData({super.key, required this.type});

  @override
  ConsumerState<CashierOrdersData> createState() => _CashierOrdersDataState();
}

class _CashierOrdersDataState extends ConsumerState<CashierOrdersData>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(
      cashierTabController.select(
        (s) => widget.type.isPreparation ? s.preparationData : s.onTheWayData,
      ),
    );
    final notifier = ref.read(cashierTabController.notifier);
    final refreshController = widget.type.isPreparation
        ? notifier.preparationRefreshController
        : notifier.onTheWayRefreshController;

    final itemCount = widget.type.isPreparation ? 10 : 20;

    return FastStateRender(
      reqState: state.reqState,
      errorMessage: state.msgError,
      alignment: const Alignment(0, -0.4),
      onRetry: () {},
      child: CustomizedSmartRefresh(
        controller: refreshController,
        enableLoading: true,
        enableRefresh: true,
        classicFooterPadding: EdgeInsets.only(
          bottom: context.bottomSafeAreaPadding + 16.h,
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
            top: 12.h,
            bottom: 16.h,
          ),
          itemCount: itemCount,
          separatorBuilder: (_, _) => 16.verticalSpace,
          itemBuilder: (context, index) {
            print("rebuild ${widget.type} $index");
            if (widget.type.isPreparation) {
              return CashierPreparationCard(
                requiresCaptain: index % 2 == 1,
                onTapAction: () {},
              );
            }
            return CashierOnTheWayCard(onTapDetails: () {});
          },
        ),
      ),
    );
  }
}
