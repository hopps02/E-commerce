import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/request/customer/customer_request.dart';
import 'package:for_u/data/response/customer/customer_response.dart';
import 'package:for_u/domain/usecase/rate_order_usecase.dart';

class OrderDetailsState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final int orderId;
  final String orderNumber;

  /// 1 = preparing, 2 = out for delivery, 3 = delivered.
  final int step;
  final String address;
  final List<CustomerOrderItem> items;
  final List<CustomerOrderItem> removedItems;
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
    this.removedItems = const [],
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
      removedItems: removedItems,
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
    removedItems,
    totals,
    isDelivered,
    canRate,
  ];
}

class OrderDetailsNotifier extends Notifier<OrderDetailsState> {
  /// Bumped on every authoritative write (load/rate) so an overlapping
  /// pull-to-refresh can tell it raced and drop its now-stale result.
  int _writeGen = 0;
  bool _refreshing = false;

  @override
  OrderDetailsState build() => const OrderDetailsState();

  Future<void> load(int orderId) async {
    state = const OrderDetailsState();
    final result = await DI().getCustomerOrderDetailUseCase.execute(orderId);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (order) {
        _writeGen++;
        _applyOrder(order);
      },
    );
  }

  /// Pull-to-refresh: re-fetches the order in place (keeps the content on
  /// screen, no full-page loader) so a changed status surfaces immediately.
  Future<void> silentRefresh() async {
    final id = state.orderId;
    if (id == 0 || _refreshing) return;
    _refreshing = true;
    final gen = _writeGen;
    final result = await DI().getCustomerOrderDetailUseCase.execute(id);
    _refreshing = false;
    // A load or a rating landed while we refreshed — its result wins.
    if (_writeGen != gen || state.orderId != id) return;
    result.fold((_) {}, _applyOrder);
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
    final result = await DI().rateOrderUseCase.execute(
      RateOrderParams(
        id: state.orderId,
        body: RateOrderBody(
          overallStars: overall.round().clamp(1, 5),
          captainStars: captain.round().clamp(1, 5),
          orderAccuracyStars: orderAccuracy.round().clamp(1, 5),
          deliverySpeedStars: deliverySpeed.round().clamp(1, 5),
          comment: (comment ?? '').trim().isEmpty ? null : comment!.trim(),
        ),
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
      _writeGen++;
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
      removedItems: order.removedItems,
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
