// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomerProfile {

 int get id;@JsonKey(name: 'customer_number') String get customerNumber; String? get name; String get phone;@JsonKey(name: 'preferred_locale') String? get preferredLocale;
/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerProfileCopyWith<CustomerProfile> get copyWith => _$CustomerProfileCopyWithImpl<CustomerProfile>(this as CustomerProfile, _$identity);

  /// Serializes this CustomerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.customerNumber, customerNumber) || other.customerNumber == customerNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.preferredLocale, preferredLocale) || other.preferredLocale == preferredLocale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerNumber,name,phone,preferredLocale);

@override
String toString() {
  return 'CustomerProfile(id: $id, customerNumber: $customerNumber, name: $name, phone: $phone, preferredLocale: $preferredLocale)';
}


}

/// @nodoc
abstract mixin class $CustomerProfileCopyWith<$Res>  {
  factory $CustomerProfileCopyWith(CustomerProfile value, $Res Function(CustomerProfile) _then) = _$CustomerProfileCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'customer_number') String customerNumber, String? name, String phone,@JsonKey(name: 'preferred_locale') String? preferredLocale
});




}
/// @nodoc
class _$CustomerProfileCopyWithImpl<$Res>
    implements $CustomerProfileCopyWith<$Res> {
  _$CustomerProfileCopyWithImpl(this._self, this._then);

  final CustomerProfile _self;
  final $Res Function(CustomerProfile) _then;

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerNumber = null,Object? name = freezed,Object? phone = null,Object? preferredLocale = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,customerNumber: null == customerNumber ? _self.customerNumber : customerNumber // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,preferredLocale: freezed == preferredLocale ? _self.preferredLocale : preferredLocale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerProfile].
extension CustomerProfilePatterns on CustomerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerProfile value)  $default,){
final _that = this;
switch (_that) {
case _CustomerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'customer_number')  String customerNumber,  String? name,  String phone, @JsonKey(name: 'preferred_locale')  String? preferredLocale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
return $default(_that.id,_that.customerNumber,_that.name,_that.phone,_that.preferredLocale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'customer_number')  String customerNumber,  String? name,  String phone, @JsonKey(name: 'preferred_locale')  String? preferredLocale)  $default,) {final _that = this;
switch (_that) {
case _CustomerProfile():
return $default(_that.id,_that.customerNumber,_that.name,_that.phone,_that.preferredLocale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'customer_number')  String customerNumber,  String? name,  String phone, @JsonKey(name: 'preferred_locale')  String? preferredLocale)?  $default,) {final _that = this;
switch (_that) {
case _CustomerProfile() when $default != null:
return $default(_that.id,_that.customerNumber,_that.name,_that.phone,_that.preferredLocale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerProfile implements CustomerProfile {
  const _CustomerProfile({required this.id, @JsonKey(name: 'customer_number') required this.customerNumber, this.name, required this.phone, @JsonKey(name: 'preferred_locale') this.preferredLocale});
  factory _CustomerProfile.fromJson(Map<String, dynamic> json) => _$CustomerProfileFromJson(json);

@override final  int id;
@override@JsonKey(name: 'customer_number') final  String customerNumber;
@override final  String? name;
@override final  String phone;
@override@JsonKey(name: 'preferred_locale') final  String? preferredLocale;

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerProfileCopyWith<_CustomerProfile> get copyWith => __$CustomerProfileCopyWithImpl<_CustomerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.customerNumber, customerNumber) || other.customerNumber == customerNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.preferredLocale, preferredLocale) || other.preferredLocale == preferredLocale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerNumber,name,phone,preferredLocale);

@override
String toString() {
  return 'CustomerProfile(id: $id, customerNumber: $customerNumber, name: $name, phone: $phone, preferredLocale: $preferredLocale)';
}


}

