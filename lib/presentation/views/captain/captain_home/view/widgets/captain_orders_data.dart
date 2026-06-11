import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/ui_kit/customized_smart_refresh.dart';
import 'package:for_u/data/models/captain/captain_models.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/captain/captain_home/riverpod/captain_tab_controller.dart';
import 'package:for_u/presentation/views/captain/captain_home/view/widgets/captain_order_card.dart';
import 'package:for_u/presentation/views/captain/order_details/view/screens/captain_order_details_view.dart';
import 'package:url_launcher/url_launcher.dart';

enum CaptainOrdersDataType {
  upcoming,
  inDelivery,
  completed;

  bool get isUpcoming => this == upcoming;
  bool get isInDelivery => this == inDelivery;
  bool get isCompleted => this == completed;

  String get queue => switch (this) {
    CaptainOrdersDataType.upcoming => CaptainHomeNotifier.upcomingQueue,
    CaptainOrdersDataType.inDelivery => CaptainHomeNotifier.inDeliveryQueue,
    CaptainOrdersDataType.completed => CaptainHomeNotifier.completedQueue,
  };
}

class CaptainOrdersData extends ConsumerStatefulWidget {
  final CaptainOrdersDataType type;

  const CaptainOrdersData({super.key, required this.type});

  @override
  ConsumerState<CaptainOrdersData> createState() => _CaptainOrdersDataState();
}

class _CaptainOrdersDataState extends ConsumerState<CaptainOrdersData>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(
      captainHomeController.select(
        (s) => switch (widget.type) {
          CaptainOrdersDataType.upcoming => s.upcomingData,
          CaptainOrdersDataType.inDelivery => s.inDeliveryData,
          CaptainOrdersDataType.completed => s.completedData,
        },
      ),
    );
    final notifier = ref.read(captainHomeController.notifier);
    final refreshController = switch (widget.type) {
      CaptainOrdersDataType.upcoming => notifier.upcomingRefreshController,
      CaptainOrdersDataType.inDelivery => notifier.inDeliveryRefreshController,
      CaptainOrdersDataType.completed => notifier.completedRefreshController,
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
            return CaptainOrderCard(
              status: _cardStatusFor(order),
              orderId: '#${order.orderNumber}',
              address: order.addressLine,
              customerName: order.customer?.name ?? '',
              onTapOpen: () => _openDetails(order),
              onTapCall: () => _callCustomer(order.customer?.phone),
            );
          },
        ),
      ),
    );
  }

  Future<void> _openDetails(CaptainOrder order) async {
    await context.pushNamed(
      Routes.captainOrderDetails,
      arguments: CaptainOrderDetailsArgs(orderId: order.id),
    );
    // The captain may have moved the order forward inside; reload the queues.
    if (mounted) ref.read(captainHomeController.notifier).loadInitial();
  }

  /// The phone is the only contact channel (no in-app chat in v1).
  Future<void> _callCustomer(String? phone) async {
    if (phone == null || phone.isEmpty) return;
    await launchUrl(Uri(scheme: 'tel', path: phone));
  }

  /// The card's own status enum drives its footer; received orders still
  /// show as upcoming work in the queue card.
  CaptainOrderStatus _cardStatusFor(CaptainOrder order) =>
      switch (order.uiStatus) {
        null => CaptainOrderStatus.upcoming,
        final status => switch (status.name) {
          'upcoming' || 'received' => CaptainOrderStatus.upcoming,
          'inDelivery' => CaptainOrderStatus.inDelivery,
          'delivered' => CaptainOrderStatus.delivered,
          _ => CaptainOrderStatus.cancelled,
        },
      };
}
