import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/utils/state_render.dart';

// dart format off

class CaptainOrderItem extends Equatable {
  final String name;
  final int quantity;
  final double price;

  const CaptainOrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [name, quantity, price];
}

class CaptainOrderDetailsState extends Equatable {
  final ReqState reqState;
  final String msgError;
  final CaptainOrderStatus status;
  final String orderId;
  final String customerName;
  final String address;
  final List<CaptainOrderItem> items;
  final double totalAmount;
  /// Populated when status == cancelled, shown in the bottom box.
  final String? cancellationReason;

  const CaptainOrderDetailsState({
    this.reqState = ReqState.success,
    this.msgError = '',
    required this.status,
    required this.orderId,
    required this.customerName,
    required this.address,
    required this.items,
    required this.totalAmount,
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
      customerName: customerName,
      address: address,
      items: items,
      totalAmount: totalAmount,
      cancellationReason: cancellationReason ?? this.cancellationReason,
    );
  }

  @override
  List<Object?> get props => [
        reqState,
        msgError,
        status,
        orderId,
        customerName,
        address,
        items,
        totalAmount,
        cancellationReason,
      ];
}

class CaptainOrderDetailsNotifier
    extends Notifier<CaptainOrderDetailsState> {
  @override
  CaptainOrderDetailsState build() => _stateFor(CaptainOrderStatus.upcoming);

  void seed(CaptainOrderStatus initialStatus) {
    state = _stateFor(initialStatus);
  }

  void acceptOrder() {
    if (!state.status.isUpcoming) return;
    state = state.copyWith(status: CaptainOrderStatus.received);
  }

  void startDelivery() {
    if (!state.status.isReceived) return;
    state = state.copyWith(status: CaptainOrderStatus.inDelivery);
  }

  void markDelivered() {
    state = state.copyWith(status: CaptainOrderStatus.delivered);
  }

  void markCancelled(String reason) {
    state = state.copyWith(
      status: CaptainOrderStatus.cancelled,
      cancellationReason: reason,
    );
  }

  /// Hook for a future retry from FastStateRender when the order is fetched
  /// from the API. Today the data is hardcoded so this just resets the state.
  void retry() {
    state = state.copyWith(reqState: ReqState.success, msgError: '');
  }
}

final captainOrderDetailsController = NotifierProvider.autoDispose<
    CaptainOrderDetailsNotifier, CaptainOrderDetailsState>(
  CaptainOrderDetailsNotifier.new,
);

CaptainOrderDetailsState _stateFor(CaptainOrderStatus status) {
  return CaptainOrderDetailsState(
    status: status,
    orderId: '6757',
    customerName: 'فاطمة علي',
    address: 'شارع 14 , تبوك',
    items: const [
      CaptainOrderItem(
        name: 'جزر أصفر (Hills Farm) · جزر شانتينيه',
        quantity: 1,
        price: 12,
      ),
      CaptainOrderItem(
        name: 'جزر أصفر (Hills Farm) · جزر شانتينيه',
        quantity: 1,
        price: 12,
      ),
      CaptainOrderItem(
        name: 'جزر أصفر (Hills Farm) · جزر شانتينيه',
        quantity: 1,
        price: 12,
      ),
      CaptainOrderItem(
        name: 'جزر أصفر (Hills Farm) · جزر شانتينيه',
        quantity: 1,
        price: 12,
      ),
      CaptainOrderItem(
        name: 'جزر أصفر (Hills Farm) · جزر شانتينيه',
        quantity: 1,
        price: 12,
      ),
    ],
    totalAmount: 12,
    cancellationReason: status == CaptainOrderStatus.cancelled
        ? 'العميل لا يجيب ع الهاتف....'
        : null,
  );
}
