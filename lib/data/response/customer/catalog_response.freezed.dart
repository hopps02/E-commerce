// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BranchProduct {

 int get id;@JsonKey(name: 'branch_id') int get branchId;@JsonKey(name: 'category_id') int? get categoryId;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'price_halalas') int get priceHalalas;@JsonKey(name: 'discount_halalas') int get discountHalalas;/// What is left on the shelf, in the unit it is sold by: 9.5 kg.
 double get available;@JsonKey(name: 'stock_status') String? get stockStatus;@JsonKey(name: 'is_favorite') bool get isFavorite;@JsonKey(name: 'description_ar') String? get descriptionAr;@JsonKey(name: 'description_en') String? get descriptionEn; String? get brand;/// How it is sold: piece, kg, meter... The label arrives ready to print.
 String get unit;@JsonKey(name: 'unit_label') String? get unitLabel;/// How much the plus button adds: one piece, a quarter kilo, 50 g.
@JsonKey(name: 'quantity_step') double get quantityStep;/// The specs the panel filled in: weight, size, origin, expiry.
 Map<String, String> get attributes;/// Extra photos. Only the product screen asks for them; a list row is
/// served with its one card image.
 List<String> get images;
/// Create a copy of BranchProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BranchProductCopyWith<BranchProduct> get copyWith => _$BranchProductCopyWithImpl<BranchProduct>(this as BranchProduct, _$identity);

  /// Serializes this BranchProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.priceHalalas, priceHalalas) || other.priceHalalas == priceHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.available, available) || other.available == available)&&(identical(other.stockStatus, stockStatus) || other.stockStatus == stockStatus)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.descriptionAr, descriptionAr) || other.descriptionAr == descriptionAr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.unitLabel, unitLabel) || other.unitLabel == unitLabel)&&(identical(other.quantityStep, quantityStep) || other.quantityStep == quantityStep)&&const DeepCollectionEquality().equals(other.attributes, attributes)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,branchId,categoryId,nameAr,nameEn,imageUrl,priceHalalas,discountHalalas,available,stockStatus,isFavorite,descriptionAr,descriptionEn,brand,unit,unitLabel,quantityStep,const DeepCollectionEquality().hash(attributes),const DeepCollectionEquality().hash(images)]);

@override
String toString() {
  return 'BranchProduct(id: $id, branchId: $branchId, categoryId: $categoryId, nameAr: $nameAr, nameEn: $nameEn, imageUrl: $imageUrl, priceHalalas: $priceHalalas, discountHalalas: $discountHalalas, available: $available, stockStatus: $stockStatus, isFavorite: $isFavorite, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, brand: $brand, unit: $unit, unitLabel: $unitLabel, quantityStep: $quantityStep, attributes: $attributes, images: $images)';
}


}

/// @nodoc
abstract mixin class $BranchProductCopyWith<$Res>  {
  factory $BranchProductCopyWith(BranchProduct value, $Res Function(BranchProduct) _then) = _$BranchProductCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'branch_id') int branchId,@JsonKey(name: 'category_id') int? categoryId,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'price_halalas') int priceHalalas,@JsonKey(name: 'discount_halalas') int discountHalalas, double available,@JsonKey(name: 'stock_status') String? stockStatus,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'description_ar') String? descriptionAr,@JsonKey(name: 'description_en') String? descriptionEn, String? brand, String unit,@JsonKey(name: 'unit_label') String? unitLabel,@JsonKey(name: 'quantity_step') double quantityStep, Map<String, String> attributes, List<String> images
});




}
/// @nodoc
class _$BranchProductCopyWithImpl<$Res>
    implements $BranchProductCopyWith<$Res> {
  _$BranchProductCopyWithImpl(this._self, this._then);

  final BranchProduct _self;
  final $Res Function(BranchProduct) _then;

/// Create a copy of BranchProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchId = null,Object? categoryId = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? imageUrl = freezed,Object? priceHalalas = null,Object? discountHalalas = null,Object? available = null,Object? stockStatus = freezed,Object? isFavorite = null,Object? descriptionAr = freezed,Object? descriptionEn = freezed,Object? brand = freezed,Object? unit = null,Object? unitLabel = freezed,Object? quantityStep = null,Object? attributes = null,Object? images = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,priceHalalas: null == priceHalalas ? _self.priceHalalas : priceHalalas // ignore: cast_nullable_to_non_nullable
as int,discountHalalas: null == discountHalalas ? _self.discountHalalas : discountHalalas // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,stockStatus: freezed == stockStatus ? _self.stockStatus : stockStatus // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,descriptionAr: freezed == descriptionAr ? _self.descriptionAr : descriptionAr // ignore: cast_nullable_to_non_nullable
as String?,descriptionEn: freezed == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,unitLabel: freezed == unitLabel ? _self.unitLabel : unitLabel // ignore: cast_nullable_to_non_nullable
as String?,quantityStep: null == quantityStep ? _self.quantityStep : quantityStep // ignore: cast_nullable_to_non_nullable
as double,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BranchProduct].
extension BranchProductPatterns on BranchProduct {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BranchProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BranchProduct() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BranchProduct value)  $default,){
final _that = this;
switch (_that) {
case _BranchProduct():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BranchProduct value)?  $default,){
final _that = this;
switch (_that) {
case _BranchProduct() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'branch_id')  int branchId, @JsonKey(name: 'category_id')  int? categoryId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'price_halalas')  int priceHalalas, @JsonKey(name: 'discount_halalas')  int discountHalalas,  double available, @JsonKey(name: 'stock_status')  String? stockStatus, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'description_ar')  String? descriptionAr, @JsonKey(name: 'description_en')  String? descriptionEn,  String? brand,  String unit, @JsonKey(name: 'unit_label')  String? unitLabel, @JsonKey(name: 'quantity_step')  double quantityStep,  Map<String, String> attributes,  List<String> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BranchProduct() when $default != null:
return $default(_that.id,_that.branchId,_that.categoryId,_that.nameAr,_that.nameEn,_that.imageUrl,_that.priceHalalas,_that.discountHalalas,_that.available,_that.stockStatus,_that.isFavorite,_that.descriptionAr,_that.descriptionEn,_that.brand,_that.unit,_that.unitLabel,_that.quantityStep,_that.attributes,_that.images);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'branch_id')  int branchId, @JsonKey(name: 'category_id')  int? categoryId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'price_halalas')  int priceHalalas, @JsonKey(name: 'discount_halalas')  int discountHalalas,  double available, @JsonKey(name: 'stock_status')  String? stockStatus, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'description_ar')  String? descriptionAr, @JsonKey(name: 'description_en')  String? descriptionEn,  String? brand,  String unit, @JsonKey(name: 'unit_label')  String? unitLabel, @JsonKey(name: 'quantity_step')  double quantityStep,  Map<String, String> attributes,  List<String> images)  $default,) {final _that = this;
switch (_that) {
case _BranchProduct():
return $default(_that.id,_that.branchId,_that.categoryId,_that.nameAr,_that.nameEn,_that.imageUrl,_that.priceHalalas,_that.discountHalalas,_that.available,_that.stockStatus,_that.isFavorite,_that.descriptionAr,_that.descriptionEn,_that.brand,_that.unit,_that.unitLabel,_that.quantityStep,_that.attributes,_that.images);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'branch_id')  int branchId, @JsonKey(name: 'category_id')  int? categoryId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'price_halalas')  int priceHalalas, @JsonKey(name: 'discount_halalas')  int discountHalalas,  double available, @JsonKey(name: 'stock_status')  String? stockStatus, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'description_ar')  String? descriptionAr, @JsonKey(name: 'description_en')  String? descriptionEn,  String? brand,  String unit, @JsonKey(name: 'unit_label')  String? unitLabel, @JsonKey(name: 'quantity_step')  double quantityStep,  Map<String, String> attributes,  List<String> images)?  $default,) {final _that = this;
switch (_that) {
case _BranchProduct() when $default != null:
return $default(_that.id,_that.branchId,_that.categoryId,_that.nameAr,_that.nameEn,_that.imageUrl,_that.priceHalalas,_that.discountHalalas,_that.available,_that.stockStatus,_that.isFavorite,_that.descriptionAr,_that.descriptionEn,_that.brand,_that.unit,_that.unitLabel,_that.quantityStep,_that.attributes,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BranchProduct extends BranchProduct {
  const _BranchProduct({required this.id, @JsonKey(name: 'branch_id') required this.branchId, @JsonKey(name: 'category_id') this.categoryId, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'price_halalas') this.priceHalalas = 0, @JsonKey(name: 'discount_halalas') this.discountHalalas = 0, this.available = 0, @JsonKey(name: 'stock_status') this.stockStatus, @JsonKey(name: 'is_favorite') this.isFavorite = false, @JsonKey(name: 'description_ar') this.descriptionAr, @JsonKey(name: 'description_en') this.descriptionEn, this.brand, this.unit = 'piece', @JsonKey(name: 'unit_label') this.unitLabel, @JsonKey(name: 'quantity_step') this.quantityStep = 1, final  Map<String, String> attributes = const <String, String>{}, final  List<String> images = const <String>[]}): _attributes = attributes,_images = images,super._();
  factory _BranchProduct.fromJson(Map<String, dynamic> json) => _$BranchProductFromJson(json);

@override final  int id;
@override@JsonKey(name: 'branch_id') final  int branchId;
@override@JsonKey(name: 'category_id') final  int? categoryId;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'price_halalas') final  int priceHalalas;
@override@JsonKey(name: 'discount_halalas') final  int discountHalalas;
/// What is left on the shelf, in the unit it is sold by: 9.5 kg.
@override@JsonKey() final  double available;
@override@JsonKey(name: 'stock_status') final  String? stockStatus;
@override@JsonKey(name: 'is_favorite') final  bool isFavorite;
@override@JsonKey(name: 'description_ar') final  String? descriptionAr;
@override@JsonKey(name: 'description_en') final  String? descriptionEn;
@override final  String? brand;
/// How it is sold: piece, kg, meter... The label arrives ready to print.
@override@JsonKey() final  String unit;
@override@JsonKey(name: 'unit_label') final  String? unitLabel;
/// How much the plus button adds: one piece, a quarter kilo, 50 g.
@override@JsonKey(name: 'quantity_step') final  double quantityStep;
/// The specs the panel filled in: weight, size, origin, expiry.
 final  Map<String, String> _attributes;
/// The specs the panel filled in: weight, size, origin, expiry.
@override@JsonKey() Map<String, String> get attributes {
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributes);
}

/// Extra photos. Only the product screen asks for them; a list row is
/// served with its one card image.
 final  List<String> _images;
/// Extra photos. Only the product screen asks for them; a list row is
/// served with its one card image.
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of BranchProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BranchProductCopyWith<_BranchProduct> get copyWith => __$BranchProductCopyWithImpl<_BranchProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BranchProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BranchProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.priceHalalas, priceHalalas) || other.priceHalalas == priceHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.available, available) || other.available == available)&&(identical(other.stockStatus, stockStatus) || other.stockStatus == stockStatus)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.descriptionAr, descriptionAr) || other.descriptionAr == descriptionAr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.unitLabel, unitLabel) || other.unitLabel == unitLabel)&&(identical(other.quantityStep, quantityStep) || other.quantityStep == quantityStep)&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,branchId,categoryId,nameAr,nameEn,imageUrl,priceHalalas,discountHalalas,available,stockStatus,isFavorite,descriptionAr,descriptionEn,brand,unit,unitLabel,quantityStep,const DeepCollectionEquality().hash(_attributes),const DeepCollectionEquality().hash(_images)]);

