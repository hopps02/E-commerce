import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/response/customer/customer_response.dart';
import 'package:for_u/domain/usecase/checkout_quote_usecase.dart';
import 'package:for_u/domain/usecase/coverage_check_usecase.dart';
import 'package:for_u/domain/usecase/create_address_usecase.dart';
import 'package:for_u/domain/usecase/create_order_usecase.dart';
import 'package:for_u/presentation/common/riverpod/location_controller.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/cart_controller.dart';

class CheckoutState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final int? addressId;
  final String addressLine;
  final CheckoutTotals totals;

  /// True while the order is being placed — drives the in-button spinner on
  /// the confirm CTA (no global overlay for this action).
  final bool placing;

  const CheckoutState({
    this.reqState = ReqState.loading,
    this.errorMessage = '',
    this.addressId,
    this.addressLine = '',
    this.totals = const CheckoutTotals(),
    this.placing = false,
  });

  CheckoutState copyWith({
    ReqState? reqState,
    String? errorMessage,
    int? addressId,
    String? addressLine,
    CheckoutTotals? totals,
    bool? placing,
  }) {
    return CheckoutState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      addressId: addressId ?? this.addressId,
      addressLine: addressLine ?? this.addressLine,
      totals: totals ?? this.totals,
      placing: placing ?? this.placing,
    );
  }

  @override
  List<Object?> get props => [
    reqState,
    errorMessage,
    addressId,
    addressLine,
    totals,
    placing,
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

    final validation = await DI().validateCartUseCase.execute(
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

    final addresses = await DI().getAddressesUseCase.execute(null);
    var address = addresses.fold<DeliveryAddress?>((failure) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      );
      return null;
    }, (list) => list.where((a) => a.isDefault).firstOrNull ?? list.firstOrNull);
    if (state.reqState.isError) return;
    address ??= await _addressFromPickedLocation();
    if (address == null) {
      // _addressFromPickedLocation already set the error state.
      return;
    }
    final resolved = address;

    final quote = await DI().checkoutQuoteUseCase.execute(
      CheckoutQuoteParams(
        addressId: resolved.id,
        lines: ref.read(cartController).lines,
      ),
    );
    quote.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (q) => state = state.copyWith(
        reqState: ReqState.success,
        addressId: resolved.id,
        addressLine: resolved.displayAddress,
        totals: q.totals,
      ),
    );
  }

  /// New customers have no saved address and no addresses screen exists yet,
  /// so the first order turns their picked location (the existing location
  /// feature) into a default address — after a real coverage check.
  /// Returns null after setting the error state.
  Future<DeliveryAddress?> _addressFromPickedLocation() async {
    final location = ref.read(locationController);
    final lat = location.latitude;
    final lng = location.longitude;
    if (lat == null || lng == null) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: Translation.error_address_required.tr,
      );
      return null;
    }

    final coverage = await DI().coverageCheckUseCase.execute(
      CoverageCheckParams(lat: lat, lng: lng),
    );
    final cityId = coverage.fold<int?>((failure) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      );
      return null;
    }, (c) => c.isServiceable ? c.cityId : null);
    if (state.reqState.isError) return null;
    if (cityId == null) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: Translation.error_outside_delivery_zone.tr,
      );
      return null;
    }

    final created = await DI().createAddressUseCase.execute(
      CreateAddressParams(
        cityId: cityId,
        displayAddress: location.locationCity ?? Translation.unknown_location.tr,
        lat: lat,
        lng: lng,
      ),
    );
    return created.fold((failure) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      );
      return null;
    }, (address) => address);
  }

  /// Switches the order to another saved address and reprices through the
  /// backend quote (delivery fee can differ per zone).
  Future<void> selectAddress(DeliveryAddress address) async {
    state = state.copyWith(reqState: ReqState.loading);
    final quote = await DI().checkoutQuoteUseCase.execute(
      CheckoutQuoteParams(
        addressId: address.id,
        lines: ref.read(cartController).lines,
      ),
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

  /// Retry from the cart's error state. When the dead end was a missing
  /// location, this first walks the existing permission/fetch flow
  /// (hard-capped — GPS has no natural deadline).
  Future<void> retry() async {
    final location = ref.read(locationController);
    if (location.latitude == null || location.longitude == null) {
      await ref
          .read(locationController.notifier)
          .handleLocationPermissionAndFetch()
          .timeout(const Duration(seconds: 12), onTimeout: () => false);
    }
    await load();
  }

  /// Places the order. Returns it on success; null means the failure was
  /// already surfaced to the user.
  Future<CustomerOrder?> placeOrder({String? notes}) async {
    final addressId = state.addressId;
    final lines = ref.read(cartController).lines;
    if (addressId == null || lines.isEmpty) return null;

    state = state.copyWith(placing: true);
    final result = await DI().createOrderUseCase.execute(
      CreateOrderParams(
        idempotencyKey: _keyFor(addressId, lines),
        addressId: addressId,
        lines: lines,
        notes: notes,
      ),
    );
    state = state.copyWith(placing: false);

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
