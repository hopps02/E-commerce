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
    @JsonKey(name: 'description_ar') String? descriptionAr,
    @JsonKey(name: 'description_en') String? descriptionEn,
    String? brand,

    /// How it is sold: piece, kg, meter... The label arrives ready to print.
    @Default('piece') String unit,
    @JsonKey(name: 'unit_label') String? unitLabel,

    /// Extra photos. Only the product screen asks for them; a list row is
    /// served with its one card image.
    @Default(<String>[]) List<String> images,
  }) = _BranchProduct;

  factory BranchProduct.fromJson(Map<String, dynamic> json) =>
      _$BranchProductFromJson(json);

  String name(bool arabic) =>
      (arabic ? nameAr : nameEn) ?? nameAr ?? nameEn ?? '';

  bool get hasDiscount => discountHalalas > 0;

  int get effectivePriceHalalas => priceHalalas - discountHalalas;

  bool get inStock => available > 0;

  String description(bool arabic) =>
      ((arabic ? descriptionAr : descriptionEn) ??
              descriptionAr ??
              descriptionEn ??
              '')
          .trim();

  /// Everything to swipe through: the main photo first, then the gallery.
  List<String> get gallery => [
    if ((imageUrl ?? '').isNotEmpty) imageUrl!,
    ...images.where((url) => url.isNotEmpty),
  ];

  /// What the price and the quantity are counted in: "كيلو", "قطعة".
  String get unitName => (unitLabel ?? '').trim();
}


/// A home-screen ad (GET /mobile/banners). Everything the app needs to draw
/// it, plus a target that arrives already resolved: a category, a shelf row,
/// or the hand-picked products as cards.
@freezed
abstract class HomeBanner with _$HomeBanner {
  const HomeBanner._();

  const factory HomeBanner({
    required int id,
    @Default('home_hero') String placement,
    @JsonKey(name: 'title_ar') String? titleAr,
    @JsonKey(name: 'title_en') String? titleEn,
    @JsonKey(name: 'subtitle_ar') String? subtitleAr,
    @JsonKey(name: 'subtitle_en') String? subtitleEn,
    @JsonKey(name: 'badge_ar') String? badgeAr,
    @JsonKey(name: 'badge_en') String? badgeEn,
    @JsonKey(name: 'cta_ar') String? ctaAr,
    @JsonKey(name: 'cta_en') String? ctaEn,
    @JsonKey(name: 'image_url') String? imageUrl,
    BannerTarget? target,
  }) = _HomeBanner;

  factory HomeBanner.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerFromJson(json);

  String title(bool arabic) =>
      ((arabic ? titleAr : titleEn) ?? titleAr ?? titleEn ?? '').trim();

  String subtitle(bool arabic) =>
      ((arabic ? subtitleAr : subtitleEn) ?? subtitleAr ?? subtitleEn ?? '')
          .trim();

  String badge(bool arabic) =>
      ((arabic ? badgeAr : badgeEn) ?? badgeAr ?? badgeEn ?? '').trim();

  String cta(bool arabic) =>
      ((arabic ? ctaAr : ctaEn) ?? ctaAr ?? ctaEn ?? '').trim();

  bool get isHero => placement == 'home_hero';

  bool get isTile => placement == 'home_tiles';

  /// Whether a tap leads anywhere at all.
  bool get opensSomething => (target?.type ?? 'none') != 'none';
}

/// What tapping an ad opens.
@freezed
abstract class BannerTarget with _$BannerTarget {
  const BannerTarget._();

  const factory BannerTarget({
    @Default('none') String type,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'branch_item_id') int? branchItemId,
    @Default(<BranchProduct>[]) List<BranchProduct> products,
  }) = _BannerTarget;

  factory BannerTarget.fromJson(Map<String, dynamic> json) =>
      _$BannerTargetFromJson(json);
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
