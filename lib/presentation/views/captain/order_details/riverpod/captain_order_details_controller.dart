import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/failure_reason.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/response/captain/captain_response.dart';
import 'package:for_u/domain/usecase/mark_delivered_usecase.dart';
import 'package:for_u/domain/usecase/mark_failed_usecase.dart';

// dart format off

class CaptainOrderItem extends Equatable {
  final String name;
  final int quantity;
  final int priceHalalas;

  const CaptainOrderItem({
    required this.name,
    required this.quantity,
    required this.priceHalalas,
  });

  @override
  List<Object?> get props => [name, quantity, priceHalalas];
}

class CaptainOrderDetailsState extends Equatable {
  final ReqState reqState;
  final String msgError;
  final CaptainOrderStatus status;
  final int orderId;
  final String orderNumber;
  final String customerName;
  final String customerPhone;
  final String address;
  final List<CaptainOrderItem> items;
  /// Backend-authoritative order total — never recomputed client-side.
  final int totalHalalas;
  /// Populated for terminal delivery failures/cancellations when provided.
  final String? cancellationReason;

  const CaptainOrderDetailsState({
    this.reqState = ReqState.loading,
    this.msgError = '',
    this.status = CaptainOrderStatus.upcoming,
    this.orderId = 0,
    this.orderNumber = '',
    this.customerName = '',
    this.customerPhone = '',
    this.address = '',
    this.items = const [],
    this.totalHalalas = 0,
    this.cancellationReason,
  });

  int get itemsCount => items.length;

  CaptainOrderDetailsState copyWith({
    ReqState? reqState,
    String? msgError,
    CaptainOrderStatus? status,
    String? cancellationReason,
  }) {
    return CaptainOrderDetailsState(
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
      status: status ?? this.status,
      orderId: orderId,
      orderNumber: orderNumber,
      customerName: customerName,
      customerPhone: customerPhone,
      address: address,
      items: items,
      totalHalalas: totalHalalas,
      cancellationReason: cancellationReason ?? this.cancellationReason,
    );
  }

  @override
  List<Object?> get props => [
        reqState,
        msgError,
        status,
        orderId,
        orderNumber,
        customerName,
        customerPhone,
        address,
        items,
        totalHalalas,
        cancellationReason,
      ];
}

// dart format on

class CaptainOrderDetailsNotifier extends Notifier<CaptainOrderDetailsState> {
  @override
  CaptainOrderDetailsState build() => const CaptainOrderDetailsState();

  Future<void> load(int orderId) async {
    state = const CaptainOrderDetailsState();
    final result = await DI().getCaptainOrderDetailUseCase.execute(orderId);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        msgError: failure.displayMessage,
      ),
      _applyOrder,
    );
  }

  /// Acknowledge receiving the goods (a captain cannot decline).
  Future<bool> acceptOrder() async {
    if (!state.status.isUpcoming) return false;
    return _transition(() => DI().acceptOrderUseCase.execute(state.orderId));
  }

  Future<bool> startDelivery() async {
    if (!state.status.isReceived) return false;
    return _transition(
      () => DI().startDeliveryUseCase.execute(state.orderId),
    );
  }

  Future<bool> markDelivered() async {
    if (!state.status.isInDelivery) return false;
    return _transition(
      () => DI().markDeliveredUseCase.execute(
        MarkDeliveredParams(orderId: state.orderId),
      ),
    );
  }

  /// [reason] is the backend enum value; the note is required for `other`.
  Future<bool> markFailed(String reason, String? note) async {
    return _transition(
      () => DI().markFailedUseCase.execute(
        MarkFailedParams(orderId: state.orderId, reason: reason, note: note),
      ),
    );
  }

  Future<bool> _transition(Future<dynamic> Function() call) async {
    DI().loadingService.show();
    final result = await call();
    DI().loadingService.hide();

    return result.fold(
      (failure) {
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
        return false;
      },
      (order) {
        _applyOrder(order as CaptainOrder);
        return true;
      },
    );
  }

  void _applyOrder(CaptainOrder order) {
    final status = order.uiStatus;
    if (status == null) {
      // The order left the captain's queues meanwhile.
      state = state.copyWith(reqState: ReqState.error, msgError: order.state);
      return;
    }

    final arabic = _isArabic();
    state = CaptainOrderDetailsState(
      reqState: ReqState.success,
      status: status,
      orderId: order.id,
      orderNumber: order.orderNumber,
      customerName: order.customer?.name ?? '',
      customerPhone: order.customer?.phone ?? '',
      address: order.addressLine,
      totalHalalas: order.totalHalalas,
      cancellationReason: failureReasonLabel(order.failureReason),
      items: [
        for (final item in order.activeItems)
          CaptainOrderItem(
            name: item.name(arabic),
            quantity: item.quantity,
            priceHalalas: item.unitPriceHalalas,
          ),
      ],
    );
  }

  bool _isArabic() =>
      (DI().storageService.language ?? const Locale('ar')).languageCode == 'ar';
}

final captainOrderDetailsController =
    NotifierProvider.autoDispose<
      CaptainOrderDetailsNotifier,
      CaptainOrderDetailsState
    >(CaptainOrderDetailsNotifier.new);
