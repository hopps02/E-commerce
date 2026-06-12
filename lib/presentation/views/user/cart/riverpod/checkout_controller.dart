import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/models/customer/catalog_models.dart';
import 'package:for_u/data/models/customer/customer_models.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/cart_controller.dart';

class CheckoutState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final int? addressId;
  final String addressLine;
  final CheckoutTotals totals;

  const CheckoutState({
    this.reqState = ReqState.loading,
    this.errorMessage = '',
    this.addressId,
    this.addressLine = '',
    this.totals = const CheckoutTotals(),
  });

  CheckoutState copyWith({
    ReqState? reqState,
    String? errorMessage,
    int? addressId,
    String? addressLine,
    CheckoutTotals? totals,
  }) {
    return CheckoutState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      addressId: addressId ?? this.addressId,
      addressLine: addressLine ?? this.addressLine,
      totals: totals ?? this.totals,
    );
  }

  @override
  List<Object?> get props => [
    reqState,
    errorMessage,
    addressId,
    addressLine,
    totals,
  ];
}

/// Validates the cart, resolves the default address and prices the order via
/// the backend quote. Used by both the cart screen (totals bar) and the
/// confirm screen (address + place order).
class CheckoutNotifier extends Notifier<CheckoutState> {
  /// One key per distinct (address, lines) request so a double tap dedupes
  /// server-side while an edited cart still places a fresh order.
  String? _idempotencyKey;
  String _keyFingerprint = '';

  @override
  CheckoutState build() => const CheckoutState();

  Future<void> load() async {
    final cart = ref.read(cartController.notifier);
    if (ref.read(cartController).isEmpty) {
      state = state.copyWith(reqState: ReqState.empty);
      return;
    }

    state = const CheckoutState();

    final validation = await DI().customerRepository.validateCart(
      ref.read(cartController).lines,
    );
    var reconciled = false;
    final validationFailed = validation.fold((failure) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      );
      return true;
    }, (result) {
      reconciled = cart.applyValidation(result);
      return false;
    });
    if (validationFailed) return;
    if (reconciled) {
      DI().snackBarHelper.showMessage(
        Translation.cart_adjusted_to_stock.tr,
        ErrorMessage.snackBar,
      );
    }

    if (ref.read(cartController).isEmpty) {
      state = state.copyWith(reqState: ReqState.empty);
      return;
    }

    final addresses = await DI().customerRepository.addresses();
    final address = addresses.fold<DeliveryAddress?>((failure) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      );
      return null;
    }, (list) => list.where((a) => a.isDefault).firstOrNull ?? list.firstOrNull);
    if (state.reqState.isError) return;
    if (address == null) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: Translation.error_address_required.tr,
      );
      return;
    }

    final quote = await DI().customerRepository.checkoutQuote(
      addressId: address.id,
      lines: ref.read(cartController).lines,
    );
    quote.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (q) => state = state.copyWith(
        reqState: ReqState.success,
        addressId: address.id,
        addressLine: address.displayAddress,
        totals: q.totals,
      ),
    );
  }

  /// Places the order. Returns it on success; null means the failure was
  /// already surfaced to the user.
  Future<CustomerOrder?> placeOrder({String? notes}) async {
    final addressId = state.addressId;
    final lines = ref.read(cartController).lines;
    if (addressId == null || lines.isEmpty) return null;

    DI().loadingService.show();
    final result = await DI().customerRepository.createOrder(
      idempotencyKey: _keyFor(addressId, lines),
      addressId: addressId,
      lines: lines,
      notes: notes,
    );
    DI().loadingService.hide();

    return result.fold((failure) {
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
      return null;
    }, (order) {
      _idempotencyKey = null;
      _keyFingerprint = '';
      ref.read(cartController.notifier).clear();
      return order;
    });
  }

  String _keyFor(int addressId, List<CartLine> lines) {
    final fingerprint =
        '$addressId|${lines.map((l) => '${l.branchItemId}x${l.quantity}').join(',')}';
    if (_idempotencyKey == null || fingerprint != _keyFingerprint) {
      _idempotencyKey =
          'app-${DateTime.now().microsecondsSinceEpoch}-${identityHashCode(this)}';
      _keyFingerprint = fingerprint;
    }
    return _idempotencyKey!;
  }
}

final checkoutController =
    NotifierProvider.autoDispose<CheckoutNotifier, CheckoutState>(
      CheckoutNotifier.new,
    );
