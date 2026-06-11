import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/models/customer/customer_models.dart';

class OrderDetailsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final int orderId;
  final String orderNumber;

  /// 1 = preparing, 2 = out for delivery, 3 = delivered.
  final int step;
  final String address;
  final List<CustomerOrderItem> items;
  final CustomerOrderTotals totals;
  final bool isDelivered;

  /// Backend-owned eligibility (delivered, unrated, inside the rating window).
  final bool canRate;

  const OrderDetailsState({
    this.reqState = ReqState.loading,
    this.errorMessage = "",
    this.orderId = 0,
    this.orderNumber = '',
    this.step = 1,
    this.address = '',
    this.items = const [],
    this.totals = const CustomerOrderTotals(),
    this.isDelivered = false,
    this.canRate = false,
  });

  OrderDetailsState copyWith({
    ReqState? reqState,
    String? errorMessage,
    bool? canRate,
  }) {
    return OrderDetailsState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      orderId: orderId,
      orderNumber: orderNumber,
      step: step,
      address: address,
      items: items,
      totals: totals,
      isDelivered: isDelivered,
      canRate: canRate ?? this.canRate,
    );
  }

  @override
  List<Object?> get props => [
    reqState,
    errorMessage,
    orderId,
    orderNumber,
    step,
    address,
    items,
    totals,
    isDelivered,
    canRate,
  ];
}

class OrderDetailsNotifier extends Notifier<OrderDetailsState> {
  @override
  OrderDetailsState build() => const OrderDetailsState();

  Future<void> load(int orderId) async {
    state = const OrderDetailsState();
    final result = await DI().customerRepository.orderDetail(orderId);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      _applyOrder,
    );
  }

  /// All four axes are required by the backend; star widgets emit doubles
  /// but ratings travel as integers. Returns true when the rating stuck.
  Future<bool> rate({
    required double overall,
    required double captain,
    required double orderAccuracy,
    required double deliverySpeed,
    String? comment,
  }) async {
    DI().loadingService.show();
    final result = await DI().customerRepository.rateOrder(
      state.orderId,
      RateOrderBody(
        overallStars: overall.round().clamp(1, 5),
        captainStars: captain.round().clamp(1, 5),
        orderAccuracyStars: orderAccuracy.round().clamp(1, 5),
        deliverySpeedStars: deliverySpeed.round().clamp(1, 5),
        comment: (comment ?? '').trim().isEmpty ? null : comment!.trim(),
      ),
    );
    DI().loadingService.hide();

    return result.fold((failure) {
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
      return false;
    }, (_) {
      // One rating per order — retire the CTA without a refetch.
      state = state.copyWith(canRate: false);
      return true;
    });
  }

  void _applyOrder(CustomerOrder order) {
    state = OrderDetailsState(
      reqState: ReqState.success,
      orderId: order.id,
      orderNumber: order.orderNumber,
      step: order.timelineStep,
      address: order.addressLine,
      items: order.activeItems,
      totals: order.totals ?? const CustomerOrderTotals(),
      isDelivered: order.isDelivered,
      canRate: order.canRate,
    );
  }
}

final orderDetailsController =
    NotifierProvider.autoDispose<OrderDetailsNotifier, OrderDetailsState>(
      OrderDetailsNotifier.new,
    );
