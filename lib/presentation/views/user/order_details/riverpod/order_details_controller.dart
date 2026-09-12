import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/app/utils/mixins/auto_refresh_mixin.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/request/customer/customer_request.dart';
import 'package:store/data/response/customer/customer_response.dart';
import 'package:store/domain/usecase/rate_order_usecase.dart';

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

  /// Raw backend state plus the failure detail, kept so the timeline can swap
  /// the «تم التوصيل» node for a «تعذّر التوصيل» node and surface the reason.
  final String orderState;
  final String stateLabel;
  final String whatsappUrl;
  final String? failureReason;
  final String? failureNote;

  /// Backend-owned eligibility (delivered, unrated, inside the rating window).
  final bool canRate;

  /// Set the moment a rating is accepted this session — drives the in-screen
  /// confirmation that replaces the CTA. Reset on every fresh load.
  final bool justRated;

  /// Overall stars just submitted (1–5), shown filled in the confirmation.
  final int ratedOverall;

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
    this.orderState = '',
    this.stateLabel = '',
    this.whatsappUrl = '',
    this.failureReason,
    this.failureNote,
    this.canRate = false,
    this.justRated = false,
    this.ratedOverall = 0,
  });

  OrderDetailsState copyWith({
    ReqState? reqState,
    String? errorMessage,
    bool? canRate,
    bool? justRated,
    int? ratedOverall,
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
      orderState: orderState,
      stateLabel: stateLabel,
      whatsappUrl: whatsappUrl,
      failureReason: failureReason,
      failureNote: failureNote,
      canRate: canRate ?? this.canRate,
      justRated: justRated ?? this.justRated,
      ratedOverall: ratedOverall ?? this.ratedOverall,
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
    orderState,
    stateLabel,
    whatsappUrl,
    failureReason,
    failureNote,
    canRate,
    justRated,
    ratedOverall,
  ];
}

class OrderDetailsNotifier extends Notifier<OrderDetailsState>
    with AutoRefreshMixin<OrderDetailsState> {
  /// How often an in-flight order re-checks its status with the server. The
  /// panel is where staff move an order along, so this is the only way the
  /// customer sees it happen without leaving the screen.
  static const _pollInterval = Duration(seconds: 15);

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

  /// Polls while the order can still change, and stops once it cannot — a
  /// delivered or cancelled order has nowhere left to go.
  void _syncPolling() {
    if (orderStateIsFinal(state.orderState)) {
      stopAutoRefresh();
      return;
    }
    startAutoRefresh(_pollInterval, silentRefresh);
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
      // One rating per order — retire the CTA without a refetch and surface the
      // in-screen confirmation with the stars just given.
      _writeGen++;
      state = state.copyWith(
        canRate: false,
        justRated: true,
        ratedOverall: overall.round().clamp(1, 5),
      );
      return true;
    });
  }

  void _applyOrder(CustomerOrder order) {
    _applyOrderState(order);
    _syncPolling();
  }

  void _applyOrderState(CustomerOrder order) {
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
      orderState: order.state,
      stateLabel: order.stateLabel ?? '',
      whatsappUrl: order.whatsappUrl ?? '',
      failureReason: order.failureReason,
      failureNote: order.failureNote,
      canRate: order.canRate,
    );
  }
}

final orderDetailsController =
    NotifierProvider.autoDispose<OrderDetailsNotifier, OrderDetailsState>(
      OrderDetailsNotifier.new,
    );
