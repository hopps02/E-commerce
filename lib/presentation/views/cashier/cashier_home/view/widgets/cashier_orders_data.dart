import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/ui_kit/customized_smart_refresh.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/cashier/order_details/view/screens/cashier_order_details_view.dart';
import 'package:for_u/presentation/views/cashier/order_details/view/widgets/assign_captain_bottom_sheet.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/riverpod/cashier_tab_controller.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/widgets/cashier_order_card.dart';

enum CashierOrdersDataType {
  preparation,
  onTheWay,
  exceptions;

  bool get isPreparation => this == CashierOrdersDataType.preparation;
  bool get isOnTheWay => this == CashierOrdersDataType.onTheWay;

  String get queue => switch (this) {
    CashierOrdersDataType.preparation => 'preparation',
    CashierOrdersDataType.onTheWay => 'on_the_way',
    CashierOrdersDataType.exceptions => 'exceptions',
  };
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

  Future<void> _openDetails(CashierOrder order) async {
    await context.pushNamed(
      Routes.cashierOrderDetails,
      arguments: CashierOrderDetailsArgs(orderId: order.id),
    );
    // The cashier may have changed the order inside; reload all queues.
    if (mounted) ref.read(cashierTabController.notifier).loadInitial();
  }

  Future<void> _assignCaptain(CashierOrder order) async {
    final updated = await AssignCaptainBottomSheet.show(
      context,
      orderId: order.id,
    );
    if (updated != null && mounted) {
      ref.read(cashierTabController.notifier).loadInitial();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(
      cashierTabController.select(
        (s) => switch (widget.type) {
          CashierOrdersDataType.preparation => s.preparationData,
          CashierOrdersDataType.onTheWay => s.onTheWayData,
          CashierOrdersDataType.exceptions => s.exceptionsData,
        },
      ),
    );
    final notifier = ref.read(cashierTabController.notifier);
    final refreshController = switch (widget.type) {
      CashierOrdersDataType.preparation => notifier.preparationRefreshController,
      CashierOrdersDataType.onTheWay => notifier.onTheWayRefreshController,
      CashierOrdersDataType.exceptions => notifier.exceptionsRefreshController,
    };

    return FastStateRender(
      reqState: state.reqState,
      errorMessage: state.msgError,
      alignment: const Alignment(0, -0.4),
      onRetry: () => notifier.refreshQueue(widget.type.queue),
      child: CustomizedSmartRefresh(
        controller: refreshController,
        enableLoading: true,
        enableRefresh: true,
        classicFooterPadding: EdgeInsets.only(
          bottom: context.bottomSafeAreaPadding + 16.h,
        ),
        onLoading: () => notifier.loadMore(widget.type.queue),
        onRefresh: () => notifier.refreshQueue(widget.type.queue),
        child: ListView.separated(
          padding: EdgeInsets.only(
            left: SizeM.pagePadding.w,
            right: SizeM.pagePadding.w,
            top: 12.h,
            bottom: 16.h,
          ),
          itemCount: state.orders.length,
          separatorBuilder: (_, _) => 16.verticalSpace,
          itemBuilder: (context, index) {
            final order = state.orders[index];
            if (widget.type.isPreparation) {
              final requiresCaptain =
                  order.uiStatus == CashierOrderStatus.readyForCaptain;
              return CashierPreparationCard(
                order: order,
                onTapAction: requiresCaptain
                    ? () => _assignCaptain(order)
                    : () => _openDetails(order),
              );
            }
            return CashierOnTheWayCard(
              order: order,
              onTapDetails: () => _openDetails(order),
            );
          },
        ),
      ),
    );
  }
}