@override
String toString() {
  return 'BranchProduct(id: $id, branchId: $branchId, categoryId: $categoryId, nameAr: $nameAr, nameEn: $nameEn, imageUrl: $imageUrl, priceHalalas: $priceHalalas, discountHalalas: $discountHalalas, available: $available, stockStatus: $stockStatus, isFavorite: $isFavorite, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, brand: $brand, unit: $unit, unitLabel: $unitLabel, quantityStep: $quantityStep, attributes: $attributes, images: $images)';
}


}

/// @nodoc
abstract mixin class _$BranchProductCopyWith<$Res> implements $BranchProductCopyWith<$Res> {
  factory _$BranchProductCopyWith(_BranchProduct value, $Res Function(_BranchProduct) _then) = __$BranchProductCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'branch_id') int branchId,@JsonKey(name: 'category_id') int? categoryId,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'price_halalas') int priceHalalas,@JsonKey(name: 'discount_halalas') int discountHalalas, double available,@JsonKey(name: 'stock_status') String? stockStatus,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'description_ar') String? descriptionAr,@JsonKey(name: 'description_en') String? descriptionEn, String? brand, String unit,@JsonKey(name: 'unit_label') String? unitLabel,@JsonKey(name: 'quantity_step') double quantityStep, Map<String, String> attributes, List<String> images
});




}
/// @nodoc
class __$BranchProductCopyWithImpl<$Res>
    implements _$BranchProductCopyWith<$Res> {
  __$BranchProductCopyWithImpl(this._self, this._then);

  final _BranchProduct _self;
  final $Res Function(_BranchProduct) _then;

/// Create a copy of BranchProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchId = null,Object? categoryId = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? imageUrl = freezed,Object? priceHalalas = null,Object? discountHalalas = null,Object? available = null,Object? stockStatus = freezed,Object? isFavorite = null,Object? descriptionAr = freezed,Object? descriptionEn = freezed,Object? brand = freezed,Object? unit = null,Object? unitLabel = freezed,Object? quantityStep = null,Object? attributes = null,Object? images = null,}) {
  return _then(_BranchProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,priceHalalas: null == priceHalalas ? _self.priceHalalas : priceHalalas // ignore: cast_nullable_to_non_nullable
as int,discountHalalas: null == discountHalalas ? _self.discountHalalas : discountHalalas // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as double,stockStatus: freezed == stockStatus ? _self.stockStatus : stockStatus // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,descriptionAr: freezed == descriptionAr ? _self.descriptionAr : descriptionAr // ignore: cast_nullable_to_non_nullable
as String?,descriptionEn: freezed == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,unitLabel: freezed == unitLabel ? _self.unitLabel : unitLabel // ignore: cast_nullable_to_non_nullable
as String?,quantityStep: null == quantityStep ? _self.quantityStep : quantityStep // ignore: cast_nullable_to_non_nullable
as double,attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$HomeBanner {

 int get id; String get placement;@JsonKey(name: 'title_ar') String? get titleAr;@JsonKey(name: 'title_en') String? get titleEn;@JsonKey(name: 'subtitle_ar') String? get subtitleAr;@JsonKey(name: 'subtitle_en') String? get subtitleEn;@JsonKey(name: 'badge_ar') String? get badgeAr;@JsonKey(name: 'badge_en') String? get badgeEn;@JsonKey(name: 'cta_ar') String? get ctaAr;@JsonKey(name: 'cta_en') String? get ctaEn;@JsonKey(name: 'image_url') String? get imageUrl; BannerTarget? get target;
/// Create a copy of HomeBanner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeBannerCopyWith<HomeBanner> get copyWith => _$HomeBannerCopyWithImpl<HomeBanner>(this as HomeBanner, _$identity);

  /// Serializes this HomeBanner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeBanner&&(identical(other.id, id) || other.id == id)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.subtitleAr, subtitleAr) || other.subtitleAr == subtitleAr)&&(identical(other.subtitleEn, subtitleEn) || other.subtitleEn == subtitleEn)&&(identical(other.badgeAr, badgeAr) || other.badgeAr == badgeAr)&&(identical(other.badgeEn, badgeEn) || other.badgeEn == badgeEn)&&(identical(other.ctaAr, ctaAr) || other.ctaAr == ctaAr)&&(identical(other.ctaEn, ctaEn) || other.ctaEn == ctaEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placement,titleAr,titleEn,subtitleAr,subtitleEn,badgeAr,badgeEn,ctaAr,ctaEn,imageUrl,target);

@override
String toString() {
  return 'HomeBanner(id: $id, placement: $placement, titleAr: $titleAr, titleEn: $titleEn, subtitleAr: $subtitleAr, subtitleEn: $subtitleEn, badgeAr: $badgeAr, badgeEn: $badgeEn, ctaAr: $ctaAr, ctaEn: $ctaEn, imageUrl: $imageUrl, target: $target)';
}


}

/// @nodoc
abstract mixin class $HomeBannerCopyWith<$Res>  {
  factory $HomeBannerCopyWith(HomeBanner value, $Res Function(HomeBanner) _then) = _$HomeBannerCopyWithImpl;
@useResult
$Res call({
 int id, String placement,@JsonKey(name: 'title_ar') String? titleAr,@JsonKey(name: 'title_en') String? titleEn,@JsonKey(name: 'subtitle_ar') String? subtitleAr,@JsonKey(name: 'subtitle_en') String? subtitleEn,@JsonKey(name: 'badge_ar') String? badgeAr,@JsonKey(name: 'badge_en') String? badgeEn,@JsonKey(name: 'cta_ar') String? ctaAr,@JsonKey(name: 'cta_en') String? ctaEn,@JsonKey(name: 'image_url') String? imageUrl, BannerTarget? target
});


$BannerTargetCopyWith<$Res>? get target;

}
/// @nodoc
class _$HomeBannerCopyWithImpl<$Res>
    implements $HomeBannerCopyWith<$Res> {
  _$HomeBannerCopyWithImpl(this._self, this._then);

  final HomeBanner _self;
  final $Res Function(HomeBanner) _then;

/// Create a copy of HomeBanner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placement = null,Object? titleAr = freezed,Object? titleEn = freezed,Object? subtitleAr = freezed,Object? subtitleEn = freezed,Object? badgeAr = freezed,Object? badgeEn = freezed,Object? ctaAr = freezed,Object? ctaEn = freezed,Object? imageUrl = freezed,Object? target = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as String,titleAr: freezed == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String?,titleEn: freezed == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String?,subtitleAr: freezed == subtitleAr ? _self.subtitleAr : subtitleAr // ignore: cast_nullable_to_non_nullable
as String?,subtitleEn: freezed == subtitleEn ? _self.subtitleEn : subtitleEn // ignore: cast_nullable_to_non_nullable
as String?,badgeAr: freezed == badgeAr ? _self.badgeAr : badgeAr // ignore: cast_nullable_to_non_nullable
as String?,badgeEn: freezed == badgeEn ? _self.badgeEn : badgeEn // ignore: cast_nullable_to_non_nullable
as String?,ctaAr: freezed == ctaAr ? _self.ctaAr : ctaAr // ignore: cast_nullable_to_non_nullable
as String?,ctaEn: freezed == ctaEn ? _self.ctaEn : ctaEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as BannerTarget?,
  ));
}
/// Create a copy of HomeBanner
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BannerTargetCopyWith<$Res>? get target {
    if (_self.target == null) {
    return null;
  }

  return $BannerTargetCopyWith<$Res>(_self.target!, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeBanner].
extension HomeBannerPatterns on HomeBanner {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeBanner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeBanner() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeBanner value)  $default,){
final _that = this;
switch (_that) {
case _HomeBanner():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeBanner value)?  $default,){
final _that = this;
switch (_that) {
case _HomeBanner() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String placement, @JsonKey(name: 'title_ar')  String? titleAr, @JsonKey(name: 'title_en')  String? titleEn, @JsonKey(name: 'subtitle_ar')  String? subtitleAr, @JsonKey(name: 'subtitle_en')  String? subtitleEn, @JsonKey(name: 'badge_ar')  String? badgeAr, @JsonKey(name: 'badge_en')  String? badgeEn, @JsonKey(name: 'cta_ar')  String? ctaAr, @JsonKey(name: 'cta_en')  String? ctaEn, @JsonKey(name: 'image_url')  String? imageUrl,  BannerTarget? target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeBanner() when $default != null:
return $default(_that.id,_that.placement,_that.titleAr,_that.titleEn,_that.subtitleAr,_that.subtitleEn,_that.badgeAr,_that.badgeEn,_that.ctaAr,_that.ctaEn,_that.imageUrl,_that.target);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String placement, @JsonKey(name: 'title_ar')  String? titleAr, @JsonKey(name: 'title_en')  String? titleEn, @JsonKey(name: 'subtitle_ar')  String? subtitleAr, @JsonKey(name: 'subtitle_en')  String? subtitleEn, @JsonKey(name: 'badge_ar')  String? badgeAr, @JsonKey(name: 'badge_en')  String? badgeEn, @JsonKey(name: 'cta_ar')  String? ctaAr, @JsonKey(name: 'cta_en')  String? ctaEn, @JsonKey(name: 'image_url')  String? imageUrl,  BannerTarget? target)  $default,) {final _that = this;
switch (_that) {
case _HomeBanner():
return $default(_that.id,_that.placement,_that.titleAr,_that.titleEn,_that.subtitleAr,_that.subtitleEn,_that.badgeAr,_that.badgeEn,_that.ctaAr,_that.ctaEn,_that.imageUrl,_that.target);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String placement, @JsonKey(name: 'title_ar')  String? titleAr, @JsonKey(name: 'title_en')  String? titleEn, @JsonKey(name: 'subtitle_ar')  String? subtitleAr, @JsonKey(name: 'subtitle_en')  String? subtitleEn, @JsonKey(name: 'badge_ar')  String? badgeAr, @JsonKey(name: 'badge_en')  String? badgeEn, @JsonKey(name: 'cta_ar')  String? ctaAr, @JsonKey(name: 'cta_en')  String? ctaEn, @JsonKey(name: 'image_url')  String? imageUrl,  BannerTarget? target)?  $default,) {final _that = this;
switch (_that) {
case _HomeBanner() when $default != null:
return $default(_that.id,_that.placement,_that.titleAr,_that.titleEn,_that.subtitleAr,_that.subtitleEn,_that.badgeAr,_that.badgeEn,_that.ctaAr,_that.ctaEn,_that.imageUrl,_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeBanner extends HomeBanner {
  const _HomeBanner({required this.id, this.placement = 'home_hero', @JsonKey(name: 'title_ar') this.titleAr, @JsonKey(name: 'title_en') this.titleEn, @JsonKey(name: 'subtitle_ar') this.subtitleAr, @JsonKey(name: 'subtitle_en') this.subtitleEn, @JsonKey(name: 'badge_ar') this.badgeAr, @JsonKey(name: 'badge_en') this.badgeEn, @JsonKey(name: 'cta_ar') this.ctaAr, @JsonKey(name: 'cta_en') this.ctaEn, @JsonKey(name: 'image_url') this.imageUrl, this.target}): super._();
  factory _HomeBanner.fromJson(Map<String, dynamic> json) => _$HomeBannerFromJson(json);

@override final  int id;
@override@JsonKey() final  String placement;
@override@JsonKey(name: 'title_ar') final  String? titleAr;
@override@JsonKey(name: 'title_en') final  String? titleEn;
@override@JsonKey(name: 'subtitle_ar') final  String? subtitleAr;
@override@JsonKey(name: 'subtitle_en') final  String? subtitleEn;
@override@JsonKey(name: 'badge_ar') final  String? badgeAr;
@override@JsonKey(name: 'badge_en') final  String? badgeEn;
@override@JsonKey(name: 'cta_ar') final  String? ctaAr;
@override@JsonKey(name: 'cta_en') final  String? ctaEn;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override final  BannerTarget? target;

/// Create a copy of HomeBanner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeBannerCopyWith<_HomeBanner> get copyWith => __$HomeBannerCopyWithImpl<_HomeBanner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeBannerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeBanner&&(identical(other.id, id) || other.id == id)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.subtitleAr, subtitleAr) || other.subtitleAr == subtitleAr)&&(identical(other.subtitleEn, subtitleEn) || other.subtitleEn == subtitleEn)&&(identical(other.badgeAr, badgeAr) || other.badgeAr == badgeAr)&&(identical(other.badgeEn, badgeEn) || other.badgeEn == badgeEn)&&(identical(other.ctaAr, ctaAr) || other.ctaAr == ctaAr)&&(identical(other.ctaEn, ctaEn) || other.ctaEn == ctaEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placement,titleAr,titleEn,subtitleAr,subtitleEn,badgeAr,badgeEn,ctaAr,ctaEn,imageUrl,target);

@override
String toString() {
  return 'HomeBanner(id: $id, placement: $placement, titleAr: $titleAr, titleEn: $titleEn, subtitleAr: $subtitleAr, subtitleEn: $subtitleEn, badgeAr: $badgeAr, badgeEn: $badgeEn, ctaAr: $ctaAr, ctaEn: $ctaEn, imageUrl: $imageUrl, target: $target)';
}


}

/// @nodoc
abstract mixin class _$HomeBannerCopyWith<$Res> implements $HomeBannerCopyWith<$Res> {
  factory _$HomeBannerCopyWith(_HomeBanner value, $Res Function(_HomeBanner) _then) = __$HomeBannerCopyWithImpl;
@override @useResult
$Res call({
 int id, String placement,@JsonKey(name: 'title_ar') String? titleAr,@JsonKey(name: 'title_en') String? titleEn,@JsonKey(name: 'subtitle_ar') String? subtitleAr,@JsonKey(name: 'subtitle_en') String? subtitleEn,@JsonKey(name: 'badge_ar') String? badgeAr,@JsonKey(name: 'badge_en') String? badgeEn,@JsonKey(name: 'cta_ar') String? ctaAr,@JsonKey(name: 'cta_en') String? ctaEn,@JsonKey(name: 'image_url') String? imageUrl, BannerTarget? target
});


@override $BannerTargetCopyWith<$Res>? get target;

}
/// @nodoc
class __$HomeBannerCopyWithImpl<$Res>
    implements _$HomeBannerCopyWith<$Res> {
  __$HomeBannerCopyWithImpl(this._self, this._then);

  final _HomeBanner _self;
  final $Res Function(_HomeBanner) _then;

/// Create a copy of HomeBanner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placement = null,Object? titleAr = freezed,Object? titleEn = freezed,Object? subtitleAr = freezed,Object? subtitleEn = freezed,Object? badgeAr = freezed,Object? badgeEn = freezed,Object? ctaAr = freezed,Object? ctaEn = freezed,Object? imageUrl = freezed,Object? target = freezed,}) {
  return _then(_HomeBanner(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as String,titleAr: freezed == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String?,titleEn: freezed == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String?,subtitleAr: freezed == subtitleAr ? _self.subtitleAr : subtitleAr // ignore: cast_nullable_to_non_nullable
as String?,subtitleEn: freezed == subtitleEn ? _self.subtitleEn : subtitleEn // ignore: cast_nullable_to_non_nullable
as String?,badgeAr: freezed == badgeAr ? _self.badgeAr : badgeAr // ignore: cast_nullable_to_non_nullable
as String?,badgeEn: freezed == badgeEn ? _self.badgeEn : badgeEn // ignore: cast_nullable_to_non_nullable
as String?,ctaAr: freezed == ctaAr ? _self.ctaAr : ctaAr // ignore: cast_nullable_to_non_nullable
as String?,ctaEn: freezed == ctaEn ? _self.ctaEn : ctaEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as BannerTarget?,
  ));
}

/// Create a copy of HomeBanner
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BannerTargetCopyWith<$Res>? get target {
    if (_self.target == null) {
    return null;
  }

  return $BannerTargetCopyWith<$Res>(_self.target!, (value) {
    return _then(_self.copyWith(target: value));
  });
}
}


/// @nodoc
mixin _$BannerTarget {

 String get type;@JsonKey(name: 'category_id') int? get categoryId;@JsonKey(name: 'branch_item_id') int? get branchItemId; List<BranchProduct> get products;
/// Create a copy of BannerTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BannerTargetCopyWith<BannerTarget> get copyWith => _$BannerTargetCopyWithImpl<BannerTarget>(this as BannerTarget, _$identity);

  /// Serializes this BannerTarget to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BannerTarget&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.branchItemId, branchItemId) || other.branchItemId == branchItemId)&&const DeepCollectionEquality().equals(other.products, products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,categoryId,branchItemId,const DeepCollectionEquality().hash(products));

@override
String toString() {
  return 'BannerTarget(type: $type, categoryId: $categoryId, branchItemId: $branchItemId, products: $products)';
}


}

/// @nodoc
abstract mixin class $BannerTargetCopyWith<$Res>  {
  factory $BannerTargetCopyWith(BannerTarget value, $Res Function(BannerTarget) _then) = _$BannerTargetCopyWithImpl;
@useResult
$Res call({
 String type,@JsonKey(name: 'category_id') int? categoryId,@JsonKey(name: 'branch_item_id') int? branchItemId, List<BranchProduct> products
});




}
/// @nodoc
class _$BannerTargetCopyWithImpl<$Res>
    implements $BannerTargetCopyWith<$Res> {
  _$BannerTargetCopyWithImpl(this._self, this._then);

  final BannerTarget _self;
  final $Res Function(BannerTarget) _then;

/// Create a copy of BannerTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? categoryId = freezed,Object? branchItemId = freezed,Object? products = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,branchItemId: freezed == branchItemId ? _self.branchItemId : branchItemId // ignore: cast_nullable_to_non_nullable
as int?,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<BranchProduct>,
  ));
}

}


