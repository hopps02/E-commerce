import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:for_u/app/enums/enums.dart';

part 'captain_models.freezed.dart';
part 'captain_models.g.dart';

/// Maps a backend order state onto the captain screen's five UI stages.
/// States a captain never sees (placed/preparing/cancelled-by-customer…)
/// map to null and are skipped rather than mis-rendered.
CaptainOrderStatus? captainStatusFromState(String state) => switch (state) {
  'captain_assigned' => CaptainOrderStatus.upcoming,
  'received_by_captain' => CaptainOrderStatus.received,
  'out_for_delivery' => CaptainOrderStatus.inDelivery,
  'delivered' => CaptainOrderStatus.delivered,
  'failed_delivery' => CaptainOrderStatus.cancelled,
  _ => null,
};

/// GET /captain/me data.
@freezed
abstract class CaptainProfile with _$CaptainProfile {
  const factory CaptainProfile({
    required int id,
    @JsonKey(name: 'merchant_id') required int merchantId,
    @JsonKey(name: 'branch_id') required int branchId,
    String? name,
    required String phone,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
  }) = _CaptainProfile;

  factory CaptainProfile.fromJson(Map<String, dynamic> json) =>
      _$CaptainProfileFromJson(json);
}

@freezed
abstract class CaptainOrderLine with _$CaptainOrderLine {
  const CaptainOrderLine._();

  const factory CaptainOrderLine({
    required int id,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    required int quantity,
    @JsonKey(name: 'unit_price_halalas') @Default(0) int unitPriceHalalas,
    @Default(false) bool removed,
  }) = _CaptainOrderLine;

  factory CaptainOrderLine.fromJson(Map<String, dynamic> json) =>
      _$CaptainOrderLineFromJson(json);

  String name(bool arabic) =>
      (arabic ? nameAr : nameEn) ?? nameAr ?? nameEn ?? '';
}

@freezed
abstract class CaptainOrderCustomer with _$CaptainOrderCustomer {
  const factory CaptainOrderCustomer({String? name, String? phone}) =
      _CaptainOrderCustomer;

  factory CaptainOrderCustomer.fromJson(Map<String, dynamic> json) =>
      _$CaptainOrderCustomerFromJson(json);
}

/// An order as the captain sees it (dropoff + COD cash to collect).
@freezed
abstract class CaptainOrder with _$CaptainOrder {
  const CaptainOrder._();

  const factory CaptainOrder({
    required int id,
    @JsonKey(name: 'order_number') required String orderNumber,
    required String state,
    CaptainOrderCustomer? customer,
    Map<String, dynamic>? dropoff,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'total_halalas') @Default(0) int totalHalalas,
    @JsonKey(name: 'cash_to_collect_halalas')
    @Default(0)
    int cashToCollectHalalas,
    @JsonKey(name: 'failure_reason') String? failureReason,
    List<CaptainOrderLine>? items,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _CaptainOrder;

  factory CaptainOrder.fromJson(Map<String, dynamic> json) =>
      _$CaptainOrderFromJson(json);

  CaptainOrderStatus? get uiStatus => captainStatusFromState(state);

  String get addressLine {
    final display = dropoff?['display_address'];
    return display is String ? display : '';
  }

  List<CaptainOrderLine> get activeItems =>
      (items ?? const []).where((item) => !item.removed).toList();
}
