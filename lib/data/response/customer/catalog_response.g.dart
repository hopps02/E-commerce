// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BranchProduct _$BranchProductFromJson(Map<String, dynamic> json) =>
    _BranchProduct(
      id: (json['id'] as num).toInt(),
      branchId: (json['branch_id'] as num).toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      imageUrl: json['image_url'] as String?,
      priceHalalas: (json['price_halalas'] as num?)?.toInt() ?? 0,
      discountHalalas: (json['discount_halalas'] as num?)?.toInt() ?? 0,
      available: (json['available'] as num?)?.toDouble() ?? 0,
      stockStatus: json['stock_status'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      descriptionAr: json['description_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      brand: json['brand'] as String?,
      unit: json['unit'] as String? ?? 'piece',
      unitLabel: json['unit_label'] as String?,
      quantityStep: (json['quantity_step'] as num?)?.toDouble() ?? 1,
      attributes:
          (json['attributes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$BranchProductToJson(_BranchProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_id': instance.branchId,
      'category_id': instance.categoryId,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'image_url': instance.imageUrl,
      'price_halalas': instance.priceHalalas,
      'discount_halalas': instance.discountHalalas,
      'available': instance.available,
      'stock_status': instance.stockStatus,
      'is_favorite': instance.isFavorite,
      'description_ar': instance.descriptionAr,
      'description_en': instance.descriptionEn,
      'brand': instance.brand,
      'unit': instance.unit,
      'unit_label': instance.unitLabel,
      'quantity_step': instance.quantityStep,
      'attributes': instance.attributes,
      'images': instance.images,
    };

_HomeBanner _$HomeBannerFromJson(Map<String, dynamic> json) => _HomeBanner(
  id: (json['id'] as num).toInt(),
  placement: json['placement'] as String? ?? 'home_hero',
  titleAr: json['title_ar'] as String?,
  titleEn: json['title_en'] as String?,
  subtitleAr: json['subtitle_ar'] as String?,
  subtitleEn: json['subtitle_en'] as String?,
  badgeAr: json['badge_ar'] as String?,
  badgeEn: json['badge_en'] as String?,
  ctaAr: json['cta_ar'] as String?,
  ctaEn: json['cta_en'] as String?,
  imageUrl: json['image_url'] as String?,
  target: json['target'] == null
      ? null
      : BannerTarget.fromJson(json['target'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeBannerToJson(_HomeBanner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placement': instance.placement,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'subtitle_ar': instance.subtitleAr,
      'subtitle_en': instance.subtitleEn,
      'badge_ar': instance.badgeAr,
      'badge_en': instance.badgeEn,
      'cta_ar': instance.ctaAr,
      'cta_en': instance.ctaEn,
      'image_url': instance.imageUrl,
      'target': instance.target,
    };

_BannerTarget _$BannerTargetFromJson(Map<String, dynamic> json) =>
    _BannerTarget(
      type: json['type'] as String? ?? 'none',
      categoryId: (json['category_id'] as num?)?.toInt(),
      branchItemId: (json['branch_item_id'] as num?)?.toInt(),
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => BranchProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BranchProduct>[],
    );

Map<String, dynamic> _$BannerTargetToJson(_BannerTarget instance) =>
    <String, dynamic>{
      'type': instance.type,
      'category_id': instance.categoryId,
      'branch_item_id': instance.branchItemId,
      'products': instance.products,
    };

_ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    _ProductCategory(
      id: (json['id'] as num).toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$ProductCategoryToJson(_ProductCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'image_url': instance.imageUrl,
    };

_DeliveryAddress _$DeliveryAddressFromJson(Map<String, dynamic> json) =>
    _DeliveryAddress(
      id: (json['id'] as num).toInt(),
      label: json['label'] as String?,
      labelText: json['label_text'] as String?,
      displayAddress: json['display_address'] as String? ?? '',
      street: json['street'] as String?,
      buildingNumber: json['building_number'] as String?,
      floor: json['floor'] as String?,
      apartment: json['apartment'] as String?,
      landmark: json['landmark'] as String?,
      deliveryInstructions: json['delivery_instructions'] as String?,
      isDefault: json['is_default'] as bool? ?? false,
    );

Map<String, dynamic> _$DeliveryAddressToJson(_DeliveryAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'label_text': instance.labelText,
      'display_address': instance.displayAddress,
      'street': instance.street,
      'building_number': instance.buildingNumber,
      'floor': instance.floor,
      'apartment': instance.apartment,
      'landmark': instance.landmark,
      'delivery_instructions': instance.deliveryInstructions,
      'is_default': instance.isDefault,
    };

_CartLine _$CartLineFromJson(Map<String, dynamic> json) => _CartLine(
  branchItemId: (json['branch_item_id'] as num).toInt(),
  quantity: (json['quantity'] as num).toDouble(),
);

Map<String, dynamic> _$CartLineToJson(_CartLine instance) => <String, dynamic>{
  'branch_item_id': instance.branchItemId,
  'quantity': instance.quantity,
};

_CartValidationLine _$CartValidationLineFromJson(Map<String, dynamic> json) =>
    _CartValidationLine(
      branchItemId: (json['branch_item_id'] as num).toInt(),
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0,
      available: json['available'] as bool? ?? false,
      reason: json['reason'] as String?,
      unitPriceHalalas: (json['unit_price_halalas'] as num?)?.toInt(),
      discountHalalas: (json['discount_halalas'] as num?)?.toInt(),
      availableQuantity: (json['available_quantity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartValidationLineToJson(_CartValidationLine instance) =>
    <String, dynamic>{
      'branch_item_id': instance.branchItemId,
      'quantity': instance.quantity,
      'available': instance.available,
      'reason': instance.reason,
      'unit_price_halalas': instance.unitPriceHalalas,
      'discount_halalas': instance.discountHalalas,
      'available_quantity': instance.availableQuantity,
    };

_CartValidationResult _$CartValidationResultFromJson(
  Map<String, dynamic> json,
) => _CartValidationResult(
  branchId: (json['branch_id'] as num?)?.toInt(),
  allAvailable: json['all_available'] as bool? ?? false,
  lines:
      (json['lines'] as List<dynamic>?)
          ?.map((e) => CartValidationLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CartValidationLine>[],
);

Map<String, dynamic> _$CartValidationResultToJson(
  _CartValidationResult instance,
) => <String, dynamic>{
  'branch_id': instance.branchId,
  'all_available': instance.allAvailable,
  'lines': instance.lines,
};

_CheckoutTotals _$CheckoutTotalsFromJson(Map<String, dynamic> json) =>
    _CheckoutTotals(
      subtotalHalalas: (json['subtotal_halalas'] as num?)?.toInt() ?? 0,
      deliveryFeeHalalas: (json['delivery_fee_halalas'] as num?)?.toInt() ?? 0,
      discountHalalas: (json['discount_halalas'] as num?)?.toInt() ?? 0,
      vatHalalas: (json['vat_halalas'] as num?)?.toInt() ?? 0,
      totalHalalas: (json['total_halalas'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CheckoutTotalsToJson(_CheckoutTotals instance) =>
    <String, dynamic>{
      'subtotal_halalas': instance.subtotalHalalas,
      'delivery_fee_halalas': instance.deliveryFeeHalalas,
      'discount_halalas': instance.discountHalalas,
      'vat_halalas': instance.vatHalalas,
      'total_halalas': instance.totalHalalas,
    };

_CheckoutQuote _$CheckoutQuoteFromJson(Map<String, dynamic> json) =>
    _CheckoutQuote(
      branchId: (json['branch_id'] as num?)?.toInt(),
      totals: json['totals'] == null
          ? const CheckoutTotals()
          : CheckoutTotals.fromJson(json['totals'] as Map<String, dynamic>),
      allAvailable: json['all_available'] as bool? ?? false,
    );

Map<String, dynamic> _$CheckoutQuoteToJson(_CheckoutQuote instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'totals': instance.totals,
      'all_available': instance.allAvailable,
    };