/// Adds pattern-matching-related methods to [BannerTarget].
extension BannerTargetPatterns on BannerTarget {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BannerTarget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BannerTarget() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BannerTarget value)  $default,){
final _that = this;
switch (_that) {
case _BannerTarget():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BannerTarget value)?  $default,){
final _that = this;
switch (_that) {
case _BannerTarget() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type, @JsonKey(name: 'category_id')  int? categoryId, @JsonKey(name: 'branch_item_id')  int? branchItemId,  List<BranchProduct> products)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BannerTarget() when $default != null:
return $default(_that.type,_that.categoryId,_that.branchItemId,_that.products);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type, @JsonKey(name: 'category_id')  int? categoryId, @JsonKey(name: 'branch_item_id')  int? branchItemId,  List<BranchProduct> products)  $default,) {final _that = this;
switch (_that) {
case _BannerTarget():
return $default(_that.type,_that.categoryId,_that.branchItemId,_that.products);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type, @JsonKey(name: 'category_id')  int? categoryId, @JsonKey(name: 'branch_item_id')  int? branchItemId,  List<BranchProduct> products)?  $default,) {final _that = this;
switch (_that) {
case _BannerTarget() when $default != null:
return $default(_that.type,_that.categoryId,_that.branchItemId,_that.products);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BannerTarget extends BannerTarget {
  const _BannerTarget({this.type = 'none', @JsonKey(name: 'category_id') this.categoryId, @JsonKey(name: 'branch_item_id') this.branchItemId, final  List<BranchProduct> products = const <BranchProduct>[]}): _products = products,super._();
  factory _BannerTarget.fromJson(Map<String, dynamic> json) => _$BannerTargetFromJson(json);

@override@JsonKey() final  String type;
@override@JsonKey(name: 'category_id') final  int? categoryId;
@override@JsonKey(name: 'branch_item_id') final  int? branchItemId;
 final  List<BranchProduct> _products;
@override@JsonKey() List<BranchProduct> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of BannerTarget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BannerTargetCopyWith<_BannerTarget> get copyWith => __$BannerTargetCopyWithImpl<_BannerTarget>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BannerTargetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BannerTarget&&(identical(other.type, type) || other.type == type)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.branchItemId, branchItemId) || other.branchItemId == branchItemId)&&const DeepCollectionEquality().equals(other._products, _products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,categoryId,branchItemId,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'BannerTarget(type: $type, categoryId: $categoryId, branchItemId: $branchItemId, products: $products)';
}


}

