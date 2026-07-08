import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/response/customer/customer_response.dart';
import 'package:for_u/domain/usecase/checkout_quote_usecase.dart';
import 'package:for_u/domain/usecase/create_order_usecase.dart';
import 'package:for_u/presentation/common/riverpod/location_controller.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/cart/riverpod/cart_controller.dart';

/// Identifies the exact (address, lines) a quote was priced for. Any change to
/// the selected address or to a line's id/quantity yields a different
/// fingerprint, which marks the current totals stale and forces a re-quote.
String checkoutFingerprint(int? addressId, List<CartLine> lines) =>
    '$addressId|${lines.map((l) => '${l.branchItemId}x${l.quantity}').join(',')}';

class CheckoutState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final String errorCode;
  final int? addressId;
  final String addressLine;
  final CheckoutTotals totals;

  /// The (address, lines) fingerprint [totals] were quoted against. Empty until
  /// the first successful quote.
  final String quotedFingerprint;

  /// True while a background re-quote is in flight after a cart/address edit —
  /// the summary bar shows the delivery fee + grand total as "updating" instead
  /// of a stale number, without tearing down the whole screen.
  final bool requoting;

  /// True while the order is being placed — drives the in-button spinner on
  /// the confirm CTA (no global overlay for this action).
  final bool placing;

  const CheckoutState({
    this.reqState = ReqState.loading,
    this.errorMessage = '',
    this.errorCode = '',
    this.addressId,
    this.addressLine = '',
    this.totals = const CheckoutTotals(),
    this.quotedFingerprint = '',
    this.requoting = false,
    this.placing = false,
  });

  /// Whether the current totals still match the given cart lines + selected
  /// address. A false result means the displayed delivery fee/total is stale.
  bool matchesCart(List<CartLine> lines) =>
      quotedFingerprint.isNotEmpty &&
      quotedFingerprint == checkoutFingerprint(addressId, lines);

  bool get requiresCartBranchResolution =>
      errorCode == 'cart_branch_mismatch' || errorCode == 'multi_branch_cart';

  CheckoutState copyWith({
    ReqState? reqState,
    String? errorMessage,
    String? errorCode,
    int? addressId,
    String? addressLine,
    CheckoutTotals? totals,
    String? quotedFingerprint,
    bool? requoting,
    bool? placing,
  }) {
    return CheckoutState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
      addressId: addressId ?? this.addressId,
      addressLine: addressLine ?? this.addressLine,
      totals: totals ?? this.totals,
      quotedFingerprint: quotedFingerprint ?? this.quotedFingerprint,
      requoting: requoting ?? this.requoting,
      placing: placing ?? this.placing,
    );
  }

  @override
  List<Object?> get props => [
    reqState,
    errorMessage,
    errorCode,
    addressId,
    addressLine,
    totals,
    quotedFingerprint,
    requoting,
    placing,
  ];
}

/// Validates the cart, resolves the default address and prices the order via
/// the backend quote. Used by both the cart screen (totals bar) and the
/// confirm screen (address + place order).
///
/// The backend is always authoritative for stock, pricing and delivery fee
/// (re-resolved at order creation). This controller's job is to make sure the
/// totals the customer SEES and approves are never stale: any cart edit or
/// address change invalidates the quote (via [checkoutFingerprint]) and
/// triggers a fresh one before the totals are trusted or the order is placed.
class CheckoutNotifier extends Notifier<CheckoutState> {
  /// One key per distinct (address, lines) request so a double tap dedupes
  /// server-side while an edited cart still places a fresh order.
  String? _idempotencyKey;
  String _keyFingerprint = '';

  /// Coalesces rapid cart edits into a single re-quote.
  Timer? _requoteDebounce;

  @override
  CheckoutState build() {
    // Re-price whenever the cart changes while a checkout screen is open.
    ref.listen<CartState>(cartController, (_, next) => _onCartChanged(next));
    ref.onDispose(() => _requoteDebounce?.cancel());
    return const CheckoutState();
  }

  Future<void> load() async {
    final cartState = ref.read(cartController);
    final cart = ref.read(cartController.notifier);
    if (cartState.isEmpty) {
      state = state.copyWith(reqState: ReqState.empty);
      return;
    }
    if (await DI().sessionService.isGuest) {
      _loadGuestPreview(cartState.lines);
      return;
    }

    state = const CheckoutState();

    final validation = await DI().validateCartUseCase.execute(
      ref.read(cartController).lines,
    );
    var reconciled = false;
    final validationFailed = validation.fold(
      (failure) {
        _setFailure(failure);
        return true;
      },
      (result) {
        reconciled = cart.applyValidation(result);
        return false;
      },
    );
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
    final activeAddress = ref.read(locationController).selectedAddress;
    final address = addresses.fold<DeliveryAddress?>(
      (failure) {
        _setFailure(failure);
        return null;
      },
      (list) {
        final activeId = activeAddress?.id;
        if (activeId != null) {
          final matched = list.where((a) => a.id == activeId).firstOrNull;
          if (matched != null) return matched;
        }
        return list.where((a) => a.isDefault).firstOrNull ?? list.firstOrNull;
      },
    );
    if (state.reqState.isError) return;
    if (address == null) {
      state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: Translation.error_address_required.tr,
      );
      return;
    }
    final resolved = address;
    await ref.read(locationController.notifier).setSelectedAddress(resolved);