/// @nodoc
abstract mixin class _$CustomerProfileCopyWith<$Res> implements $CustomerProfileCopyWith<$Res> {
  factory _$CustomerProfileCopyWith(_CustomerProfile value, $Res Function(_CustomerProfile) _then) = __$CustomerProfileCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'customer_number') String customerNumber, String? name, String phone,@JsonKey(name: 'preferred_locale') String? preferredLocale
});




}
/// @nodoc
class __$CustomerProfileCopyWithImpl<$Res>
    implements _$CustomerProfileCopyWith<$Res> {
  __$CustomerProfileCopyWithImpl(this._self, this._then);

  final _CustomerProfile _self;
  final $Res Function(_CustomerProfile) _then;

/// Create a copy of CustomerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerNumber = null,Object? name = freezed,Object? phone = null,Object? preferredLocale = freezed,}) {
  return _then(_CustomerProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,customerNumber: null == customerNumber ? _self.customerNumber : customerNumber // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,preferredLocale: freezed == preferredLocale ? _self.preferredLocale : preferredLocale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CustomerOrderItem {

 int get id;@JsonKey(name: 'branch_item_id') int? get branchItemId;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn;@JsonKey(name: 'image_url') String? get imageUrl; int get quantity;@JsonKey(name: 'unit_price_halalas') int get unitPriceHalalas;@JsonKey(name: 'total_halalas') int get totalHalalas; bool get removed;
/// Create a copy of CustomerOrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerOrderItemCopyWith<CustomerOrderItem> get copyWith => _$CustomerOrderItemCopyWithImpl<CustomerOrderItem>(this as CustomerOrderItem, _$identity);

  /// Serializes this CustomerOrderItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.branchItemId, branchItemId) || other.branchItemId == branchItemId)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPriceHalalas, unitPriceHalalas) || other.unitPriceHalalas == unitPriceHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas)&&(identical(other.removed, removed) || other.removed == removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchItemId,nameAr,nameEn,imageUrl,quantity,unitPriceHalalas,totalHalalas,removed);

@override
String toString() {
  return 'CustomerOrderItem(id: $id, branchItemId: $branchItemId, nameAr: $nameAr, nameEn: $nameEn, imageUrl: $imageUrl, quantity: $quantity, unitPriceHalalas: $unitPriceHalalas, totalHalalas: $totalHalalas, removed: $removed)';
}


}

/// @nodoc
abstract mixin class $CustomerOrderItemCopyWith<$Res>  {
  factory $CustomerOrderItemCopyWith(CustomerOrderItem value, $Res Function(CustomerOrderItem) _then) = _$CustomerOrderItemCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'branch_item_id') int? branchItemId,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'image_url') String? imageUrl, int quantity,@JsonKey(name: 'unit_price_halalas') int unitPriceHalalas,@JsonKey(name: 'total_halalas') int totalHalalas, bool removed
});




}
/// @nodoc
class _$CustomerOrderItemCopyWithImpl<$Res>
    implements $CustomerOrderItemCopyWith<$Res> {
  _$CustomerOrderItemCopyWithImpl(this._self, this._then);

  final CustomerOrderItem _self;
  final $Res Function(CustomerOrderItem) _then;

/// Create a copy of CustomerOrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchItemId = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? imageUrl = freezed,Object? quantity = null,Object? unitPriceHalalas = null,Object? totalHalalas = null,Object? removed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,branchItemId: freezed == branchItemId ? _self.branchItemId : branchItemId // ignore: cast_nullable_to_non_nullable
as int?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPriceHalalas: null == unitPriceHalalas ? _self.unitPriceHalalas : unitPriceHalalas // ignore: cast_nullable_to_non_nullable
as int,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerOrderItem].
extension CustomerOrderItemPatterns on CustomerOrderItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerOrderItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerOrderItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerOrderItem value)  $default,){
final _that = this;
switch (_that) {
case _CustomerOrderItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerOrderItem value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerOrderItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'branch_item_id')  int? branchItemId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl,  int quantity, @JsonKey(name: 'unit_price_halalas')  int unitPriceHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas,  bool removed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerOrderItem() when $default != null:
return $default(_that.id,_that.branchItemId,_that.nameAr,_that.nameEn,_that.imageUrl,_that.quantity,_that.unitPriceHalalas,_that.totalHalalas,_that.removed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'branch_item_id')  int? branchItemId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl,  int quantity, @JsonKey(name: 'unit_price_halalas')  int unitPriceHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas,  bool removed)  $default,) {final _that = this;
switch (_that) {
case _CustomerOrderItem():
return $default(_that.id,_that.branchItemId,_that.nameAr,_that.nameEn,_that.imageUrl,_that.quantity,_that.unitPriceHalalas,_that.totalHalalas,_that.removed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'branch_item_id')  int? branchItemId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl,  int quantity, @JsonKey(name: 'unit_price_halalas')  int unitPriceHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas,  bool removed)?  $default,) {final _that = this;
switch (_that) {
case _CustomerOrderItem() when $default != null:
return $default(_that.id,_that.branchItemId,_that.nameAr,_that.nameEn,_that.imageUrl,_that.quantity,_that.unitPriceHalalas,_that.totalHalalas,_that.removed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerOrderItem extends CustomerOrderItem {
  const _CustomerOrderItem({required this.id, @JsonKey(name: 'branch_item_id') this.branchItemId, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, @JsonKey(name: 'image_url') this.imageUrl, this.quantity = 1, @JsonKey(name: 'unit_price_halalas') this.unitPriceHalalas = 0, @JsonKey(name: 'total_halalas') this.totalHalalas = 0, this.removed = false}): super._();
  factory _CustomerOrderItem.fromJson(Map<String, dynamic> json) => _$CustomerOrderItemFromJson(json);

@override final  int id;
@override@JsonKey(name: 'branch_item_id') final  int? branchItemId;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey() final  int quantity;
@override@JsonKey(name: 'unit_price_halalas') final  int unitPriceHalalas;
@override@JsonKey(name: 'total_halalas') final  int totalHalalas;
@override@JsonKey() final  bool removed;

/// Create a copy of CustomerOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerOrderItemCopyWith<_CustomerOrderItem> get copyWith => __$CustomerOrderItemCopyWithImpl<_CustomerOrderItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerOrderItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerOrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.branchItemId, branchItemId) || other.branchItemId == branchItemId)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPriceHalalas, unitPriceHalalas) || other.unitPriceHalalas == unitPriceHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas)&&(identical(other.removed, removed) || other.removed == removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchItemId,nameAr,nameEn,imageUrl,quantity,unitPriceHalalas,totalHalalas,removed);

@override
String toString() {
  return 'CustomerOrderItem(id: $id, branchItemId: $branchItemId, nameAr: $nameAr, nameEn: $nameEn, imageUrl: $imageUrl, quantity: $quantity, unitPriceHalalas: $unitPriceHalalas, totalHalalas: $totalHalalas, removed: $removed)';
}


}

/// @nodoc
abstract mixin class _$CustomerOrderItemCopyWith<$Res> implements $CustomerOrderItemCopyWith<$Res> {
  factory _$CustomerOrderItemCopyWith(_CustomerOrderItem value, $Res Function(_CustomerOrderItem) _then) = __$CustomerOrderItemCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'branch_item_id') int? branchItemId,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'image_url') String? imageUrl, int quantity,@JsonKey(name: 'unit_price_halalas') int unitPriceHalalas,@JsonKey(name: 'total_halalas') int totalHalalas, bool removed
});




}
/// @nodoc
class __$CustomerOrderItemCopyWithImpl<$Res>
    implements _$CustomerOrderItemCopyWith<$Res> {
  __$CustomerOrderItemCopyWithImpl(this._self, this._then);

  final _CustomerOrderItem _self;
  final $Res Function(_CustomerOrderItem) _then;

/// Create a copy of CustomerOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchItemId = freezed,Object? nameAr = freezed,Object? nameEn = freezed,Object? imageUrl = freezed,Object? quantity = null,Object? unitPriceHalalas = null,Object? totalHalalas = null,Object? removed = null,}) {
  return _then(_CustomerOrderItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,branchItemId: freezed == branchItemId ? _self.branchItemId : branchItemId // ignore: cast_nullable_to_non_nullable
as int?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPriceHalalas: null == unitPriceHalalas ? _self.unitPriceHalalas : unitPriceHalalas // ignore: cast_nullable_to_non_nullable
as int,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CustomerOrderTotals {

@JsonKey(name: 'subtotal_halalas') int get subtotalHalalas;@JsonKey(name: 'delivery_fee_halalas') int get deliveryFeeHalalas;@JsonKey(name: 'discount_halalas') int get discountHalalas;@JsonKey(name: 'vat_halalas') int get vatHalalas;@JsonKey(name: 'total_halalas') int get totalHalalas;
/// Create a copy of CustomerOrderTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerOrderTotalsCopyWith<CustomerOrderTotals> get copyWith => _$CustomerOrderTotalsCopyWithImpl<CustomerOrderTotals>(this as CustomerOrderTotals, _$identity);

  /// Serializes this CustomerOrderTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrderTotals&&(identical(other.subtotalHalalas, subtotalHalalas) || other.subtotalHalalas == subtotalHalalas)&&(identical(other.deliveryFeeHalalas, deliveryFeeHalalas) || other.deliveryFeeHalalas == deliveryFeeHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.vatHalalas, vatHalalas) || other.vatHalalas == vatHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subtotalHalalas,deliveryFeeHalalas,discountHalalas,vatHalalas,totalHalalas);

@override
String toString() {
  return 'CustomerOrderTotals(subtotalHalalas: $subtotalHalalas, deliveryFeeHalalas: $deliveryFeeHalalas, discountHalalas: $discountHalalas, vatHalalas: $vatHalalas, totalHalalas: $totalHalalas)';
}


}

/// @nodoc
abstract mixin class $CustomerOrderTotalsCopyWith<$Res>  {
  factory $CustomerOrderTotalsCopyWith(CustomerOrderTotals value, $Res Function(CustomerOrderTotals) _then) = _$CustomerOrderTotalsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'subtotal_halalas') int subtotalHalalas,@JsonKey(name: 'delivery_fee_halalas') int deliveryFeeHalalas,@JsonKey(name: 'discount_halalas') int discountHalalas,@JsonKey(name: 'vat_halalas') int vatHalalas,@JsonKey(name: 'total_halalas') int totalHalalas
});




}
/// @nodoc
class _$CustomerOrderTotalsCopyWithImpl<$Res>
    implements $CustomerOrderTotalsCopyWith<$Res> {
  _$CustomerOrderTotalsCopyWithImpl(this._self, this._then);

  final CustomerOrderTotals _self;
  final $Res Function(CustomerOrderTotals) _then;

/// Create a copy of CustomerOrderTotals
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


/// Adds pattern-matching-related methods to [CustomerOrderTotals].
extension CustomerOrderTotalsPatterns on CustomerOrderTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerOrderTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerOrderTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerOrderTotals value)  $default,){
final _that = this;
switch (_that) {
case _CustomerOrderTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerOrderTotals value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerOrderTotals() when $default != null:
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
case _CustomerOrderTotals() when $default != null:
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
case _CustomerOrderTotals():
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
case _CustomerOrderTotals() when $default != null:
return $default(_that.subtotalHalalas,_that.deliveryFeeHalalas,_that.discountHalalas,_that.vatHalalas,_that.totalHalalas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerOrderTotals implements CustomerOrderTotals {
  const _CustomerOrderTotals({@JsonKey(name: 'subtotal_halalas') this.subtotalHalalas = 0, @JsonKey(name: 'delivery_fee_halalas') this.deliveryFeeHalalas = 0, @JsonKey(name: 'discount_halalas') this.discountHalalas = 0, @JsonKey(name: 'vat_halalas') this.vatHalalas = 0, @JsonKey(name: 'total_halalas') this.totalHalalas = 0});
  factory _CustomerOrderTotals.fromJson(Map<String, dynamic> json) => _$CustomerOrderTotalsFromJson(json);

@override@JsonKey(name: 'subtotal_halalas') final  int subtotalHalalas;
@override@JsonKey(name: 'delivery_fee_halalas') final  int deliveryFeeHalalas;
@override@JsonKey(name: 'discount_halalas') final  int discountHalalas;
@override@JsonKey(name: 'vat_halalas') final  int vatHalalas;
@override@JsonKey(name: 'total_halalas') final  int totalHalalas;

/// Create a copy of CustomerOrderTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerOrderTotalsCopyWith<_CustomerOrderTotals> get copyWith => __$CustomerOrderTotalsCopyWithImpl<_CustomerOrderTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerOrderTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerOrderTotals&&(identical(other.subtotalHalalas, subtotalHalalas) || other.subtotalHalalas == subtotalHalalas)&&(identical(other.deliveryFeeHalalas, deliveryFeeHalalas) || other.deliveryFeeHalalas == deliveryFeeHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.vatHalalas, vatHalalas) || other.vatHalalas == vatHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subtotalHalalas,deliveryFeeHalalas,discountHalalas,vatHalalas,totalHalalas);

@override
String toString() {
  return 'CustomerOrderTotals(subtotalHalalas: $subtotalHalalas, deliveryFeeHalalas: $deliveryFeeHalalas, discountHalalas: $discountHalalas, vatHalalas: $vatHalalas, totalHalalas: $totalHalalas)';
}


}

/// @nodoc
abstract mixin class _$CustomerOrderTotalsCopyWith<$Res> implements $CustomerOrderTotalsCopyWith<$Res> {
  factory _$CustomerOrderTotalsCopyWith(_CustomerOrderTotals value, $Res Function(_CustomerOrderTotals) _then) = __$CustomerOrderTotalsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'subtotal_halalas') int subtotalHalalas,@JsonKey(name: 'delivery_fee_halalas') int deliveryFeeHalalas,@JsonKey(name: 'discount_halalas') int discountHalalas,@JsonKey(name: 'vat_halalas') int vatHalalas,@JsonKey(name: 'total_halalas') int totalHalalas
});




}
/// @nodoc
class __$CustomerOrderTotalsCopyWithImpl<$Res>
    implements _$CustomerOrderTotalsCopyWith<$Res> {
  __$CustomerOrderTotalsCopyWithImpl(this._self, this._then);

  final _CustomerOrderTotals _self;
  final $Res Function(_CustomerOrderTotals) _then;

/// Create a copy of CustomerOrderTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subtotalHalalas = null,Object? deliveryFeeHalalas = null,Object? discountHalalas = null,Object? vatHalalas = null,Object? totalHalalas = null,}) {
  return _then(_CustomerOrderTotals(
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
mixin _$CustomerOrder {

 int get id;@JsonKey(name: 'order_number') String get orderNumber; String get state;/// The exact status in the customer's words. The timeline collapses
/// several states into one node; this always names the current one.
@JsonKey(name: 'state_label') String? get stateLabel;@JsonKey(name: 'items_count') int? get itemsCount; List<CustomerOrderItem>? get items; Map<String, dynamic>? get address; CustomerOrderTotals? get totals;@JsonKey(name: 'total_halalas') int? get totalHalalas;@JsonKey(name: 'failure_reason') String? get failureReason;@JsonKey(name: 'failure_note') String? get failureNote;@JsonKey(name: 'can_rate') bool get canRate;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerOrderCopyWith<CustomerOrder> get copyWith => _$CustomerOrderCopyWithImpl<CustomerOrder>(this as CustomerOrder, _$identity);

  /// Serializes this CustomerOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.state, state) || other.state == state)&&(identical(other.stateLabel, stateLabel) || other.stateLabel == stateLabel)&&(identical(other.itemsCount, itemsCount) || other.itemsCount == itemsCount)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.address, address)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.failureNote, failureNote) || other.failureNote == failureNote)&&(identical(other.canRate, canRate) || other.canRate == canRate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,state,stateLabel,itemsCount,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(address),totals,totalHalalas,failureReason,failureNote,canRate,createdAt);

@override
String toString() {
  return 'CustomerOrder(id: $id, orderNumber: $orderNumber, state: $state, stateLabel: $stateLabel, itemsCount: $itemsCount, items: $items, address: $address, totals: $totals, totalHalalas: $totalHalalas, failureReason: $failureReason, failureNote: $failureNote, canRate: $canRate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CustomerOrderCopyWith<$Res>  {
  factory $CustomerOrderCopyWith(CustomerOrder value, $Res Function(CustomerOrder) _then) = _$CustomerOrderCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'order_number') String orderNumber, String state,@JsonKey(name: 'state_label') String? stateLabel,@JsonKey(name: 'items_count') int? itemsCount, List<CustomerOrderItem>? items, Map<String, dynamic>? address, CustomerOrderTotals? totals,@JsonKey(name: 'total_halalas') int? totalHalalas,@JsonKey(name: 'failure_reason') String? failureReason,@JsonKey(name: 'failure_note') String? failureNote,@JsonKey(name: 'can_rate') bool canRate,@JsonKey(name: 'created_at') DateTime? createdAt
});


$CustomerOrderTotalsCopyWith<$Res>? get totals;

}
/// @nodoc
class _$CustomerOrderCopyWithImpl<$Res>
    implements $CustomerOrderCopyWith<$Res> {
  _$CustomerOrderCopyWithImpl(this._self, this._then);

  final CustomerOrder _self;
  final $Res Function(CustomerOrder) _then;

/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? state = null,Object? stateLabel = freezed,Object? itemsCount = freezed,Object? items = freezed,Object? address = freezed,Object? totals = freezed,Object? totalHalalas = freezed,Object? failureReason = freezed,Object? failureNote = freezed,Object? canRate = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,stateLabel: freezed == stateLabel ? _self.stateLabel : stateLabel // ignore: cast_nullable_to_non_nullable
as String?,itemsCount: freezed == itemsCount ? _self.itemsCount : itemsCount // ignore: cast_nullable_to_non_nullable
as int?,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CustomerOrderItem>?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,totals: freezed == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as CustomerOrderTotals?,totalHalalas: freezed == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,failureNote: freezed == failureNote ? _self.failureNote : failureNote // ignore: cast_nullable_to_non_nullable
as String?,canRate: null == canRate ? _self.canRate : canRate // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerOrderTotalsCopyWith<$Res>? get totals {
    if (_self.totals == null) {
    return null;
  }

  return $CustomerOrderTotalsCopyWith<$Res>(_self.totals!, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerOrder].
extension CustomerOrderPatterns on CustomerOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerOrder value)  $default,){
final _that = this;
switch (_that) {
case _CustomerOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerOrder value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_number')  String orderNumber,  String state, @JsonKey(name: 'state_label')  String? stateLabel, @JsonKey(name: 'items_count')  int? itemsCount,  List<CustomerOrderItem>? items,  Map<String, dynamic>? address,  CustomerOrderTotals? totals, @JsonKey(name: 'total_halalas')  int? totalHalalas, @JsonKey(name: 'failure_reason')  String? failureReason, @JsonKey(name: 'failure_note')  String? failureNote, @JsonKey(name: 'can_rate')  bool canRate, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerOrder() when $default != null:
return $default(_that.id,_that.orderNumber,_that.state,_that.stateLabel,_that.itemsCount,_that.items,_that.address,_that.totals,_that.totalHalalas,_that.failureReason,_that.failureNote,_that.canRate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_number')  String orderNumber,  String state, @JsonKey(name: 'state_label')  String? stateLabel, @JsonKey(name: 'items_count')  int? itemsCount,  List<CustomerOrderItem>? items,  Map<String, dynamic>? address,  CustomerOrderTotals? totals, @JsonKey(name: 'total_halalas')  int? totalHalalas, @JsonKey(name: 'failure_reason')  String? failureReason, @JsonKey(name: 'failure_note')  String? failureNote, @JsonKey(name: 'can_rate')  bool canRate, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CustomerOrder():
return $default(_that.id,_that.orderNumber,_that.state,_that.stateLabel,_that.itemsCount,_that.items,_that.address,_that.totals,_that.totalHalalas,_that.failureReason,_that.failureNote,_that.canRate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'order_number')  String orderNumber,  String state, @JsonKey(name: 'state_label')  String? stateLabel, @JsonKey(name: 'items_count')  int? itemsCount,  List<CustomerOrderItem>? items,  Map<String, dynamic>? address,  CustomerOrderTotals? totals, @JsonKey(name: 'total_halalas')  int? totalHalalas, @JsonKey(name: 'failure_reason')  String? failureReason, @JsonKey(name: 'failure_note')  String? failureNote, @JsonKey(name: 'can_rate')  bool canRate, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CustomerOrder() when $default != null:
return $default(_that.id,_that.orderNumber,_that.state,_that.stateLabel,_that.itemsCount,_that.items,_that.address,_that.totals,_that.totalHalalas,_that.failureReason,_that.failureNote,_that.canRate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerOrder extends CustomerOrder {
  const _CustomerOrder({required this.id, @JsonKey(name: 'order_number') required this.orderNumber, required this.state, @JsonKey(name: 'state_label') this.stateLabel, @JsonKey(name: 'items_count') this.itemsCount, final  List<CustomerOrderItem>? items, final  Map<String, dynamic>? address, this.totals, @JsonKey(name: 'total_halalas') this.totalHalalas, @JsonKey(name: 'failure_reason') this.failureReason, @JsonKey(name: 'failure_note') this.failureNote, @JsonKey(name: 'can_rate') this.canRate = false, @JsonKey(name: 'created_at') this.createdAt}): _items = items,_address = address,super._();
  factory _CustomerOrder.fromJson(Map<String, dynamic> json) => _$CustomerOrderFromJson(json);

@override final  int id;
@override@JsonKey(name: 'order_number') final  String orderNumber;
@override final  String state;
/// The exact status in the customer's words. The timeline collapses
/// several states into one node; this always names the current one.
@override@JsonKey(name: 'state_label') final  String? stateLabel;
@override@JsonKey(name: 'items_count') final  int? itemsCount;
 final  List<CustomerOrderItem>? _items;
@override List<CustomerOrderItem>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _address;
@override Map<String, dynamic>? get address {
  final value = _address;
  if (value == null) return null;
  if (_address is EqualUnmodifiableMapView) return _address;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  CustomerOrderTotals? totals;
@override@JsonKey(name: 'total_halalas') final  int? totalHalalas;
@override@JsonKey(name: 'failure_reason') final  String? failureReason;
@override@JsonKey(name: 'failure_note') final  String? failureNote;
@override@JsonKey(name: 'can_rate') final  bool canRate;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerOrderCopyWith<_CustomerOrder> get copyWith => __$CustomerOrderCopyWithImpl<_CustomerOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.state, state) || other.state == state)&&(identical(other.stateLabel, stateLabel) || other.stateLabel == stateLabel)&&(identical(other.itemsCount, itemsCount) || other.itemsCount == itemsCount)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._address, _address)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.failureNote, failureNote) || other.failureNote == failureNote)&&(identical(other.canRate, canRate) || other.canRate == canRate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,state,stateLabel,itemsCount,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_address),totals,totalHalalas,failureReason,failureNote,canRate,createdAt);