/// @nodoc
abstract mixin class _$BannerTargetCopyWith<$Res> implements $BannerTargetCopyWith<$Res> {
  factory _$BannerTargetCopyWith(_BannerTarget value, $Res Function(_BannerTarget) _then) = __$BannerTargetCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(name: 'category_id') int? categoryId,@JsonKey(name: 'branch_item_id') int? branchItemId, List<BranchProduct> products
});




}
/// @nodoc
class __$BannerTargetCopyWithImpl<$Res>
    implements _$BannerTargetCopyWith<$Res> {
  __$BannerTargetCopyWithImpl(this._self, this._then);

  final _BannerTarget _self;
  final $Res Function(_BannerTarget) _then;

/// Create a copy of BannerTarget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? categoryId = freezed,Object? branchItemId = freezed,Object? products = null,}) {
  return _then(_BannerTarget(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,branchItemId: freezed == branchItemId ? _self.branchItemId : branchItemId // ignore: cast_nullable_to_non_nullable
as int?,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<BranchProduct>,
  ));
}


}


/// @nodoc
mixin _$ProductCategory {

 int get id;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn;@JsonKey(name: 'image_url') String? get imageUrl;
/// Create a copy of ProductCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCategoryCopyWith<ProductCategory> get copyWith => _$ProductCategoryCopyWithImpl<ProductCategory>(this as ProductCategory, _$identity);

  /// Serializes this ProductCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameAr,nameEn,imageUrl);

@override
String toString() {
  return 'ProductCategory(id: $id, nameAr: $nameAr, nameEn: $nameEn, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $ProductCategoryCopyWith<$Res>  {
  factory $ProductCategoryCopyWith(ProductCategory value, $Res Function(ProductCategory) _then) = _$ProductCategoryCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'image_url') String? imageUrl
});




}
/// @nodoc
class _$ProductCategoryCopyWithImpl<$Res>
    implements $ProductCategoryCopyWith<$Res> {
  _$ProductCategoryCopyWithImpl(this._self, this._then);

  final ProductCategory _self;
  final $Res Function(ProductCategory) _then;

/// Create a copy of ProductCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductCategory].
extension ProductCategoryPatterns on ProductCategory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductCategory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductCategory value)  $default,){
final _that = this;
switch (_that) {
case _ProductCategory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductCategory value)?  $default,){
final _that = this;
switch (_that) {
case _ProductCategory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductCategory() when $default != null:
return $default(_that.id,_that.nameAr,_that.nameEn,_that.imageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ProductCategory():
return $default(_that.id,_that.nameAr,_that.nameEn,_that.imageUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ProductCategory() when $default != null:
return $default(_that.id,_that.nameAr,_that.nameEn,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductCategory extends ProductCategory {
  const _ProductCategory({required this.id, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, @JsonKey(name: 'image_url') this.imageUrl}): super._();
  factory _ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);

@override final  int id;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override@JsonKey(name: 'image_url') final  String? imageUrl;

/// Create a copy of ProductCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCategoryCopyWith<_ProductCategory> get copyWith => __$ProductCategoryCopyWithImpl<_ProductCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameAr,nameEn,imageUrl);

@override
String toString() {
  return 'ProductCategory(id: $id, nameAr: $nameAr, nameEn: $nameEn, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ProductCategoryCopyWith<$Res> implements $ProductCategoryCopyWith<$Res> {
  factory _$ProductCategoryCopyWith(_ProductCategory value, $Res Function(_ProductCategory) _then) = __$ProductCategoryCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'image_url') String? imageUrl
});




}
/// @nodoc
class __$ProductCategoryCopyWithImpl<$Res>
    implements _$ProductCategoryCopyWith<$Res> {
  __$ProductCategoryCopyWithImpl(this._self, this._then);

  final _ProductCategory _self;
  final $Res Function(_ProductCategory) _then;

/// Create a copy of ProductCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? imageUrl = freezed,}) {
  return _then(_ProductCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DeliveryAddress {

 int get id; String? get label;@JsonKey(name: 'label_text') String? get labelText;@JsonKey(name: 'display_address') String get displayAddress; String? get street;@JsonKey(name: 'building_number') String? get buildingNumber; String? get floor; String? get apartment; String? get landmark;@JsonKey(name: 'delivery_instructions') String? get deliveryInstructions;@JsonKey(name: 'is_default') bool get isDefault;
/// Create a copy of DeliveryAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryAddressCopyWith<DeliveryAddress> get copyWith => _$DeliveryAddressCopyWithImpl<DeliveryAddress>(this as DeliveryAddress, _$identity);

  /// Serializes this DeliveryAddress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryAddress&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.labelText, labelText) || other.labelText == labelText)&&(identical(other.displayAddress, displayAddress) || other.displayAddress == displayAddress)&&(identical(other.street, street) || other.street == street)&&(identical(other.buildingNumber, buildingNumber) || other.buildingNumber == buildingNumber)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.deliveryInstructions, deliveryInstructions) || other.deliveryInstructions == deliveryInstructions)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,labelText,displayAddress,street,buildingNumber,floor,apartment,landmark,deliveryInstructions,isDefault);

@override
String toString() {
  return 'DeliveryAddress(id: $id, label: $label, labelText: $labelText, displayAddress: $displayAddress, street: $street, buildingNumber: $buildingNumber, floor: $floor, apartment: $apartment, landmark: $landmark, deliveryInstructions: $deliveryInstructions, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $DeliveryAddressCopyWith<$Res>  {
  factory $DeliveryAddressCopyWith(DeliveryAddress value, $Res Function(DeliveryAddress) _then) = _$DeliveryAddressCopyWithImpl;
@useResult
$Res call({
 int id, String? label,@JsonKey(name: 'label_text') String? labelText,@JsonKey(name: 'display_address') String displayAddress, String? street,@JsonKey(name: 'building_number') String? buildingNumber, String? floor, String? apartment, String? landmark,@JsonKey(name: 'delivery_instructions') String? deliveryInstructions,@JsonKey(name: 'is_default') bool isDefault
});




}
/// @nodoc
class _$DeliveryAddressCopyWithImpl<$Res>
    implements $DeliveryAddressCopyWith<$Res> {
  _$DeliveryAddressCopyWithImpl(this._self, this._then);

  final DeliveryAddress _self;
  final $Res Function(DeliveryAddress) _then;

/// Create a copy of DeliveryAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = freezed,Object? labelText = freezed,Object? displayAddress = null,Object? street = freezed,Object? buildingNumber = freezed,Object? floor = freezed,Object? apartment = freezed,Object? landmark = freezed,Object? deliveryInstructions = freezed,Object? isDefault = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,labelText: freezed == labelText ? _self.labelText : labelText // ignore: cast_nullable_to_non_nullable
as String?,displayAddress: null == displayAddress ? _self.displayAddress : displayAddress // ignore: cast_nullable_to_non_nullable
as String,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,buildingNumber: freezed == buildingNumber ? _self.buildingNumber : buildingNumber // ignore: cast_nullable_to_non_nullable
as String?,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String?,apartment: freezed == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String?,landmark: freezed == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String?,deliveryInstructions: freezed == deliveryInstructions ? _self.deliveryInstructions : deliveryInstructions // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DeliveryAddress].
extension DeliveryAddressPatterns on DeliveryAddress {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryAddress() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryAddress value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryAddress():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryAddress value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryAddress() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? label, @JsonKey(name: 'label_text')  String? labelText, @JsonKey(name: 'display_address')  String displayAddress,  String? street, @JsonKey(name: 'building_number')  String? buildingNumber,  String? floor,  String? apartment,  String? landmark, @JsonKey(name: 'delivery_instructions')  String? deliveryInstructions, @JsonKey(name: 'is_default')  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryAddress() when $default != null:
return $default(_that.id,_that.label,_that.labelText,_that.displayAddress,_that.street,_that.buildingNumber,_that.floor,_that.apartment,_that.landmark,_that.deliveryInstructions,_that.isDefault);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? label, @JsonKey(name: 'label_text')  String? labelText, @JsonKey(name: 'display_address')  String displayAddress,  String? street, @JsonKey(name: 'building_number')  String? buildingNumber,  String? floor,  String? apartment,  String? landmark, @JsonKey(name: 'delivery_instructions')  String? deliveryInstructions, @JsonKey(name: 'is_default')  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _DeliveryAddress():
return $default(_that.id,_that.label,_that.labelText,_that.displayAddress,_that.street,_that.buildingNumber,_that.floor,_that.apartment,_that.landmark,_that.deliveryInstructions,_that.isDefault);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? label, @JsonKey(name: 'label_text')  String? labelText, @JsonKey(name: 'display_address')  String displayAddress,  String? street, @JsonKey(name: 'building_number')  String? buildingNumber,  String? floor,  String? apartment,  String? landmark, @JsonKey(name: 'delivery_instructions')  String? deliveryInstructions, @JsonKey(name: 'is_default')  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryAddress() when $default != null:
return $default(_that.id,_that.label,_that.labelText,_that.displayAddress,_that.street,_that.buildingNumber,_that.floor,_that.apartment,_that.landmark,_that.deliveryInstructions,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeliveryAddress extends DeliveryAddress {
  const _DeliveryAddress({required this.id, this.label, @JsonKey(name: 'label_text') this.labelText, @JsonKey(name: 'display_address') this.displayAddress = '', this.street, @JsonKey(name: 'building_number') this.buildingNumber, this.floor, this.apartment, this.landmark, @JsonKey(name: 'delivery_instructions') this.deliveryInstructions, @JsonKey(name: 'is_default') this.isDefault = false}): super._();
  factory _DeliveryAddress.fromJson(Map<String, dynamic> json) => _$DeliveryAddressFromJson(json);

@override final  int id;
@override final  String? label;
@override@JsonKey(name: 'label_text') final  String? labelText;
@override@JsonKey(name: 'display_address') final  String displayAddress;
@override final  String? street;
@override@JsonKey(name: 'building_number') final  String? buildingNumber;
@override final  String? floor;
@override final  String? apartment;
@override final  String? landmark;
@override@JsonKey(name: 'delivery_instructions') final  String? deliveryInstructions;
@override@JsonKey(name: 'is_default') final  bool isDefault;

/// Create a copy of DeliveryAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryAddressCopyWith<_DeliveryAddress> get copyWith => __$DeliveryAddressCopyWithImpl<_DeliveryAddress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeliveryAddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryAddress&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.labelText, labelText) || other.labelText == labelText)&&(identical(other.displayAddress, displayAddress) || other.displayAddress == displayAddress)&&(identical(other.street, street) || other.street == street)&&(identical(other.buildingNumber, buildingNumber) || other.buildingNumber == buildingNumber)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.deliveryInstructions, deliveryInstructions) || other.deliveryInstructions == deliveryInstructions)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,labelText,displayAddress,street,buildingNumber,floor,apartment,landmark,deliveryInstructions,isDefault);

@override
String toString() {
  return 'DeliveryAddress(id: $id, label: $label, labelText: $labelText, displayAddress: $displayAddress, street: $street, buildingNumber: $buildingNumber, floor: $floor, apartment: $apartment, landmark: $landmark, deliveryInstructions: $deliveryInstructions, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$DeliveryAddressCopyWith<$Res> implements $DeliveryAddressCopyWith<$Res> {
  factory _$DeliveryAddressCopyWith(_DeliveryAddress value, $Res Function(_DeliveryAddress) _then) = __$DeliveryAddressCopyWithImpl;
@override @useResult
$Res call({
 int id, String? label,@JsonKey(name: 'label_text') String? labelText,@JsonKey(name: 'display_address') String displayAddress, String? street,@JsonKey(name: 'building_number') String? buildingNumber, String? floor, String? apartment, String? landmark,@JsonKey(name: 'delivery_instructions') String? deliveryInstructions,@JsonKey(name: 'is_default') bool isDefault
});




}
/// @nodoc
class __$DeliveryAddressCopyWithImpl<$Res>
    implements _$DeliveryAddressCopyWith<$Res> {
  __$DeliveryAddressCopyWithImpl(this._self, this._then);

  final _DeliveryAddress _self;
  final $Res Function(_DeliveryAddress) _then;

/// Create a copy of DeliveryAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = freezed,Object? labelText = freezed,Object? displayAddress = null,Object? street = freezed,Object? buildingNumber = freezed,Object? floor = freezed,Object? apartment = freezed,Object? landmark = freezed,Object? deliveryInstructions = freezed,Object? isDefault = null,}) {
  return _then(_DeliveryAddress(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,labelText: freezed == labelText ? _self.labelText : labelText // ignore: cast_nullable_to_non_nullable
as String?,displayAddress: null == displayAddress ? _self.displayAddress : displayAddress // ignore: cast_nullable_to_non_nullable
as String,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,buildingNumber: freezed == buildingNumber ? _self.buildingNumber : buildingNumber // ignore: cast_nullable_to_non_nullable
as String?,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String?,apartment: freezed == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String?,landmark: freezed == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String?,deliveryInstructions: freezed == deliveryInstructions ? _self.deliveryInstructions : deliveryInstructions // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CartLine {

@JsonKey(name: 'branch_item_id') int get branchItemId; double get quantity;@JsonKey(includeFromJson: false, includeToJson: false) BranchProduct? get product;
/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartLineCopyWith<CartLine> get copyWith => _$CartLineCopyWithImpl<CartLine>(this as CartLine, _$identity);

  /// Serializes this CartLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartLine&&(identical(other.branchItemId, branchItemId) || other.branchItemId == branchItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.product, product) || other.product == product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchItemId,quantity,product);

@override
String toString() {
  return 'CartLine(branchItemId: $branchItemId, quantity: $quantity, product: $product)';
}


}

/// @nodoc
abstract mixin class $CartLineCopyWith<$Res>  {
  factory $CartLineCopyWith(CartLine value, $Res Function(CartLine) _then) = _$CartLineCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'branch_item_id') int branchItemId, double quantity,@JsonKey(includeFromJson: false, includeToJson: false) BranchProduct? product
});


$BranchProductCopyWith<$Res>? get product;

}
/// @nodoc
class _$CartLineCopyWithImpl<$Res>
    implements $CartLineCopyWith<$Res> {
  _$CartLineCopyWithImpl(this._self, this._then);

  final CartLine _self;
  final $Res Function(CartLine) _then;

/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? branchItemId = null,Object? quantity = null,Object? product = freezed,}) {
  return _then(_self.copyWith(
branchItemId: null == branchItemId ? _self.branchItemId : branchItemId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as BranchProduct?,
  ));
}
/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BranchProductCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $BranchProductCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}


/// Adds pattern-matching-related methods to [CartLine].
extension CartLinePatterns on CartLine {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartLine() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartLine value)  $default,){
final _that = this;
switch (_that) {
case _CartLine():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartLine value)?  $default,){
final _that = this;
switch (_that) {
case _CartLine() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'branch_item_id')  int branchItemId,  double quantity, @JsonKey(includeFromJson: false, includeToJson: false)  BranchProduct? product)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartLine() when $default != null:
return $default(_that.branchItemId,_that.quantity,_that.product);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'branch_item_id')  int branchItemId,  double quantity, @JsonKey(includeFromJson: false, includeToJson: false)  BranchProduct? product)  $default,) {final _that = this;
switch (_that) {
case _CartLine():
return $default(_that.branchItemId,_that.quantity,_that.product);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'branch_item_id')  int branchItemId,  double quantity, @JsonKey(includeFromJson: false, includeToJson: false)  BranchProduct? product)?  $default,) {final _that = this;
switch (_that) {
case _CartLine() when $default != null:
return $default(_that.branchItemId,_that.quantity,_that.product);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartLine extends CartLine {
  const _CartLine({@JsonKey(name: 'branch_item_id') required this.branchItemId, required this.quantity, @JsonKey(includeFromJson: false, includeToJson: false) this.product}): super._();
  factory _CartLine.fromJson(Map<String, dynamic> json) => _$CartLineFromJson(json);

@override@JsonKey(name: 'branch_item_id') final  int branchItemId;
@override final  double quantity;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  BranchProduct? product;

/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartLineCopyWith<_CartLine> get copyWith => __$CartLineCopyWithImpl<_CartLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartLine&&(identical(other.branchItemId, branchItemId) || other.branchItemId == branchItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.product, product) || other.product == product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchItemId,quantity,product);

@override
String toString() {
  return 'CartLine(branchItemId: $branchItemId, quantity: $quantity, product: $product)';
}


}

/// @nodoc
abstract mixin class _$CartLineCopyWith<$Res> implements $CartLineCopyWith<$Res> {
  factory _$CartLineCopyWith(_CartLine value, $Res Function(_CartLine) _then) = __$CartLineCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'branch_item_id') int branchItemId, double quantity,@JsonKey(includeFromJson: false, includeToJson: false) BranchProduct? product
});


