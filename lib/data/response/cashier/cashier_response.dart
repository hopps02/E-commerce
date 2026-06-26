import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:for_u/app/enums/enums.dart';

part 'cashier_response.freezed.dart';
part 'cashier_response.g.dart';

/// Maps a backend order state onto the cashier screen's UI stages.
/// The exceptions queue surfaces terminal states that still need cashier
/// visibility, so each one gets a distinct status label.
CashierOrderStatus? cashierStatusFromState(String state) => switch (state) {
  'placed' || 'preparing' => CashierOrderStatus.preparing,
  'ready_for_pickup' => CashierOrderStatus.readyForCaptain,
  'captain_assigned' ||
  'received_by_captain' ||
  'out_for_delivery' => CashierOrderStatus.inDelivery,
  'delivered' => CashierOrderStatus.delivered,
  'failed_delivery' => CashierOrderStatus.failedDelivery,
  'cancelled' => CashierOrderStatus.cancelled,
  'rejected_by_merchant' => CashierOrderStatus.rejectedByMerchant,
  _ => null,
};

/// GET /cashier/me data.
@freezed
abstract class CashierProfile with _$CashierProfile {
  const factory CashierProfile({
    required int id,
    @JsonKey(name: 'merchant_id') required int merchantId,
    @JsonKey(name: 'branch_id') required int branchId,
    String? name,
    required String phone,
  }) = _CashierProfile;

  factory CashierProfile.fromJson(Map<String, dynamic> json) =>
      _$CashierProfileFromJson(json);
}

/// One order line as the cashier sees it (immutable snapshot pricing).
@freezed
abstract class CashierOrderItem with _$CashierOrderItem {
  const CashierOrderItem._();

  const factory CashierOrderItem({
    required int id,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'image_url') String? imageUrl,
    required int quantity,
    @JsonKey(name: 'unit_price_halalas') @Default(0) int unitPriceHalalas,
    @JsonKey(name: 'total_halalas') @Default(0) int totalHalalas,
    @Default(false) bool prepared,
    @JsonKey(name: 'prepared_at') String? preparedAt,
    @Default(false) bool removed,
    @JsonKey(name: 'removed_reason') String? removedReason,
  }) = _CashierOrderItem;

  factory CashierOrderItem.fromJson(Map<String, dynamic> json) =>
      _$CashierOrderItemFromJson(json);

  /// Display name following the app language.
  String name(bool arabic) =>
      (arabic ? nameAr : nameEn) ?? nameAr ?? nameEn ?? '';
}

@freezed
abstract class CashierOrderCaptain with _$CashierOrderCaptain {
  const factory CashierOrderCaptain({
    required int id,
    String? name,
    String? phone,
  }) = _CashierOrderCaptain;

  factory CashierOrderCaptain.fromJson(Map<String, dynamic> json) =>
      _$CashierOrderCaptainFromJson(json);
}

@freezed
abstract class CashierOrderTotals with _$CashierOrderTotals {
  const factory CashierOrderTotals({
    @JsonKey(name: 'subtotal_halalas') @Default(0) int subtotalHalalas,
    @JsonKey(name: 'delivery_fee_halalas') @Default(0) int deliveryFeeHalalas,
    @JsonKey(name: 'discount_halalas') @Default(0) int discountHalalas,
    @JsonKey(name: 'total_halalas') @Default(0) int totalHalalas,
  }) = _CashierOrderTotals;

  factory CashierOrderTotals.fromJson(Map<String, dynamic> json) =>
      _$CashierOrderTotalsFromJson(json);
}

/// An order in the cashier's queues / detail screen.
@freezed
abstract class CashierOrder with _$CashierOrder {
  const CashierOrder._();

  const factory CashierOrder({
    required int id,
    @JsonKey(name: 'order_number') required String orderNumber,
    required String state,
    @JsonKey(name: 'captain_id') int? captainId,
    CashierOrderCaptain? captain,
    @JsonKey(name: 'items_count') int? itemsCount,
    Map<String, dynamic>? customer,
    required CashierOrderTotals totals,
    List<CashierOrderItem>? items,
    @JsonKey(name: 'failure_reason') String? failureReason,
    @JsonKey(name: 'failure_note') String? failureNote,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _CashierOrder;

  factory CashierOrder.fromJson(Map<String, dynamic> json) =>
      _$CashierOrderFromJson(json);

  CashierOrderStatus? get uiStatus => cashierStatusFromState(state);

  /// The customer's address line from the immutable order snapshot.
  String get addressLine {
    final address = customer?['address'];
    if (address is Map) {
      final display = address['display_address'];
      if (display is String && display.isNotEmpty) return display;
    }
    return '';
  }

  /// Lines still part of the order (cashier-removed ones excluded).
  List<CashierOrderItem> get activeItems =>
      (items ?? const []).where((item) => !item.removed).toList();
}

/// GET /cashier/orders/{id}/available-captains entry.
@freezed
abstract class AvailableCaptain with _$AvailableCaptain {
  const factory AvailableCaptain({
    required int id,
    String? name,
    String? phone,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    @JsonKey(name: 'completed_today') @Default(0) int completedToday,
  }) = _AvailableCaptain;

  factory AvailableCaptain.fromJson(Map<String, dynamic> json) =>
      _$AvailableCaptainFromJson(json);
}