@override
String toString() {
  return 'CustomerOrder(id: $id, orderNumber: $orderNumber, state: $state, stateLabel: $stateLabel, itemsCount: $itemsCount, items: $items, address: $address, totals: $totals, totalHalalas: $totalHalalas, failureReason: $failureReason, failureNote: $failureNote, canRate: $canRate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerOrderCopyWith<$Res> implements $CustomerOrderCopyWith<$Res> {
  factory _$CustomerOrderCopyWith(_CustomerOrder value, $Res Function(_CustomerOrder) _then) = __$CustomerOrderCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'order_number') String orderNumber, String state,@JsonKey(name: 'state_label') String? stateLabel,@JsonKey(name: 'items_count') int? itemsCount, List<CustomerOrderItem>? items, Map<String, dynamic>? address, CustomerOrderTotals? totals,@JsonKey(name: 'total_halalas') int? totalHalalas,@JsonKey(name: 'failure_reason') String? failureReason,@JsonKey(name: 'failure_note') String? failureNote,@JsonKey(name: 'can_rate') bool canRate,@JsonKey(name: 'created_at') DateTime? createdAt
});


@override $CustomerOrderTotalsCopyWith<$Res>? get totals;

}
/// @nodoc
class __$CustomerOrderCopyWithImpl<$Res>
    implements _$CustomerOrderCopyWith<$Res> {
  __$CustomerOrderCopyWithImpl(this._self, this._then);

  final _CustomerOrder _self;
  final $Res Function(_CustomerOrder) _then;

/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? state = null,Object? stateLabel = freezed,Object? itemsCount = freezed,Object? items = freezed,Object? address = freezed,Object? totals = freezed,Object? totalHalalas = freezed,Object? failureReason = freezed,Object? failureNote = freezed,Object? canRate = null,Object? createdAt = freezed,}) {
  return _then(_CustomerOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,stateLabel: freezed == stateLabel ? _self.stateLabel : stateLabel // ignore: cast_nullable_to_non_nullable
as String?,itemsCount: freezed == itemsCount ? _self.itemsCount : itemsCount // ignore: cast_nullable_to_non_nullable
as int?,items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CustomerOrderItem>?,address: freezed == address ? _self._address : address // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,totals: freezed == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as CustomerOrderTotals?,totalHalalas: freezed == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,failureNote: freezed == failureNote ? _self.failureNote : failureNote // ignore: cast_nullable_to_non_nullable
as String?,canRate: null == canRate ? _self.canRate : canRate // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CustomerOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerOrderTotalsCopyWith<$Res>? get totals {
    if (_self.totals == null) {
    return null;
  }

  return $CustomerOrderTotalsCopyWith<$Res>(_self.totals!, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}

// dart format on