@override $BranchProductCopyWith<$Res>? get product;

}
/// @nodoc
class __$CartLineCopyWithImpl<$Res>
    implements _$CartLineCopyWith<$Res> {
  __$CartLineCopyWithImpl(this._self, this._then);

  final _CartLine _self;
  final $Res Function(_CartLine) _then;

/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? branchItemId = null,Object? quantity = null,Object? product = freezed,}) {
  return _then(_CartLine(
branchItemId: null == branchItemId ? _self.branchItemId : branchItemId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as BranchProduct?,
  ));
}

/// Create a copy of CartLine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BranchProductCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $BranchProductCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}


/// @nodoc
mixin _$CartValidationLine {

@JsonKey(name: 'branch_item_id') int get branchItemId; double get quantity; bool get available; String? get reason;@JsonKey(name: 'unit_price_halalas') int? get unitPriceHalalas;@JsonKey(name: 'discount_halalas') int? get discountHalalas;@JsonKey(name: 'available_quantity') double? get availableQuantity;
/// Create a copy of CartValidationLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartValidationLineCopyWith<CartValidationLine> get copyWith => _$CartValidationLineCopyWithImpl<CartValidationLine>(this as CartValidationLine, _$identity);

  /// Serializes this CartValidationLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartValidationLine&&(identical(other.branchItemId, branchItemId) || other.branchItemId == branchItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.available, available) || other.available == available)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.unitPriceHalalas, unitPriceHalalas) || other.unitPriceHalalas == unitPriceHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.availableQuantity, availableQuantity) || other.availableQuantity == availableQuantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchItemId,quantity,available,reason,unitPriceHalalas,discountHalalas,availableQuantity);

@override
String toString() {
  return 'CartValidationLine(branchItemId: $branchItemId, quantity: $quantity, available: $available, reason: $reason, unitPriceHalalas: $unitPriceHalalas, discountHalalas: $discountHalalas, availableQuantity: $availableQuantity)';
}


}

