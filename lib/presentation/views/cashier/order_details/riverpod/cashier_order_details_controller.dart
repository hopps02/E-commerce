import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/enums/enums.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/app/utils/failure_reason.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/domain/usecase/mark_item_prepared_usecase.dart';
import 'package:store/domain/usecase/mark_item_unavailable_usecase.dart';

class CashierOrderProduct extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int quantity;
  final int priceHalalas;
  final bool isPrepared;

  const CashierOrderProduct({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.priceHalalas,
    this.isPrepared = false,
  });

  CashierOrderProduct copyWith({bool? isPrepared}) {
    return CashierOrderProduct(
      id: id,
      name: name,
      imageUrl: imageUrl,
      quantity: quantity,
      priceHalalas: priceHalalas,
      isPrepared: isPrepared ?? this.isPrepared,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    quantity,
    priceHalalas,
    isPrepared,
  ];
}

class CashierOrderDetailsState extends Equatable {
  final ReqState reqState;
  final String msgError;
  final int orderId;
  final String orderNumber;
  final CashierOrderStatus status;
  final List<CashierOrderProduct> products;
  final String? captainName;
  final String? captainAvatarUrl;
  final int? captainId;
  final String? failureReason;

  /// Raw backend order state — distinguishes out_for_delivery (post-pickup)
  /// from captain_assigned for the change-captain handoff note.
  final String orderRawState;
  final String location;
  final DateTime orderTime;

  /// Backend-authoritative order total — never recomputed client-side.
  final int totalHalalas;

  const CashierOrderDetailsState({
    this.reqState = ReqState.loading,
    this.msgError = '',
    this.orderId = 0,
    this.orderNumber = '',
    this.status = CashierOrderStatus.preparing,
    this.products = const [],
    this.location = '',
    required this.orderTime,
    this.captainName,
    this.captainAvatarUrl,
    this.captainId,
    this.failureReason,
    this.orderRawState = '',
    this.totalHalalas = 0,
  });

  bool get allPrepared =>
      products.isNotEmpty && products.every((p) => p.isPrepared);

  int get productsCount => products.fold(0, (sum, p) => sum + p.quantity);

  CashierOrderDetailsState copyWith({
    ReqState? reqState,
    String? msgError,
    int? orderId,
    String? orderNumber,
    CashierOrderStatus? status,
    List<CashierOrderProduct>? products,
    String? captainName,
    String? captainAvatarUrl,
    int? captainId,
    String? failureReason,
    String? orderRawState,
    String? location,
    DateTime? orderTime,
    int? totalHalalas,
  }) {
    return CashierOrderDetailsState(
      reqState: reqState ?? this.reqState,
      msgError: msgError ?? this.msgError,
      orderId: orderId ?? this.orderId,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
      products: products ?? this.products,
      captainName: captainName ?? this.captainName,
      captainAvatarUrl: captainAvatarUrl ?? this.captainAvatarUrl,
      captainId: captainId ?? this.captainId,
      failureReason: failureReason ?? this.failureReason,
      orderRawState: orderRawState ?? this.orderRawState,
      location: location ?? this.location,
      orderTime: orderTime ?? this.orderTime,
      totalHalalas: totalHalalas ?? this.totalHalalas,
    );
  }

  @override
  List<Object?> get props => [
    reqState,
    msgError,
    orderId,
    orderNumber,
    status,
    products,
    captainName,
    captainAvatarUrl,
    captainId,
    failureReason,
    orderRawState,
    location,
    orderTime,
    totalHalalas,
  ];
}

class CashierOrderDetailsNotifier extends Notifier<CashierOrderDetailsState> {
  @override
  CashierOrderDetailsState build() {
    return CashierOrderDetailsState(orderTime: DateTime.now());
  }

  Future<void> load(int orderId) async {
    state = state.copyWith(reqState: ReqState.loading, orderId: orderId);
    final result = await DI().getCashierOrderDetailUseCase.execute(orderId);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        msgError: failure.displayMessage,
      ),
      _applyOrder,
    );
  }

  /// Optimistic check-off; the backend write follows and the row rolls back
  /// (with the failure shown) when it is rejected.
  Future<void> togglePrepared(int productId) async {
    if (!state.status.isProductsEditable) return;

    final before = state.products;
    final target = before.firstWhere((p) => p.id == productId);
    final prepared = !target.isPrepared;

    state = state.copyWith(
      products: [
        for (final p in before)
          if (p.id == productId) p.copyWith(isPrepared: prepared) else p,
      ],
    );

    final result = await DI().markItemPreparedUseCase.execute(
      MarkItemPreparedParams(
        orderId: state.orderId,
        itemId: productId,
        prepared: prepared,
      ),
    );
    result.fold((failure) {
      state = state.copyWith(products: before);
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
    }, (_) {});
  }

  /// Marks an item unavailable. The row is optimistically dropped, then the
  /// backend removes it, releases its stock, recalculates the totals and (when
  /// it was the last item) auto-rejects the order — notifying the customer in
  /// either case. The returned order carries the recomputed totals/state, so we
  /// apply it directly; a failure rolls the row back. Server-side removal is not
  /// reversible, so any UI undo must gate this call before it runs.
  Future<void> markUnavailable(int productId, {String? reason}) async {
    if (!state.status.isProductsEditable) return;

    final before = state.products;
    state = state.copyWith(
      products: before.where((p) => p.id != productId).toList(),
    );

    final result = await DI().markItemUnavailableUseCase.execute(
      MarkItemUnavailableParams(
        orderId: state.orderId,
        itemId: productId,
        reason: reason,
      ),
    );
    result.fold((failure) {
      state = state.copyWith(products: before);
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
    }, _applyOrder);
  }

  Future<void> confirmReadiness() async {
    if (!state.status.isPreparing || !state.allPrepared) return;

    DI().loadingService.show();
    final result = await DI().confirmReadyUseCase.execute(state.orderId);
    DI().loadingService.hide();

    result.fold(
      (failure) => DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      ),
      _applyOrder,
    );
  }

  /// Called by the assign sheet after the backend accepted the assignment.
  void applyAssigned(CashierOrder order) => _applyOrder(order);

  void _applyOrder(CashierOrder order) {
    final status = order.uiStatus;
    if (status == null) {
      // Unknown state from the backend; surface it instead of guessing.
      state = state.copyWith(reqState: ReqState.error, msgError: order.state);
      return;
    }

    final reason = status.isFailedDelivery
        ? failureReasonLabel(order.failureReason, note: order.failureNote)
        : null;

    state = CashierOrderDetailsState(
      reqState: ReqState.success,
      orderId: order.id,
      orderNumber: order.orderNumber,
      status: status,
      location: order.addressLine,
      orderTime: order.createdAt ?? DateTime.now(),
      captainName: order.captain?.name,
      captainAvatarUrl: null,
      captainId: order.captain?.id ?? order.captainId,
      failureReason: reason,
      orderRawState: order.state,
      totalHalalas: order.totals.totalHalalas,
      products: [
        for (final item in order.activeItems)
          CashierOrderProduct(
            id: item.id,
            name: item.name(_isArabic()),
            imageUrl: item.imageUrl ?? '',
            quantity: item.quantity,
            priceHalalas: item.unitPriceHalalas,
            isPrepared: item.prepared,
          ),
      ],
    );
  }

  bool _isArabic() =>
      (DI().storageService.language ?? const Locale('ar')).languageCode == 'ar';
}

final cashierOrderDetailsController =
    NotifierProvider.autoDispose<
      CashierOrderDetailsNotifier,
      CashierOrderDetailsState
    >(CashierOrderDetailsNotifier.new);
