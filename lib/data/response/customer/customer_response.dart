import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_response.freezed.dart';
part 'customer_response.g.dart';

/// Maps a backend order state onto the order card's 3-step timeline
/// (preparing -> out for delivery -> delivered). A failed delivery maps to the
/// out-for-delivery step, where the card paints that node red.
///
/// Several states share a node, so the timeline alone cannot show every move
/// staff make — `stateLabel` on the order is what names the exact status.
int orderTimelineStep(String state) => switch (state) {
  'placed' || 'preparing' || 'ready_for_pickup' => 1,
  'out_for_delivery' => 2,
  'delivered' => 3,
  'failed_delivery' => 2,
  _ => 1, // cancelled_* / rejected_by_merchant never left preparation
};

/// The backend only allows cancelling before preparation starts.
bool orderIsCancellable(String state) => state == 'placed';

/// Whether the order has reached a state it can never leave. Screens watching
/// a live status stop polling once this is true.
bool orderStateIsFinal(String state) => const {
  'delivered',
  'failed_delivery',
  'cancelled_by_customer',
  'cancelled_by_merchant',
  'rejected_by_merchant',
}.contains(state);

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
    /// The exact status in the customer's words. The timeline collapses
    /// several states into one node; this always names the current one.
    @JsonKey(name: 'state_label') String? stateLabel,

    /// A ready wa.me link the customer taps to send this order to the store.
    /// Null until a WhatsApp number is set in the panel.
    @JsonKey(name: 'whatsapp_url') String? whatsappUrl,
    @JsonKey(name: 'items_count') int? itemsCount,
    List<CustomerOrderItem>? items,
    Map<String, dynamic>? address,
    CustomerOrderTotals? totals,
    @JsonKey(name: 'total_halalas') int? totalHalalas,
    @JsonKey(name: 'failure_reason') String? failureReason,
    @JsonKey(name: 'failure_note') String? failureNote,
    @JsonKey(name: 'can_rate') @Default(false) bool canRate,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _CustomerOrder;

  factory CustomerOrder.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderFromJson(json);

  int get timelineStep => orderTimelineStep(state);

  bool get isCancellable => orderIsCancellable(state);

  bool get isDelivered => state == 'delivered';

  bool get isFailedDelivery => state == 'failed_delivery';

  /// List rows send `total_halalas` flat; the detail nests it under totals.
  int get displayTotalHalalas => totals?.totalHalalas ?? totalHalalas ?? 0;

  String get addressLine {
    final display = address?['display_address'];
    return display is String ? display : '';
  }

  List<CustomerOrderItem> get activeItems =>
      (items ?? const []).where((item) => !item.removed).toList();

  /// Items the cashier marked unavailable — surfaced separately so the customer
  /// sees what was dropped and refunded instead of the line silently vanishing.
  List<CustomerOrderItem> get removedItems =>
      (items ?? const []).where((item) => item.removed).toList();
}