/// @nodoc
abstract mixin class $CartValidationLineCopyWith<$Res>  {
  factory $CartValidationLineCopyWith(CartValidationLine value, $Res Function(CartValidationLine) _then) = _$CartValidationLineCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'branch_item_id') int branchItemId, double quantity, bool available, String? reason,@JsonKey(name: 'unit_price_halalas') int? unitPriceHalalas,@JsonKey(name: 'discount_halalas') int? discountHalalas,@JsonKey(name: 'available_quantity') double? availableQuantity
});




}
/// @nodoc
class _$CartValidationLineCopyWithImpl<$Res>
    implements $CartValidationLineCopyWith<$Res> {
  _$CartValidationLineCopyWithImpl(this._self, this._then);

  final CartValidationLine _self;
  final $Res Function(CartValidationLine) _then;

/// Create a copy of CartValidationLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? branchItemId = null,Object? quantity = null,Object? available = null,Object? reason = freezed,Object? unitPriceHalalas = freezed,Object? discountHalalas = freezed,Object? availableQuantity = freezed,}) {
  return _then(_self.copyWith(
branchItemId: null == branchItemId ? _self.branchItemId : branchItemId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,unitPriceHalalas: freezed == unitPriceHalalas ? _self.unitPriceHalalas : unitPriceHalalas // ignore: cast_nullable_to_non_nullable
as int?,discountHalalas: freezed == discountHalalas ? _self.discountHalalas : discountHalalas // ignore: cast_nullable_to_non_nullable
as int?,availableQuantity: freezed == availableQuantity ? _self.availableQuantity : availableQuantity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartValidationLine].
extension CartValidationLinePatterns on CartValidationLine {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartValidationLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartValidationLine() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartValidationLine value)  $default,){
final _that = this;
switch (_that) {
case _CartValidationLine():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartValidationLine value)?  $default,){
final _that = this;
switch (_that) {
case _CartValidationLine() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'branch_item_id')  int branchItemId,  double quantity,  bool available,  String? reason, @JsonKey(name: 'unit_price_halalas')  int? unitPriceHalalas, @JsonKey(name: 'discount_halalas')  int? discountHalalas, @JsonKey(name: 'available_quantity')  double? availableQuantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartValidationLine() when $default != null:
return $default(_that.branchItemId,_that.quantity,_that.available,_that.reason,_that.unitPriceHalalas,_that.discountHalalas,_that.availableQuantity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'branch_item_id')  int branchItemId,  double quantity,  bool available,  String? reason, @JsonKey(name: 'unit_price_halalas')  int? unitPriceHalalas, @JsonKey(name: 'discount_halalas')  int? discountHalalas, @JsonKey(name: 'available_quantity')  double? availableQuantity)  $default,) {final _that = this;
switch (_that) {
case _CartValidationLine():
return $default(_that.branchItemId,_that.quantity,_that.available,_that.reason,_that.unitPriceHalalas,_that.discountHalalas,_that.availableQuantity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'branch_item_id')  int branchItemId,  double quantity,  bool available,  String? reason, @JsonKey(name: 'unit_price_halalas')  int? unitPriceHalalas, @JsonKey(name: 'discount_halalas')  int? discountHalalas, @JsonKey(name: 'available_quantity')  double? availableQuantity)?  $default,) {final _that = this;
switch (_that) {
case _CartValidationLine() when $default != null:
return $default(_that.branchItemId,_that.quantity,_that.available,_that.reason,_that.unitPriceHalalas,_that.discountHalalas,_that.availableQuantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartValidationLine implements CartValidationLine {
  const _CartValidationLine({@JsonKey(name: 'branch_item_id') required this.branchItemId, this.quantity = 0, this.available = false, this.reason, @JsonKey(name: 'unit_price_halalas') this.unitPriceHalalas, @JsonKey(name: 'discount_halalas') this.discountHalalas, @JsonKey(name: 'available_quantity') this.availableQuantity});
  factory _CartValidationLine.fromJson(Map<String, dynamic> json) => _$CartValidationLineFromJson(json);

@override@JsonKey(name: 'branch_item_id') final  int branchItemId;
@override@JsonKey() final  double quantity;
@override@JsonKey() final  bool available;
@override final  String? reason;
@override@JsonKey(name: 'unit_price_halalas') final  int? unitPriceHalalas;
@override@JsonKey(name: 'discount_halalas') final  int? discountHalalas;
@override@JsonKey(name: 'available_quantity') final  double? availableQuantity;

/// Create a copy of CartValidationLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartValidationLineCopyWith<_CartValidationLine> get copyWith => __$CartValidationLineCopyWithImpl<_CartValidationLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartValidationLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartValidationLine&&(identical(other.branchItemId, branchItemId) || other.branchItemId == branchItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.available, available) || other.available == available)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.unitPriceHalalas, unitPriceHalalas) || other.unitPriceHalalas == unitPriceHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.availableQuantity, availableQuantity) || other.availableQuantity == availableQuantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchItemId,quantity,available,reason,unitPriceHalalas,discountHalalas,availableQuantity);

@override
String toString() {
  return 'CartValidationLine(branchItemId: $branchItemId, quantity: $quantity, available: $available, reason: $reason, unitPriceHalalas: $unitPriceHalalas, discountHalalas: $discountHalalas, availableQuantity: $availableQuantity)';
}


}

/// @nodoc
abstract mixin class _$CartValidationLineCopyWith<$Res> implements $CartValidationLineCopyWith<$Res> {
  factory _$CartValidationLineCopyWith(_CartValidationLine value, $Res Function(_CartValidationLine) _then) = __$CartValidationLineCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'branch_item_id') int branchItemId, double quantity, bool available, String? reason,@JsonKey(name: 'unit_price_halalas') int? unitPriceHalalas,@JsonKey(name: 'discount_halalas') int? discountHalalas,@JsonKey(name: 'available_quantity') double? availableQuantity
});




}
/// @nodoc
class __$CartValidationLineCopyWithImpl<$Res>
    implements _$CartValidationLineCopyWith<$Res> {
  __$CartValidationLineCopyWithImpl(this._self, this._then);

  final _CartValidationLine _self;
  final $Res Function(_CartValidationLine) _then;

/// Create a copy of CartValidationLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? branchItemId = null,Object? quantity = null,Object? available = null,Object? reason = freezed,Object? unitPriceHalalas = freezed,Object? discountHalalas = freezed,Object? availableQuantity = freezed,}) {
  return _then(_CartValidationLine(
branchItemId: null == branchItemId ? _self.branchItemId : branchItemId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,unitPriceHalalas: freezed == unitPriceHalalas ? _self.unitPriceHalalas : unitPriceHalalas // ignore: cast_nullable_to_non_nullable
as int?,discountHalalas: freezed == discountHalalas ? _self.discountHalalas : discountHalalas // ignore: cast_nullable_to_non_nullable
as int?,availableQuantity: freezed == availableQuantity ? _self.availableQuantity : availableQuantity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$CartValidationResult {

@JsonKey(name: 'branch_id') int? get branchId;@JsonKey(name: 'all_available') bool get allAvailable; List<CartValidationLine> get lines;
/// Create a copy of CartValidationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartValidationResultCopyWith<CartValidationResult> get copyWith => _$CartValidationResultCopyWithImpl<CartValidationResult>(this as CartValidationResult, _$identity);

  /// Serializes this CartValidationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartValidationResult&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.allAvailable, allAvailable) || other.allAvailable == allAvailable)&&const DeepCollectionEquality().equals(other.lines, lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchId,allAvailable,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'CartValidationResult(branchId: $branchId, allAvailable: $allAvailable, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $CartValidationResultCopyWith<$Res>  {
  factory $CartValidationResultCopyWith(CartValidationResult value, $Res Function(CartValidationResult) _then) = _$CartValidationResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'branch_id') int? branchId,@JsonKey(name: 'all_available') bool allAvailable, List<CartValidationLine> lines
});




}
/// @nodoc
class _$CartValidationResultCopyWithImpl<$Res>
    implements $CartValidationResultCopyWith<$Res> {
  _$CartValidationResultCopyWithImpl(this._self, this._then);

  final CartValidationResult _self;
  final $Res Function(CartValidationResult) _then;

/// Create a copy of CartValidationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? branchId = freezed,Object? allAvailable = null,Object? lines = null,}) {
  return _then(_self.copyWith(
branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,allAvailable: null == allAvailable ? _self.allAvailable : allAvailable // ignore: cast_nullable_to_non_nullable
as bool,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<CartValidationLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [CartValidationResult].
extension CartValidationResultPatterns on CartValidationResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartValidationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartValidationResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartValidationResult value)  $default,){
final _that = this;
switch (_that) {
case _CartValidationResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartValidationResult value)?  $default,){
final _that = this;
switch (_that) {
case _CartValidationResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'branch_id')  int? branchId, @JsonKey(name: 'all_available')  bool allAvailable,  List<CartValidationLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartValidationResult() when $default != null:
return $default(_that.branchId,_that.allAvailable,_that.lines);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'branch_id')  int? branchId, @JsonKey(name: 'all_available')  bool allAvailable,  List<CartValidationLine> lines)  $default,) {final _that = this;
switch (_that) {
case _CartValidationResult():
return $default(_that.branchId,_that.allAvailable,_that.lines);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'branch_id')  int? branchId, @JsonKey(name: 'all_available')  bool allAvailable,  List<CartValidationLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _CartValidationResult() when $default != null:
return $default(_that.branchId,_that.allAvailable,_that.lines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartValidationResult implements CartValidationResult {
  const _CartValidationResult({@JsonKey(name: 'branch_id') this.branchId, @JsonKey(name: 'all_available') this.allAvailable = false, final  List<CartValidationLine> lines = const <CartValidationLine>[]}): _lines = lines;
  factory _CartValidationResult.fromJson(Map<String, dynamic> json) => _$CartValidationResultFromJson(json);

@override@JsonKey(name: 'branch_id') final  int? branchId;
@override@JsonKey(name: 'all_available') final  bool allAvailable;
 final  List<CartValidationLine> _lines;
@override@JsonKey() List<CartValidationLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of CartValidationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartValidationResultCopyWith<_CartValidationResult> get copyWith => __$CartValidationResultCopyWithImpl<_CartValidationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartValidationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartValidationResult&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.allAvailable, allAvailable) || other.allAvailable == allAvailable)&&const DeepCollectionEquality().equals(other._lines, _lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchId,allAvailable,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'CartValidationResult(branchId: $branchId, allAvailable: $allAvailable, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$CartValidationResultCopyWith<$Res> implements $CartValidationResultCopyWith<$Res> {
  factory _$CartValidationResultCopyWith(_CartValidationResult value, $Res Function(_CartValidationResult) _then) = __$CartValidationResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'branch_id') int? branchId,@JsonKey(name: 'all_available') bool allAvailable, List<CartValidationLine> lines
});




}
/// @nodoc
class __$CartValidationResultCopyWithImpl<$Res>
    implements _$CartValidationResultCopyWith<$Res> {
  __$CartValidationResultCopyWithImpl(this._self, this._then);

  final _CartValidationResult _self;
  final $Res Function(_CartValidationResult) _then;

/// Create a copy of CartValidationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? branchId = freezed,Object? allAvailable = null,Object? lines = null,}) {
  return _then(_CartValidationResult(
branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,allAvailable: null == allAvailable ? _self.allAvailable : allAvailable // ignore: cast_nullable_to_non_nullable
as bool,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<CartValidationLine>,
  ));
}


}


