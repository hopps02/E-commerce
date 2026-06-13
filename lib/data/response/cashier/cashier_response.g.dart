// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashier_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CashierProfile _$CashierProfileFromJson(Map<String, dynamic> json) =>
    _CashierProfile(
      id: (json['id'] as num).toInt(),
      merchantId: (json['merchant_id'] as num).toInt(),
      branchId: (json['branch_id'] as num).toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$CashierProfileToJson(_CashierProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchant_id': instance.merchantId,
      'branch_id': instance.branchId,
      'name': instance.name,
      'phone': instance.phone,
    };

_CashierOrderItem _$CashierOrderItemFromJson(Map<String, dynamic> json) =>
    _CashierOrderItem(
      id: (json['id'] as num).toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      imageUrl: json['image_url'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      unitPriceHalalas: (json['unit_price_halalas'] as num?)?.toInt() ?? 0,
      totalHalalas: (json['total_halalas'] as num?)?.toInt() ?? 0,
      prepared: json['prepared'] as bool? ?? false,
      preparedAt: json['prepared_at'] as String?,
      removed: json['removed'] as bool? ?? false,
      removedReason: json['removed_reason'] as String?,
    );

Map<String, dynamic> _$CashierOrderItemToJson(_CashierOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'image_url': instance.imageUrl,
      'quantity': instance.quantity,
      'unit_price_halalas': instance.unitPriceHalalas,
      'total_halalas': instance.totalHalalas,
      'prepared': instance.prepared,
      'prepared_at': instance.preparedAt,
      'removed': instance.removed,
      'removed_reason': instance.removedReason,
    };

_CashierOrderCaptain _$CashierOrderCaptainFromJson(Map<String, dynamic> json) =>
    _CashierOrderCaptain(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$CashierOrderCaptainToJson(
  _CashierOrderCaptain instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
};

_CashierOrderTotals _$CashierOrderTotalsFromJson(Map<String, dynamic> json) =>
    _CashierOrderTotals(
      subtotalHalalas: (json['subtotal_halalas'] as num?)?.toInt() ?? 0,
      deliveryFeeHalalas: (json['delivery_fee_halalas'] as num?)?.toInt() ?? 0,
      discountHalalas: (json['discount_halalas'] as num?)?.toInt() ?? 0,
      totalHalalas: (json['total_halalas'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CashierOrderTotalsToJson(_CashierOrderTotals instance) =>
    <String, dynamic>{
      'subtotal_halalas': instance.subtotalHalalas,
      'delivery_fee_halalas': instance.deliveryFeeHalalas,
      'discount_halalas': instance.discountHalalas,
      'total_halalas': instance.totalHalalas,
    };

_CashierOrder _$CashierOrderFromJson(
  Map<String, dynamic> json,
) => _CashierOrder(
  id: (json['id'] as num).toInt(),
  orderNumber: json['order_number'] as String,
  state: json['state'] as String,
  captainId: (json['captain_id'] as num?)?.toInt(),
  captain: json['captain'] == null
      ? null
      : CashierOrderCaptain.fromJson(json['captain'] as Map<String, dynamic>),
  itemsCount: (json['items_count'] as num?)?.toInt(),
  customer: json['customer'] as Map<String, dynamic>?,
  totals: CashierOrderTotals.fromJson(json['totals'] as Map<String, dynamic>),
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => CashierOrderItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CashierOrderToJson(_CashierOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'state': instance.state,
      'captain_id': instance.captainId,
      'captain': instance.captain,
      'items_count': instance.itemsCount,
      'customer': instance.customer,
      'totals': instance.totals,
      'items': instance.items,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_AvailableCaptain _$AvailableCaptainFromJson(Map<String, dynamic> json) =>
    _AvailableCaptain(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      isAvailable: json['is_available'] as bool? ?? true,
      completedToday: (json['completed_today'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AvailableCaptainToJson(_AvailableCaptain instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'is_available': instance.isAvailable,
      'completed_today': instance.completedToday,
    };
