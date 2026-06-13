// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captain_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CaptainProfile _$CaptainProfileFromJson(Map<String, dynamic> json) =>
    _CaptainProfile(
      id: (json['id'] as num).toInt(),
      merchantId: (json['merchant_id'] as num).toInt(),
      branchId: (json['branch_id'] as num).toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String,
      isAvailable: json['is_available'] as bool? ?? true,
    );

Map<String, dynamic> _$CaptainProfileToJson(_CaptainProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchant_id': instance.merchantId,
      'branch_id': instance.branchId,
      'name': instance.name,
      'phone': instance.phone,
      'is_available': instance.isAvailable,
    };

_CaptainOrderLine _$CaptainOrderLineFromJson(Map<String, dynamic> json) =>
    _CaptainOrderLine(
      id: (json['id'] as num).toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      unitPriceHalalas: (json['unit_price_halalas'] as num?)?.toInt() ?? 0,
      removed: json['removed'] as bool? ?? false,
    );

Map<String, dynamic> _$CaptainOrderLineToJson(_CaptainOrderLine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'quantity': instance.quantity,
      'unit_price_halalas': instance.unitPriceHalalas,
      'removed': instance.removed,
    };

_CaptainOrderCustomer _$CaptainOrderCustomerFromJson(
  Map<String, dynamic> json,
) => _CaptainOrderCustomer(
  name: json['name'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$CaptainOrderCustomerToJson(
  _CaptainOrderCustomer instance,
) => <String, dynamic>{'name': instance.name, 'phone': instance.phone};

_CaptainOrder _$CaptainOrderFromJson(
  Map<String, dynamic> json,
) => _CaptainOrder(
  id: (json['id'] as num).toInt(),
  orderNumber: json['order_number'] as String,
  state: json['state'] as String,
  customer: json['customer'] == null
      ? null
      : CaptainOrderCustomer.fromJson(json['customer'] as Map<String, dynamic>),
  dropoff: json['dropoff'] as Map<String, dynamic>?,
  paymentMethod: json['payment_method'] as String?,
  totalHalalas: (json['total_halalas'] as num?)?.toInt() ?? 0,
  cashToCollectHalalas: (json['cash_to_collect_halalas'] as num?)?.toInt() ?? 0,
  failureReason: json['failure_reason'] as String?,
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => CaptainOrderLine.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CaptainOrderToJson(_CaptainOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'state': instance.state,
      'customer': instance.customer,
      'dropoff': instance.dropoff,
      'payment_method': instance.paymentMethod,
      'total_halalas': instance.totalHalalas,
      'cash_to_collect_halalas': instance.cashToCollectHalalas,
      'failure_reason': instance.failureReason,
      'items': instance.items,
      'created_at': instance.createdAt?.toIso8601String(),
    };