/// @nodoc
mixin _$CheckoutTotals {

@JsonKey(name: 'subtotal_halalas') int get subtotalHalalas;@JsonKey(name: 'delivery_fee_halalas') int get deliveryFeeHalalas;@JsonKey(name: 'discount_halalas') int get discountHalalas;@JsonKey(name: 'vat_halalas') int get vatHalalas;@JsonKey(name: 'total_halalas') int get totalHalalas;
/// Create a copy of CheckoutTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutTotalsCopyWith<CheckoutTotals> get copyWith => _$CheckoutTotalsCopyWithImpl<CheckoutTotals>(this as CheckoutTotals, _$identity);

  /// Serializes this CheckoutTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutTotals&&(identical(other.subtotalHalalas, subtotalHalalas) || other.subtotalHalalas == subtotalHalalas)&&(identical(other.deliveryFeeHalalas, deliveryFeeHalalas) || other.deliveryFeeHalalas == deliveryFeeHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.vatHalalas, vatHalalas) || other.vatHalalas == vatHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subtotalHalalas,deliveryFeeHalalas,discountHalalas,vatHalalas,totalHalalas);

@override
String toString() {
  return 'CheckoutTotals(subtotalHalalas: $subtotalHalalas, deliveryFeeHalalas: $deliveryFeeHalalas, discountHalalas: $discountHalalas, vatHalalas: $vatHalalas, totalHalalas: $totalHalalas)';
}


}

