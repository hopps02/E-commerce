import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_response.freezed.dart';
part 'catalog_response.g.dart';

/// A sellable item on a branch shelf (GET /mobile/products).
/// Prices are integer halalas; `available` is what's left after reservations.
@freezed
abstract class BranchProduct with _$BranchProduct {
  const BranchProduct._();

  const factory BranchProduct({
    required int id,
    @JsonKey(name: 'branch_id') required int branchId,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'price_halalas') @Default(0) int priceHalalas,
    @JsonKey(name: 'discount_halalas') @Default(0) int discountHalalas,
    @Default(0) int available,
    @JsonKey(name: 'stock_status') String? stockStatus,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
  }) = _BranchProduct;

  factory BranchProduct.fromJson(Map<String, dynamic> json) =>
      _$BranchProductFromJson(json);

  String name(bool arabic) =>
      (arabic ? nameAr : nameEn) ?? nameAr ?? nameEn ?? '';

  bool get hasDiscount => discountHalalas > 0;

  int get effectivePriceHalalas => priceHalalas - discountHalalas;

  bool get inStock => available > 0;
}

/// GET /mobile/categories (top-level rows; children unused in v1).
@freezed
abstract class ProductCategory with _$ProductCategory {
  const ProductCategory._();

  const factory ProductCategory({
    required int id,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _ProductCategory;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  String name(bool arabic) =>
      (arabic ? nameAr : nameEn) ?? nameAr ?? nameEn ?? '';
}

/// Store assigned to the delivery zone matched by coverage-check.
@freezed
abstract class CoverageServingBranch with _$CoverageServingBranch {
  const factory CoverageServingBranch({
    required int id,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'merchant_id') int? merchantId,
  }) = _CoverageServingBranch;

  factory CoverageServingBranch.fromJson(Map<String, dynamic> json) =>
      _$CoverageServingBranchFromJson(json);
}

/// POST /mobile/location/coverage-check response.
@freezed
abstract class CoverageResult with _$CoverageResult {
  const factory CoverageResult({
    @JsonKey(name: 'is_serviceable') @Default(false) bool isServiceable,
    @JsonKey(name: 'in_active_zone') @Default(false) bool inActiveZone,
    @JsonKey(name: 'branch_id') int? branchId,
    @JsonKey(name: 'serving_branch') CoverageServingBranch? servingBranch,
    @JsonKey(name: 'delivery_zone_id') int? deliveryZoneId,
    @JsonKey(name: 'delivery_zone_name_ar') String? deliveryZoneNameAr,
    @JsonKey(name: 'delivery_zone_name_en') String? deliveryZoneNameEn,
    @JsonKey(name: 'city_id') int? cityId,
    @JsonKey(name: 'district_id') int? districtId,
    @JsonKey(name: 'delivery_fee_halalas') int? deliveryFeeHalalas,
  }) = _CoverageResult;

  factory CoverageResult.fromJson(Map<String, dynamic> json) =>
      _$CoverageResultFromJson(json);
}

/// GET /mobile/addresses row.
@freezed
abstract class DeliveryAddress with _$DeliveryAddress {
  const DeliveryAddress._();

  const factory DeliveryAddress({
    required int id,
    String? label,
    @JsonKey(name: 'label_text') String? labelText,
    @JsonKey(name: 'display_address') @Default('') String displayAddress,
    String? street,
    @JsonKey(name: 'building_number') String? buildingNumber,
    String? floor,
    String? apartment,
    String? landmark,
    @JsonKey(name: 'delivery_instructions') String? deliveryInstructions,
    @JsonKey(name: 'city_id') int? cityId,
    double? lat,
    double? lng,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
  }) = _DeliveryAddress;

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAddressFromJson(json);

  /// Street/building/floor/apartment as one secondary line, skipping blanks.
  String get detailsLine => [
    street,
    buildingNumber,
    floor,
    apartment,
  ].whereType<String>().where((p) => p.trim().isNotEmpty).join('، ');
}

/// One line the customer is buying. Local cart state AND the wire shape for
/// validate/quote/create (only branch_item_id + quantity travel).
@freezed
abstract class CartLine with _$CartLine {
  const CartLine._();

  const factory CartLine({
    @JsonKey(name: 'branch_item_id') required int branchItemId,
    required int quantity,
    @JsonKey(includeFromJson: false, includeToJson: false)
    BranchProduct? product,
  }) = _CartLine;

  factory CartLine.fromJson(Map<String, dynamic> json) =>
      _$CartLineFromJson(json);

  int get lineSubtotalHalalas => (product?.priceHalalas ?? 0) * quantity;

  int get lineDiscountHalalas => (product?.discountHalalas ?? 0) * quantity;
}

/// POST /mobile/cart/validate response line.
@freezed
abstract class CartValidationLine with _$CartValidationLine {
  const factory CartValidationLine({
    @JsonKey(name: 'branch_item_id') required int branchItemId,
    @Default(0) int quantity,
    @Default(false) bool available,
    String? reason,
    @JsonKey(name: 'unit_price_halalas') int? unitPriceHalalas,
    @JsonKey(name: 'discount_halalas') int? discountHalalas,
    @JsonKey(name: 'available_quantity') int? availableQuantity,
  }) = _CartValidationLine;

  factory CartValidationLine.fromJson(Map<String, dynamic> json) =>
      _$CartValidationLineFromJson(json);
}

/// POST /mobile/cart/validate response.
@freezed
abstract class CartValidationResult with _$CartValidationResult {
  const factory CartValidationResult({
    @JsonKey(name: 'branch_id') int? branchId,
    @JsonKey(name: 'all_available') @Default(false) bool allAvailable,
    @Default(<CartValidationLine>[]) List<CartValidationLine> lines,
  }) = _CartValidationResult;

  factory CartValidationResult.fromJson(Map<String, dynamic> json) =>
      _$CartValidationResultFromJson(json);
}

/// POST /mobile/checkout/quote totals block (server-authoritative pricing).
@freezed
abstract class CheckoutTotals with _$CheckoutTotals {
  const factory CheckoutTotals({
    @JsonKey(name: 'subtotal_halalas') @Default(0) int subtotalHalalas,
    @JsonKey(name: 'delivery_fee_halalas') @Default(0) int deliveryFeeHalalas,
    @JsonKey(name: 'discount_halalas') @Default(0) int discountHalalas,
    @JsonKey(name: 'vat_halalas') @Default(0) int vatHalalas,
    @JsonKey(name: 'total_halalas') @Default(0) int totalHalalas,
  }) = _CheckoutTotals;

  factory CheckoutTotals.fromJson(Map<String, dynamic> json) =>
      _$CheckoutTotalsFromJson(json);
}

/// POST /mobile/checkout/quote response.
@freezed
abstract class CheckoutQuote with _$CheckoutQuote {
  const factory CheckoutQuote({
    @JsonKey(name: 'branch_id') int? branchId,
    @Default(CheckoutTotals()) CheckoutTotals totals,
    @JsonKey(name: 'all_available') @Default(false) bool allAvailable,
  }) = _CheckoutQuote;

  factory CheckoutQuote.fromJson(Map<String, dynamic> json) =>
      _$CheckoutQuoteFromJson(json);
}