    final lines = ref.read(cartController).lines;
    final quote = await DI().checkoutQuoteUseCase.execute(
      CheckoutQuoteParams(addressId: resolved.id, lines: lines),
    );
    quote.fold(
      _setFailure,
      (q) => state = state.copyWith(
        reqState: ReqState.success,
        errorMessage: '',
        errorCode: '',
        addressId: resolved.id,
        addressLine: resolved.displayAddress,
        totals: q.totals,
        quotedFingerprint: checkoutFingerprint(resolved.id, lines),
        requoting: false,
      ),
    );
  }

  /// Switches the order to another saved address and reprices through the
  /// backend quote (delivery fee can differ per zone).
  Future<void> selectAddress(DeliveryAddress address) async {
    await ref.read(locationController.notifier).setSelectedAddress(address);
    if (await DI().sessionService.isGuest) {
      _loadGuestPreview(ref.read(cartController).lines);
      return;
    }
    state = state.copyWith(reqState: ReqState.loading);
    final lines = ref.read(cartController).lines;
    final quote = await DI().checkoutQuoteUseCase.execute(
      CheckoutQuoteParams(addressId: address.id, lines: lines),
    );
    quote.fold(
      _setFailure,
      (q) => state = state.copyWith(
        reqState: ReqState.success,
        errorMessage: '',
        errorCode: '',
        addressId: address.id,
        addressLine: address.displayAddress,
        totals: q.totals,
        quotedFingerprint: checkoutFingerprint(address.id, lines),
        requoting: false,
      ),
    );
  }

  /// Called when a checkout screen opens. Loads the first quote, or re-prices
  /// if the cart changed since the last quote (e.g. edited then navigated here
  /// before the debounced re-quote fired).
  Future<void> ensureQuote() async {
    if (await DI().sessionService.isGuest) {
      await load();
      return;
    }
    if (!state.reqState.isSuccess) {
      await load();
      return;
    }
    if (!state.matchesCart(ref.read(cartController).lines)) {
      _requoteDebounce?.cancel();
      await _requote();
    }
  }

  void _onCartChanged(CartState cart) {
    // The first quote is owned by load(); only react to edits made after it.
    if (!state.reqState.isSuccess) return;
    if (state.addressId == null) {
      if (cart.isEmpty) {
        _requoteDebounce?.cancel();
        state = state.copyWith(
          reqState: ReqState.empty,
          errorMessage: '',
          errorCode: '',
          requoting: false,
        );
        return;
      }
      _loadGuestPreview(cart.lines);
      return;
    }

    if (cart.isEmpty) {
      _requoteDebounce?.cancel();
      state = state.copyWith(
        reqState: ReqState.empty,
        errorMessage: '',
        errorCode: '',
        requoting: false,
      );
      return;
    }

    if (state.matchesCart(cart.lines)) return;

    // Hide the now-stale delivery fee/total immediately, then re-price.
    state = state.copyWith(requoting: true);
    _requoteDebounce?.cancel();
    _requoteDebounce = Timer(const Duration(milliseconds: 400), _requote);
  }

  /// Re-prices the current cart against the selected address. No-op when the
  /// quote is already current or there is nothing to price.
  Future<void> _requote() async {
    final addressId = state.addressId;
    final lines = ref.read(cartController).lines;
    if (addressId == null || lines.isEmpty) {
      state = state.copyWith(requoting: false);
      return;
    }
    final fingerprint = checkoutFingerprint(addressId, lines);
    if (fingerprint == state.quotedFingerprint) {
      state = state.copyWith(requoting: false);
      return;
    }

    final quote = await DI().checkoutQuoteUseCase.execute(
      CheckoutQuoteParams(addressId: addressId, lines: lines),
    );
    quote.fold(
      (failure) {
        _setFailure(failure, requoting: false);
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
      },
      (q) => state = state.copyWith(
        reqState: ReqState.success,
        errorMessage: '',
        errorCode: '',
        totals: q.totals,
        quotedFingerprint: fingerprint,
        requoting: false,
      ),
    );
  }

  /// Retry from the cart's error state.
  Future<void> retry() async {
    await load();
  }

  /// Places the order — but only against a total the customer can currently see.
  /// Every confirm tap forces a FRESH server quote first:
  ///  - quote fails (coverage/branch/network) -> block; the error is shown;
  ///  - totals changed (or stock dropped) since they last saw it -> reveal the
  ///    new total, ask them to review, and place NOTHING on this tap;
  ///  - totals unchanged -> place. createOrder stays backend-authoritative.
  /// Returns the order on success; null means nothing was placed (handled).
  Future<CustomerOrder?> placeOrder({String? notes}) async {
    if (await DI().sessionService.isGuest) return null;
    final addressId = state.addressId;
    if (addressId == null || ref.read(cartController).isEmpty) return null;

    _requoteDebounce?.cancel();
    state = state.copyWith(placing: true);

    // Approval integrity: re-price live right before placing and compare the
    // SERVER totals against what the customer is looking at.
    final approved = state.totals;
    final fresh = await _quoteNow();
    if (fresh == null) {
      // Pricing failed (coverage/branch/merchant/network) — already surfaced.
      state = state.copyWith(placing: false);
      return null;
    }
    if (!fresh.allAvailable || fresh.totals != approved) {
      // The live total differs from the one shown (or an item went unavailable):
      // _quoteNow already put the fresh total in state; tell them to review and
      // place nothing this tap. The next tap re-checks against the new total.
      state = state.copyWith(placing: false);
      DI().snackBarHelper.showMessage(
        Translation.order_total_updated.tr,
        ErrorMessage.snackBar,
      );
      return null;
    }

    final lines = ref.read(cartController).lines;
    final result = await DI().createOrderUseCase.execute(
      CreateOrderParams(
        idempotencyKey: _keyFor(addressId, lines),
        addressId: addressId,
        lines: lines,
        notes: notes,
      ),
    );
    state = state.copyWith(placing: false);

    return result.fold(
      (failure) {
        if (_isCartBranchResolutionFailure(failure)) {
          _setFailure(failure, placing: false);
        }
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
        return null;
      },
      (order) {
        _idempotencyKey = null;
        _keyFingerprint = '';
        ref.read(cartController.notifier).clear();
        return order;
      },
    );
  }

  /// Forces a fresh server quote for the current cart + address (the confirm
  /// tap). Updates totals + fingerprint on success and returns the quote;
  /// returns null after surfacing a pricing failure.
  Future<CheckoutQuote?> _quoteNow() async {
    final addressId = state.addressId;
    final lines = ref.read(cartController).lines;
    if (addressId == null || lines.isEmpty) return null;

    final quote = await DI().checkoutQuoteUseCase.execute(
      CheckoutQuoteParams(addressId: addressId, lines: lines),
    );
    return quote.fold<CheckoutQuote?>(
      (failure) {
        // Mirror _requote: a failed confirm-time quote must not leave the old
        // total presented as a valid checkout — drop to error so the retry UI
        // (CartData) takes over instead of showing a stale price.
        _setFailure(failure, requoting: false);
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
        return null;
      },
      (q) {
        state = state.copyWith(
          reqState: ReqState.success,
          errorMessage: '',
          errorCode: '',
          totals: q.totals,
          quotedFingerprint: checkoutFingerprint(addressId, lines),
          requoting: false,
        );
        return q;
      },
    );
  }

  String _keyFor(int addressId, List<CartLine> lines) {
    final fingerprint = checkoutFingerprint(addressId, lines);
    if (_idempotencyKey == null || fingerprint != _keyFingerprint) {
      _idempotencyKey =
          'app-${DateTime.now().microsecondsSinceEpoch}-${identityHashCode(this)}';
      _keyFingerprint = fingerprint;
    }
    return _idempotencyKey!;
  }

  void _loadGuestPreview(List<CartLine> lines) {
    final selectedAddress = ref.read(locationController).selectedAddress;
    state = CheckoutState(
      reqState: ReqState.success,
      addressLine: selectedAddress?.displayAddress ?? '',
      quotedFingerprint: checkoutFingerprint(null, lines),
    );
  }

  bool _isCartBranchResolutionFailure(Failure failure) =>
      _errorCode(failure) == 'cart_branch_mismatch' ||
      _errorCode(failure) == 'multi_branch_cart';

  String _errorCode(Failure failure) =>
      failure is ServerError ? failure.code ?? '' : '';

  void _setFailure(Failure failure, {bool? placing, bool? requoting}) {
    state = state.copyWith(
      reqState: ReqState.error,
      errorMessage: failure.displayMessage,
      errorCode: _errorCode(failure),
      placing: placing,
      requoting: requoting,
    );
  }
}

final checkoutController =
    NotifierProvider.autoDispose<CheckoutNotifier, CheckoutState>(
      CheckoutNotifier.new,
    );