/// @nodoc
abstract mixin class $CheckoutTotalsCopyWith<$Res>  {
  factory $CheckoutTotalsCopyWith(CheckoutTotals value, $Res Function(CheckoutTotals) _then) = _$CheckoutTotalsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'subtotal_halalas') int subtotalHalalas,@JsonKey(name: 'delivery_fee_halalas') int deliveryFeeHalalas,@JsonKey(name: 'discount_halalas') int discountHalalas,@JsonKey(name: 'vat_halalas') int vatHalalas,@JsonKey(name: 'total_halalas') int totalHalalas
});




}
/// @nodoc
class _$CheckoutTotalsCopyWithImpl<$Res>
    implements $CheckoutTotalsCopyWith<$Res> {
  _$CheckoutTotalsCopyWithImpl(this._self, this._then);

  final CheckoutTotals _self;
  final $Res Function(CheckoutTotals) _then;

/// Create a copy of CheckoutTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subtotalHalalas = null,Object? deliveryFeeHalalas = null,Object? discountHalalas = null,Object? vatHalalas = null,Object? totalHalalas = null,}) {
  return _then(_self.copyWith(
subtotalHalalas: null == subtotalHalalas ? _self.subtotalHalalas : subtotalHalalas // ignore: cast_nullable_to_non_nullable
as int,deliveryFeeHalalas: null == deliveryFeeHalalas ? _self.deliveryFeeHalalas : deliveryFeeHalalas // ignore: cast_nullable_to_non_nullable
as int,discountHalalas: null == discountHalalas ? _self.discountHalalas : discountHalalas // ignore: cast_nullable_to_non_nullable
as int,vatHalalas: null == vatHalalas ? _self.vatHalalas : vatHalalas // ignore: cast_nullable_to_non_nullable
as int,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutTotals].
extension CheckoutTotalsPatterns on CheckoutTotals {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutTotals() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutTotals value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutTotals():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutTotals value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutTotals() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'subtotal_halalas')  int subtotalHalalas, @JsonKey(name: 'delivery_fee_halalas')  int deliveryFeeHalalas, @JsonKey(name: 'discount_halalas')  int discountHalalas, @JsonKey(name: 'vat_halalas')  int vatHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutTotals() when $default != null:
return $default(_that.subtotalHalalas,_that.deliveryFeeHalalas,_that.discountHalalas,_that.vatHalalas,_that.totalHalalas);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'subtotal_halalas')  int subtotalHalalas, @JsonKey(name: 'delivery_fee_halalas')  int deliveryFeeHalalas, @JsonKey(name: 'discount_halalas')  int discountHalalas, @JsonKey(name: 'vat_halalas')  int vatHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas)  $default,) {final _that = this;
switch (_that) {
case _CheckoutTotals():
return $default(_that.subtotalHalalas,_that.deliveryFeeHalalas,_that.discountHalalas,_that.vatHalalas,_that.totalHalalas);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'subtotal_halalas')  int subtotalHalalas, @JsonKey(name: 'delivery_fee_halalas')  int deliveryFeeHalalas, @JsonKey(name: 'discount_halalas')  int discountHalalas, @JsonKey(name: 'vat_halalas')  int vatHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutTotals() when $default != null:
return $default(_that.subtotalHalalas,_that.deliveryFeeHalalas,_that.discountHalalas,_that.vatHalalas,_that.totalHalalas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutTotals implements CheckoutTotals {
  const _CheckoutTotals({@JsonKey(name: 'subtotal_halalas') this.subtotalHalalas = 0, @JsonKey(name: 'delivery_fee_halalas') this.deliveryFeeHalalas = 0, @JsonKey(name: 'discount_halalas') this.discountHalalas = 0, @JsonKey(name: 'vat_halalas') this.vatHalalas = 0, @JsonKey(name: 'total_halalas') this.totalHalalas = 0});
  factory _CheckoutTotals.fromJson(Map<String, dynamic> json) => _$CheckoutTotalsFromJson(json);

@override@JsonKey(name: 'subtotal_halalas') final  int subtotalHalalas;
@override@JsonKey(name: 'delivery_fee_halalas') final  int deliveryFeeHalalas;
@override@JsonKey(name: 'discount_halalas') final  int discountHalalas;
@override@JsonKey(name: 'vat_halalas') final  int vatHalalas;
@override@JsonKey(name: 'total_halalas') final  int totalHalalas;

/// Create a copy of CheckoutTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutTotalsCopyWith<_CheckoutTotals> get copyWith => __$CheckoutTotalsCopyWithImpl<_CheckoutTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutTotals&&(identical(other.subtotalHalalas, subtotalHalalas) || other.subtotalHalalas == subtotalHalalas)&&(identical(other.deliveryFeeHalalas, deliveryFeeHalalas) || other.deliveryFeeHalalas == deliveryFeeHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.vatHalalas, vatHalalas) || other.vatHalalas == vatHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subtotalHalalas,deliveryFeeHalalas,discountHalalas,vatHalalas,totalHalalas);

@override
String toString() {
  return 'CheckoutTotals(subtotalHalalas: $subtotalHalalas, deliveryFeeHalalas: $deliveryFeeHalalas, discountHalalas: $discountHalalas, vatHalalas: $vatHalalas, totalHalalas: $totalHalalas)';
}


}

/// @nodoc
abstract mixin class _$CheckoutTotalsCopyWith<$Res> implements $CheckoutTotalsCopyWith<$Res> {
  factory _$CheckoutTotalsCopyWith(_CheckoutTotals value, $Res Function(_CheckoutTotals) _then) = __$CheckoutTotalsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'subtotal_halalas') int subtotalHalalas,@JsonKey(name: 'delivery_fee_halalas') int deliveryFeeHalalas,@JsonKey(name: 'discount_halalas') int discountHalalas,@JsonKey(name: 'vat_halalas') int vatHalalas,@JsonKey(name: 'total_halalas') int totalHalalas
});




}
/// @nodoc
class __$CheckoutTotalsCopyWithImpl<$Res>
    implements _$CheckoutTotalsCopyWith<$Res> {
  __$CheckoutTotalsCopyWithImpl(this._self, this._then);

  final _CheckoutTotals _self;
  final $Res Function(_CheckoutTotals) _then;

/// Create a copy of CheckoutTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subtotalHalalas = null,Object? deliveryFeeHalalas = null,Object? discountHalalas = null,Object? vatHalalas = null,Object? totalHalalas = null,}) {
  return _then(_CheckoutTotals(
subtotalHalalas: null == subtotalHalalas ? _self.subtotalHalalas : subtotalHalalas // ignore: cast_nullable_to_non_nullable
as int,deliveryFeeHalalas: null == deliveryFeeHalalas ? _self.deliveryFeeHalalas : deliveryFeeHalalas // ignore: cast_nullable_to_non_nullable
as int,discountHalalas: null == discountHalalas ? _self.discountHalalas : discountHalalas // ignore: cast_nullable_to_non_nullable
as int,vatHalalas: null == vatHalalas ? _self.vatHalalas : vatHalalas // ignore: cast_nullable_to_non_nullable
as int,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CheckoutQuote {

@JsonKey(name: 'branch_id') int? get branchId; CheckoutTotals get totals;@JsonKey(name: 'all_available') bool get allAvailable;
/// Create a copy of CheckoutQuote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutQuoteCopyWith<CheckoutQuote> get copyWith => _$CheckoutQuoteCopyWithImpl<CheckoutQuote>(this as CheckoutQuote, _$identity);

  /// Serializes this CheckoutQuote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutQuote&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.allAvailable, allAvailable) || other.allAvailable == allAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchId,totals,allAvailable);

@override
String toString() {
  return 'CheckoutQuote(branchId: $branchId, totals: $totals, allAvailable: $allAvailable)';
}


}

/// @nodoc
abstract mixin class $CheckoutQuoteCopyWith<$Res>  {
  factory $CheckoutQuoteCopyWith(CheckoutQuote value, $Res Function(CheckoutQuote) _then) = _$CheckoutQuoteCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'branch_id') int? branchId, CheckoutTotals totals,@JsonKey(name: 'all_available') bool allAvailable
});


$CheckoutTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class _$CheckoutQuoteCopyWithImpl<$Res>
    implements $CheckoutQuoteCopyWith<$Res> {
  _$CheckoutQuoteCopyWithImpl(this._self, this._then);

  final CheckoutQuote _self;
  final $Res Function(CheckoutQuote) _then;

/// Create a copy of CheckoutQuote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? branchId = freezed,Object? totals = null,Object? allAvailable = null,}) {
  return _then(_self.copyWith(
branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as CheckoutTotals,allAvailable: null == allAvailable ? _self.allAvailable : allAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CheckoutQuote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckoutTotalsCopyWith<$Res> get totals {
  
  return $CheckoutTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckoutQuote].
extension CheckoutQuotePatterns on CheckoutQuote {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutQuote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutQuote() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutQuote value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutQuote():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutQuote value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutQuote() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'branch_id')  int? branchId,  CheckoutTotals totals, @JsonKey(name: 'all_available')  bool allAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutQuote() when $default != null:
return $default(_that.branchId,_that.totals,_that.allAvailable);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'branch_id')  int? branchId,  CheckoutTotals totals, @JsonKey(name: 'all_available')  bool allAvailable)  $default,) {final _that = this;
switch (_that) {
case _CheckoutQuote():
return $default(_that.branchId,_that.totals,_that.allAvailable);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'branch_id')  int? branchId,  CheckoutTotals totals, @JsonKey(name: 'all_available')  bool allAvailable)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutQuote() when $default != null:
return $default(_that.branchId,_that.totals,_that.allAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutQuote implements CheckoutQuote {
  const _CheckoutQuote({@JsonKey(name: 'branch_id') this.branchId, this.totals = const CheckoutTotals(), @JsonKey(name: 'all_available') this.allAvailable = false});
  factory _CheckoutQuote.fromJson(Map<String, dynamic> json) => _$CheckoutQuoteFromJson(json);

@override@JsonKey(name: 'branch_id') final  int? branchId;
@override@JsonKey() final  CheckoutTotals totals;
@override@JsonKey(name: 'all_available') final  bool allAvailable;

/// Create a copy of CheckoutQuote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutQuoteCopyWith<_CheckoutQuote> get copyWith => __$CheckoutQuoteCopyWithImpl<_CheckoutQuote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutQuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutQuote&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.allAvailable, allAvailable) || other.allAvailable == allAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchId,totals,allAvailable);

@override
String toString() {
  return 'CheckoutQuote(branchId: $branchId, totals: $totals, allAvailable: $allAvailable)';
}


}

/// @nodoc
abstract mixin class _$CheckoutQuoteCopyWith<$Res> implements $CheckoutQuoteCopyWith<$Res> {
  factory _$CheckoutQuoteCopyWith(_CheckoutQuote value, $Res Function(_CheckoutQuote) _then) = __$CheckoutQuoteCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'branch_id') int? branchId, CheckoutTotals totals,@JsonKey(name: 'all_available') bool allAvailable
});


@override $CheckoutTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class __$CheckoutQuoteCopyWithImpl<$Res>
    implements _$CheckoutQuoteCopyWith<$Res> {
  __$CheckoutQuoteCopyWithImpl(this._self, this._then);

  final _CheckoutQuote _self;
  final $Res Function(_CheckoutQuote) _then;

/// Create a copy of CheckoutQuote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? branchId = freezed,Object? totals = null,Object? allAvailable = null,}) {
  return _then(_CheckoutQuote(
branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as CheckoutTotals,allAvailable: null == allAvailable ? _self.allAvailable : allAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CheckoutQuote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckoutTotalsCopyWith<$Res> get totals {
  
  return $CheckoutTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}

// dart format on
