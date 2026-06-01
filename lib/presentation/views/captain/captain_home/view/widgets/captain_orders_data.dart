import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/enums/enums.dart' as enums;
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/ui_kit/customized_smart_refresh.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/captain/captain_home/riverpod/captain_tab_controller.dart';
import 'package:for_u/presentation/views/captain/captain_home/view/widgets/captain_order_card.dart';
import 'package:for_u/presentation/views/captain/order_details/view/screens/captain_order_details_view.dart';

enum CaptainOrdersDataType {
  upcoming,
  inDelivery,
  completed;

  bool get isUpcoming => this == upcoming;
  bool get isInDelivery => this == inDelivery;
  bool get isCompleted => this == completed;
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
      captainHomeController.select((s) => switch (widget.type) {
            CaptainOrdersDataType.upcoming => s.upcomingData,
            CaptainOrdersDataType.inDelivery => s.inDeliveryData,
            CaptainOrdersDataType.completed => s.completedData,
          }),
    );
    final notifier = ref.read(captainHomeController.notifier);
    final refreshController = switch (widget.type) {
      CaptainOrdersDataType.upcoming => notifier.upcomingRefreshController,
      CaptainOrdersDataType.inDelivery => notifier.inDeliveryRefreshController,
      CaptainOrdersDataType.completed => notifier.completedRefreshController,
    };

    final itemCount = widget.type.isCompleted ? 12 : 8;

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
            final status = switch (widget.type) {
              CaptainOrdersDataType.upcoming => CaptainOrderStatus.upcoming,
              CaptainOrdersDataType.inDelivery =>
                CaptainOrderStatus.inDelivery,
              CaptainOrdersDataType.completed => index.isEven
                  ? CaptainOrderStatus.delivered
                  : CaptainOrderStatus.cancelled,
            };
            return CaptainOrderCard(
              status: status,
              orderId: '#${6757 + index}',
              address: 'شارع 14 , تبوك',
              customerName: 'فاطمة علي',
              onTapOpen: () => context.pushNamed(
                Routes.captainOrderDetails,
                arguments: CaptainOrderDetailsArgs(
                  initialStatus: _detailsStatusFor(widget.type, status),
                ),
              ),
              onTapCall: () {},
            );
          },
        ),
      ),
    );
  }

  /// Maps a home-tab + card-status combination to the order-details initial
  /// status. Upcoming-tab cards open in `upcoming`; in-delivery cards open in
  /// `inDelivery`; completed cards open either `delivered` or `cancelled`.
  enums.CaptainOrderStatus _detailsStatusFor(
    CaptainOrdersDataType tab,
    CaptainOrderStatus cardStatus,
  ) {
    switch (tab) {
      case CaptainOrdersDataType.upcoming:
        return enums.CaptainOrderStatus.upcoming;
      case CaptainOrdersDataType.inDelivery:
        return enums.CaptainOrderStatus.inDelivery;
      case CaptainOrdersDataType.completed:
        return cardStatus.isCancelled
            ? enums.CaptainOrderStatus.cancelled
            : enums.CaptainOrderStatus.delivered;
    }
  }
}
