import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_models.freezed.dart';
part 'customer_models.g.dart';

/// Maps a backend order state onto the order card's 3-step timeline
/// (preparing -> out for delivery -> delivered). Terminal failures show the
/// step they stopped at — the card has no negative visual by design.
int orderTimelineStep(String state) => switch (state) {
  'placed' || 'preparing' || 'ready_for_pickup' => 1,
  'captain_assigned' || 'received_by_captain' || 'out_for_delivery' => 2,
  'delivered' => 3,
  'failed_delivery' => 2,
  _ => 1, // cancelled_* / rejected_by_merchant never left preparation
};

/// States the customer can still cancel from (mirrors the backend guard).
bool orderIsCancellable(String state) =>
    state == 'placed' || state == 'preparing';

/// GET /mobile/profile data.
@freezed
abstract class CustomerProfile with _$CustomerProfile {
  const factory CustomerProfile({
    required int id,
    @JsonKey(name: 'customer_number') required String customerNumber,
    String? name,
    required String phone,
    @JsonKey(name: 'preferred_locale') String? preferredLocale,
  }) = _CustomerProfile;

  factory CustomerProfile.fromJson(Map<String, dynamic> json) =>
      _$CustomerProfileFromJson(json);
}

@freezed
abstract class CustomerOrderItem with _$CustomerOrderItem {
  const CustomerOrderItem._();

  const factory CustomerOrderItem({
    required int id,
    @JsonKey(name: 'branch_item_id') int? branchItemId,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default(1) int quantity,
    @JsonKey(name: 'unit_price_halalas') @Default(0) int unitPriceHalalas,
    @JsonKey(name: 'total_halalas') @Default(0) int totalHalalas,
    @Default(false) bool removed,
  }) = _CustomerOrderItem;

  factory CustomerOrderItem.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderItemFromJson(json);

  String name(bool arabic) =>
      (arabic ? nameAr : nameEn) ?? nameAr ?? nameEn ?? '';
}

@freezed
abstract class CustomerOrderTotals with _$CustomerOrderTotals {
  const factory CustomerOrderTotals({
    @JsonKey(name: 'subtotal_halalas') @Default(0) int subtotalHalalas,
    @JsonKey(name: 'delivery_fee_halalas') @Default(0) int deliveryFeeHalalas,
    @JsonKey(name: 'discount_halalas') @Default(0) int discountHalalas,
    @JsonKey(name: 'vat_halalas') @Default(0) int vatHalalas,
    @JsonKey(name: 'total_halalas') @Default(0) int totalHalalas,
  }) = _CustomerOrderTotals;

  factory CustomerOrderTotals.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderTotalsFromJson(json);
}

/// An order as the customer sees it — list rows carry the items preview and
/// total; the detail adds the address snapshot and full totals block.
@freezed
abstract class CustomerOrder with _$CustomerOrder {
  const CustomerOrder._();

  const factory CustomerOrder({
    required int id,
    @JsonKey(name: 'order_number') required String orderNumber,
    required String state,
    @JsonKey(name: 'items_count') int? itemsCount,
    List<CustomerOrderItem>? items,
    Map<String, dynamic>? address,
    CustomerOrderTotals? totals,
    @JsonKey(name: 'total_halalas') int? totalHalalas,
    @JsonKey(name: 'failure_reason') String? failureReason,
    @JsonKey(name: 'can_rate') @Default(false) bool canRate,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _CustomerOrder;

  factory CustomerOrder.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderFromJson(json);

  int get timelineStep => orderTimelineStep(state);

  bool get isCancellable => orderIsCancellable(state);

  bool get isDelivered => state == 'delivered';

  /// List rows send `total_halalas` flat; the detail nests it under totals.
  int get displayTotalHalalas => totals?.totalHalalas ?? totalHalalas ?? 0;

  String get addressLine {
    final display = address?['display_address'];
    return display is String ? display : '';
  }

  List<CustomerOrderItem> get activeItems =>
      (items ?? const []).where((item) => !item.removed).toList();
}

/// POST /mobile/orders/{id}/rating body — all four axes are required.
@freezed
abstract class RateOrderBody with _$RateOrderBody {
  const factory RateOrderBody({
    @JsonKey(name: 'overall_stars') required int overallStars,
    @JsonKey(name: 'captain_stars') required int captainStars,
    @JsonKey(name: 'order_accuracy_stars') required int orderAccuracyStars,
    @JsonKey(name: 'delivery_speed_stars') required int deliverySpeedStars,
    String? comment,
  }) = _RateOrderBody;

  factory RateOrderBody.fromJson(Map<String, dynamic> json) =>
      _$RateOrderBodyFromJson(json);
}

/// POST /mobile/tickets body (support form).
@freezed
abstract class OpenTicketBody with _$OpenTicketBody {
  const factory OpenTicketBody({
    required String title,
    required String description,
    @JsonKey(name: 'order_id') int? orderId,
  }) = _OpenTicketBody;

  factory OpenTicketBody.fromJson(Map<String, dynamic> json) =>
      _$OpenTicketBodyFromJson(json);
}
