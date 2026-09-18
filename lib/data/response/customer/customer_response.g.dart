// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomerProfile _$CustomerProfileFromJson(Map<String, dynamic> json) =>
    _CustomerProfile(
      id: (json['id'] as num).toInt(),
      customerNumber: json['customer_number'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String,
      preferredLocale: json['preferred_locale'] as String?,
    );

Map<String, dynamic> _$CustomerProfileToJson(_CustomerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_number': instance.customerNumber,
      'name': instance.name,
      'phone': instance.phone,
      'preferred_locale': instance.preferredLocale,
    };

_CustomerOrderItem _$CustomerOrderItemFromJson(Map<String, dynamic> json) =>
    _CustomerOrderItem(
      id: (json['id'] as num).toInt(),
      branchItemId: (json['branch_item_id'] as num?)?.toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      imageUrl: json['image_url'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 1,
      unitLabel: json['unit_label'] as String?,
      unitPriceHalalas: (json['unit_price_halalas'] as num?)?.toInt() ?? 0,
      totalHalalas: (json['total_halalas'] as num?)?.toInt() ?? 0,
      removed: json['removed'] as bool? ?? false,
    );

Map<String, dynamic> _$CustomerOrderItemToJson(_CustomerOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_item_id': instance.branchItemId,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'image_url': instance.imageUrl,
      'quantity': instance.quantity,
      'unit_label': instance.unitLabel,
      'unit_price_halalas': instance.unitPriceHalalas,
      'total_halalas': instance.totalHalalas,
      'removed': instance.removed,
    };

_CustomerOrderTotals _$CustomerOrderTotalsFromJson(Map<String, dynamic> json) =>
    _CustomerOrderTotals(
      subtotalHalalas: (json['subtotal_halalas'] as num?)?.toInt() ?? 0,
      deliveryFeeHalalas: (json['delivery_fee_halalas'] as num?)?.toInt() ?? 0,
      discountHalalas: (json['discount_halalas'] as num?)?.toInt() ?? 0,
      vatHalalas: (json['vat_halalas'] as num?)?.toInt() ?? 0,
      totalHalalas: (json['total_halalas'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CustomerOrderTotalsToJson(
  _CustomerOrderTotals instance,
) => <String, dynamic>{
  'subtotal_halalas': instance.subtotalHalalas,
  'delivery_fee_halalas': instance.deliveryFeeHalalas,
  'discount_halalas': instance.discountHalalas,
  'vat_halalas': instance.vatHalalas,
  'total_halalas': instance.totalHalalas,
};

_CustomerOrder _$CustomerOrderFromJson(Map<String, dynamic> json) =>
    _CustomerOrder(
      id: (json['id'] as num).toInt(),
      orderNumber: json['order_number'] as String,
      state: json['state'] as String,
      stateLabel: json['state_label'] as String?,
      whatsappUrl: json['whatsapp_url'] as String?,
      itemsCount: (json['items_count'] as num?)?.toInt(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CustomerOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] as Map<String, dynamic>?,
      totals: json['totals'] == null
          ? null
          : CustomerOrderTotals.fromJson(
              json['totals'] as Map<String, dynamic>,
            ),
      totalHalalas: (json['total_halalas'] as num?)?.toInt(),
      failureReason: json['failure_reason'] as String?,
      failureNote: json['failure_note'] as String?,
      canRate: json['can_rate'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CustomerOrderToJson(_CustomerOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'state': instance.state,
      'state_label': instance.stateLabel,
      'whatsapp_url': instance.whatsappUrl,
      'items_count': instance.itemsCount,
      'items': instance.items,
      'address': instance.address,
      'totals': instance.totals,
      'total_halalas': instance.totalHalalas,
      'failure_reason': instance.failureReason,
      'failure_note': instance.failureNote,
      'can_rate': instance.canRate,
      'created_at': instance.createdAt?.toIso8601String(),
    };
