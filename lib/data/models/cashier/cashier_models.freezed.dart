// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cashier_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CashierProfile {

 int get id;@JsonKey(name: 'merchant_id') int get merchantId;@JsonKey(name: 'branch_id') int get branchId; String? get name; String get phone;
/// Create a copy of CashierProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashierProfileCopyWith<CashierProfile> get copyWith => _$CashierProfileCopyWithImpl<CashierProfile>(this as CashierProfile, _$identity);

  /// Serializes this CashierProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashierProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.merchantId, merchantId) || other.merchantId == merchantId)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,merchantId,branchId,name,phone);

@override
String toString() {
  return 'CashierProfile(id: $id, merchantId: $merchantId, branchId: $branchId, name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $CashierProfileCopyWith<$Res>  {
  factory $CashierProfileCopyWith(CashierProfile value, $Res Function(CashierProfile) _then) = _$CashierProfileCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'merchant_id') int merchantId,@JsonKey(name: 'branch_id') int branchId, String? name, String phone
});




}
/// @nodoc
class _$CashierProfileCopyWithImpl<$Res>
    implements $CashierProfileCopyWith<$Res> {
  _$CashierProfileCopyWithImpl(this._self, this._then);

  final CashierProfile _self;
  final $Res Function(CashierProfile) _then;

/// Create a copy of CashierProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? merchantId = null,Object? branchId = null,Object? name = freezed,Object? phone = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,merchantId: null == merchantId ? _self.merchantId : merchantId // ignore: cast_nullable_to_non_nullable
as int,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CashierProfile].
extension CashierProfilePatterns on CashierProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashierProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashierProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashierProfile value)  $default,){
final _that = this;
switch (_that) {
case _CashierProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashierProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CashierProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'merchant_id')  int merchantId, @JsonKey(name: 'branch_id')  int branchId,  String? name,  String phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashierProfile() when $default != null:
return $default(_that.id,_that.merchantId,_that.branchId,_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'merchant_id')  int merchantId, @JsonKey(name: 'branch_id')  int branchId,  String? name,  String phone)  $default,) {final _that = this;
switch (_that) {
case _CashierProfile():
return $default(_that.id,_that.merchantId,_that.branchId,_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'merchant_id')  int merchantId, @JsonKey(name: 'branch_id')  int branchId,  String? name,  String phone)?  $default,) {final _that = this;
switch (_that) {
case _CashierProfile() when $default != null:
return $default(_that.id,_that.merchantId,_that.branchId,_that.name,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashierProfile implements CashierProfile {
  const _CashierProfile({required this.id, @JsonKey(name: 'merchant_id') required this.merchantId, @JsonKey(name: 'branch_id') required this.branchId, this.name, required this.phone});
  factory _CashierProfile.fromJson(Map<String, dynamic> json) => _$CashierProfileFromJson(json);

@override final  int id;
@override@JsonKey(name: 'merchant_id') final  int merchantId;
@override@JsonKey(name: 'branch_id') final  int branchId;
@override final  String? name;
@override final  String phone;

/// Create a copy of CashierProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashierProfileCopyWith<_CashierProfile> get copyWith => __$CashierProfileCopyWithImpl<_CashierProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashierProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashierProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.merchantId, merchantId) || other.merchantId == merchantId)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,merchantId,branchId,name,phone);

@override
String toString() {
  return 'CashierProfile(id: $id, merchantId: $merchantId, branchId: $branchId, name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$CashierProfileCopyWith<$Res> implements $CashierProfileCopyWith<$Res> {
  factory _$CashierProfileCopyWith(_CashierProfile value, $Res Function(_CashierProfile) _then) = __$CashierProfileCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'merchant_id') int merchantId,@JsonKey(name: 'branch_id') int branchId, String? name, String phone
});




}
/// @nodoc
class __$CashierProfileCopyWithImpl<$Res>
    implements _$CashierProfileCopyWith<$Res> {
  __$CashierProfileCopyWithImpl(this._self, this._then);

  final _CashierProfile _self;
  final $Res Function(_CashierProfile) _then;

/// Create a copy of CashierProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? merchantId = null,Object? branchId = null,Object? name = freezed,Object? phone = null,}) {
  return _then(_CashierProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,merchantId: null == merchantId ? _self.merchantId : merchantId // ignore: cast_nullable_to_non_nullable
as int,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CashierOrderItem {

 int get id;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn;@JsonKey(name: 'image_url') String? get imageUrl; int get quantity;@JsonKey(name: 'unit_price_halalas') int get unitPriceHalalas;@JsonKey(name: 'total_halalas') int get totalHalalas; bool get prepared;@JsonKey(name: 'prepared_at') String? get preparedAt; bool get removed;@JsonKey(name: 'removed_reason') String? get removedReason;
/// Create a copy of CashierOrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashierOrderItemCopyWith<CashierOrderItem> get copyWith => _$CashierOrderItemCopyWithImpl<CashierOrderItem>(this as CashierOrderItem, _$identity);

  /// Serializes this CashierOrderItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashierOrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPriceHalalas, unitPriceHalalas) || other.unitPriceHalalas == unitPriceHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas)&&(identical(other.prepared, prepared) || other.prepared == prepared)&&(identical(other.preparedAt, preparedAt) || other.preparedAt == preparedAt)&&(identical(other.removed, removed) || other.removed == removed)&&(identical(other.removedReason, removedReason) || other.removedReason == removedReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameAr,nameEn,imageUrl,quantity,unitPriceHalalas,totalHalalas,prepared,preparedAt,removed,removedReason);

@override
String toString() {
  return 'CashierOrderItem(id: $id, nameAr: $nameAr, nameEn: $nameEn, imageUrl: $imageUrl, quantity: $quantity, unitPriceHalalas: $unitPriceHalalas, totalHalalas: $totalHalalas, prepared: $prepared, preparedAt: $preparedAt, removed: $removed, removedReason: $removedReason)';
}


}

/// @nodoc
abstract mixin class $CashierOrderItemCopyWith<$Res>  {
  factory $CashierOrderItemCopyWith(CashierOrderItem value, $Res Function(CashierOrderItem) _then) = _$CashierOrderItemCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'image_url') String? imageUrl, int quantity,@JsonKey(name: 'unit_price_halalas') int unitPriceHalalas,@JsonKey(name: 'total_halalas') int totalHalalas, bool prepared,@JsonKey(name: 'prepared_at') String? preparedAt, bool removed,@JsonKey(name: 'removed_reason') String? removedReason
});




}
/// @nodoc
class _$CashierOrderItemCopyWithImpl<$Res>
    implements $CashierOrderItemCopyWith<$Res> {
  _$CashierOrderItemCopyWithImpl(this._self, this._then);

  final CashierOrderItem _self;
  final $Res Function(CashierOrderItem) _then;

/// Create a copy of CashierOrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? imageUrl = freezed,Object? quantity = null,Object? unitPriceHalalas = null,Object? totalHalalas = null,Object? prepared = null,Object? preparedAt = freezed,Object? removed = null,Object? removedReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPriceHalalas: null == unitPriceHalalas ? _self.unitPriceHalalas : unitPriceHalalas // ignore: cast_nullable_to_non_nullable
as int,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,prepared: null == prepared ? _self.prepared : prepared // ignore: cast_nullable_to_non_nullable
as bool,preparedAt: freezed == preparedAt ? _self.preparedAt : preparedAt // ignore: cast_nullable_to_non_nullable
as String?,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,removedReason: freezed == removedReason ? _self.removedReason : removedReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashierOrderItem].
extension CashierOrderItemPatterns on CashierOrderItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashierOrderItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashierOrderItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashierOrderItem value)  $default,){
final _that = this;
switch (_that) {
case _CashierOrderItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashierOrderItem value)?  $default,){
final _that = this;
switch (_that) {
case _CashierOrderItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl,  int quantity, @JsonKey(name: 'unit_price_halalas')  int unitPriceHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas,  bool prepared, @JsonKey(name: 'prepared_at')  String? preparedAt,  bool removed, @JsonKey(name: 'removed_reason')  String? removedReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashierOrderItem() when $default != null:
return $default(_that.id,_that.nameAr,_that.nameEn,_that.imageUrl,_that.quantity,_that.unitPriceHalalas,_that.totalHalalas,_that.prepared,_that.preparedAt,_that.removed,_that.removedReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl,  int quantity, @JsonKey(name: 'unit_price_halalas')  int unitPriceHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas,  bool prepared, @JsonKey(name: 'prepared_at')  String? preparedAt,  bool removed, @JsonKey(name: 'removed_reason')  String? removedReason)  $default,) {final _that = this;
switch (_that) {
case _CashierOrderItem():
return $default(_that.id,_that.nameAr,_that.nameEn,_that.imageUrl,_that.quantity,_that.unitPriceHalalas,_that.totalHalalas,_that.prepared,_that.preparedAt,_that.removed,_that.removedReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'image_url')  String? imageUrl,  int quantity, @JsonKey(name: 'unit_price_halalas')  int unitPriceHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas,  bool prepared, @JsonKey(name: 'prepared_at')  String? preparedAt,  bool removed, @JsonKey(name: 'removed_reason')  String? removedReason)?  $default,) {final _that = this;
switch (_that) {
case _CashierOrderItem() when $default != null:
return $default(_that.id,_that.nameAr,_that.nameEn,_that.imageUrl,_that.quantity,_that.unitPriceHalalas,_that.totalHalalas,_that.prepared,_that.preparedAt,_that.removed,_that.removedReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashierOrderItem extends CashierOrderItem {
  const _CashierOrderItem({required this.id, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, @JsonKey(name: 'image_url') this.imageUrl, required this.quantity, @JsonKey(name: 'unit_price_halalas') this.unitPriceHalalas = 0, @JsonKey(name: 'total_halalas') this.totalHalalas = 0, this.prepared = false, @JsonKey(name: 'prepared_at') this.preparedAt, this.removed = false, @JsonKey(name: 'removed_reason') this.removedReason}): super._();
  factory _CashierOrderItem.fromJson(Map<String, dynamic> json) => _$CashierOrderItemFromJson(json);

@override final  int id;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override final  int quantity;
@override@JsonKey(name: 'unit_price_halalas') final  int unitPriceHalalas;
@override@JsonKey(name: 'total_halalas') final  int totalHalalas;
@override@JsonKey() final  bool prepared;
@override@JsonKey(name: 'prepared_at') final  String? preparedAt;
@override@JsonKey() final  bool removed;
@override@JsonKey(name: 'removed_reason') final  String? removedReason;

/// Create a copy of CashierOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashierOrderItemCopyWith<_CashierOrderItem> get copyWith => __$CashierOrderItemCopyWithImpl<_CashierOrderItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashierOrderItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashierOrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPriceHalalas, unitPriceHalalas) || other.unitPriceHalalas == unitPriceHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas)&&(identical(other.prepared, prepared) || other.prepared == prepared)&&(identical(other.preparedAt, preparedAt) || other.preparedAt == preparedAt)&&(identical(other.removed, removed) || other.removed == removed)&&(identical(other.removedReason, removedReason) || other.removedReason == removedReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameAr,nameEn,imageUrl,quantity,unitPriceHalalas,totalHalalas,prepared,preparedAt,removed,removedReason);

@override
String toString() {
  return 'CashierOrderItem(id: $id, nameAr: $nameAr, nameEn: $nameEn, imageUrl: $imageUrl, quantity: $quantity, unitPriceHalalas: $unitPriceHalalas, totalHalalas: $totalHalalas, prepared: $prepared, preparedAt: $preparedAt, removed: $removed, removedReason: $removedReason)';
}


}

/// @nodoc
abstract mixin class _$CashierOrderItemCopyWith<$Res> implements $CashierOrderItemCopyWith<$Res> {
  factory _$CashierOrderItemCopyWith(_CashierOrderItem value, $Res Function(_CashierOrderItem) _then) = __$CashierOrderItemCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'image_url') String? imageUrl, int quantity,@JsonKey(name: 'unit_price_halalas') int unitPriceHalalas,@JsonKey(name: 'total_halalas') int totalHalalas, bool prepared,@JsonKey(name: 'prepared_at') String? preparedAt, bool removed,@JsonKey(name: 'removed_reason') String? removedReason
});




}
/// @nodoc
class __$CashierOrderItemCopyWithImpl<$Res>
    implements _$CashierOrderItemCopyWith<$Res> {
  __$CashierOrderItemCopyWithImpl(this._self, this._then);

  final _CashierOrderItem _self;
  final $Res Function(_CashierOrderItem) _then;

/// Create a copy of CashierOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? imageUrl = freezed,Object? quantity = null,Object? unitPriceHalalas = null,Object? totalHalalas = null,Object? prepared = null,Object? preparedAt = freezed,Object? removed = null,Object? removedReason = freezed,}) {
  return _then(_CashierOrderItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPriceHalalas: null == unitPriceHalalas ? _self.unitPriceHalalas : unitPriceHalalas // ignore: cast_nullable_to_non_nullable
as int,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,prepared: null == prepared ? _self.prepared : prepared // ignore: cast_nullable_to_non_nullable
as bool,preparedAt: freezed == preparedAt ? _self.preparedAt : preparedAt // ignore: cast_nullable_to_non_nullable
as String?,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,removedReason: freezed == removedReason ? _self.removedReason : removedReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CashierOrderCaptain {

 int get id; String? get name; String? get phone;
/// Create a copy of CashierOrderCaptain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashierOrderCaptainCopyWith<CashierOrderCaptain> get copyWith => _$CashierOrderCaptainCopyWithImpl<CashierOrderCaptain>(this as CashierOrderCaptain, _$identity);

  /// Serializes this CashierOrderCaptain to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashierOrderCaptain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone);

@override
String toString() {
  return 'CashierOrderCaptain(id: $id, name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $CashierOrderCaptainCopyWith<$Res>  {
  factory $CashierOrderCaptainCopyWith(CashierOrderCaptain value, $Res Function(CashierOrderCaptain) _then) = _$CashierOrderCaptainCopyWithImpl;
@useResult
$Res call({
 int id, String? name, String? phone
});




}
/// @nodoc
class _$CashierOrderCaptainCopyWithImpl<$Res>
    implements $CashierOrderCaptainCopyWith<$Res> {
  _$CashierOrderCaptainCopyWithImpl(this._self, this._then);

  final CashierOrderCaptain _self;
  final $Res Function(CashierOrderCaptain) _then;

/// Create a copy of CashierOrderCaptain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? phone = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashierOrderCaptain].
extension CashierOrderCaptainPatterns on CashierOrderCaptain {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashierOrderCaptain value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashierOrderCaptain() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashierOrderCaptain value)  $default,){
final _that = this;
switch (_that) {
case _CashierOrderCaptain():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashierOrderCaptain value)?  $default,){
final _that = this;
switch (_that) {
case _CashierOrderCaptain() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  String? phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashierOrderCaptain() when $default != null:
return $default(_that.id,_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  String? phone)  $default,) {final _that = this;
switch (_that) {
case _CashierOrderCaptain():
return $default(_that.id,_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  String? phone)?  $default,) {final _that = this;
switch (_that) {
case _CashierOrderCaptain() when $default != null:
return $default(_that.id,_that.name,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashierOrderCaptain implements CashierOrderCaptain {
  const _CashierOrderCaptain({required this.id, this.name, this.phone});
  factory _CashierOrderCaptain.fromJson(Map<String, dynamic> json) => _$CashierOrderCaptainFromJson(json);

@override final  int id;
@override final  String? name;
@override final  String? phone;

/// Create a copy of CashierOrderCaptain
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashierOrderCaptainCopyWith<_CashierOrderCaptain> get copyWith => __$CashierOrderCaptainCopyWithImpl<_CashierOrderCaptain>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashierOrderCaptainToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashierOrderCaptain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone);

@override
String toString() {
  return 'CashierOrderCaptain(id: $id, name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$CashierOrderCaptainCopyWith<$Res> implements $CashierOrderCaptainCopyWith<$Res> {
  factory _$CashierOrderCaptainCopyWith(_CashierOrderCaptain value, $Res Function(_CashierOrderCaptain) _then) = __$CashierOrderCaptainCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, String? phone
});




}
/// @nodoc
class __$CashierOrderCaptainCopyWithImpl<$Res>
    implements _$CashierOrderCaptainCopyWith<$Res> {
  __$CashierOrderCaptainCopyWithImpl(this._self, this._then);

  final _CashierOrderCaptain _self;
  final $Res Function(_CashierOrderCaptain) _then;

/// Create a copy of CashierOrderCaptain
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? phone = freezed,}) {
  return _then(_CashierOrderCaptain(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CashierOrderTotals {

@JsonKey(name: 'subtotal_halalas') int get subtotalHalalas;@JsonKey(name: 'delivery_fee_halalas') int get deliveryFeeHalalas;@JsonKey(name: 'discount_halalas') int get discountHalalas;@JsonKey(name: 'total_halalas') int get totalHalalas;
/// Create a copy of CashierOrderTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashierOrderTotalsCopyWith<CashierOrderTotals> get copyWith => _$CashierOrderTotalsCopyWithImpl<CashierOrderTotals>(this as CashierOrderTotals, _$identity);

  /// Serializes this CashierOrderTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashierOrderTotals&&(identical(other.subtotalHalalas, subtotalHalalas) || other.subtotalHalalas == subtotalHalalas)&&(identical(other.deliveryFeeHalalas, deliveryFeeHalalas) || other.deliveryFeeHalalas == deliveryFeeHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subtotalHalalas,deliveryFeeHalalas,discountHalalas,totalHalalas);

@override
String toString() {
  return 'CashierOrderTotals(subtotalHalalas: $subtotalHalalas, deliveryFeeHalalas: $deliveryFeeHalalas, discountHalalas: $discountHalalas, totalHalalas: $totalHalalas)';
}


}

/// @nodoc
abstract mixin class $CashierOrderTotalsCopyWith<$Res>  {
  factory $CashierOrderTotalsCopyWith(CashierOrderTotals value, $Res Function(CashierOrderTotals) _then) = _$CashierOrderTotalsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'subtotal_halalas') int subtotalHalalas,@JsonKey(name: 'delivery_fee_halalas') int deliveryFeeHalalas,@JsonKey(name: 'discount_halalas') int discountHalalas,@JsonKey(name: 'total_halalas') int totalHalalas
});




}
/// @nodoc
class _$CashierOrderTotalsCopyWithImpl<$Res>
    implements $CashierOrderTotalsCopyWith<$Res> {
  _$CashierOrderTotalsCopyWithImpl(this._self, this._then);

  final CashierOrderTotals _self;
  final $Res Function(CashierOrderTotals) _then;

/// Create a copy of CashierOrderTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subtotalHalalas = null,Object? deliveryFeeHalalas = null,Object? discountHalalas = null,Object? totalHalalas = null,}) {
  return _then(_self.copyWith(
subtotalHalalas: null == subtotalHalalas ? _self.subtotalHalalas : subtotalHalalas // ignore: cast_nullable_to_non_nullable
as int,deliveryFeeHalalas: null == deliveryFeeHalalas ? _self.deliveryFeeHalalas : deliveryFeeHalalas // ignore: cast_nullable_to_non_nullable
as int,discountHalalas: null == discountHalalas ? _self.discountHalalas : discountHalalas // ignore: cast_nullable_to_non_nullable
as int,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CashierOrderTotals].
extension CashierOrderTotalsPatterns on CashierOrderTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashierOrderTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashierOrderTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashierOrderTotals value)  $default,){
final _that = this;
switch (_that) {
case _CashierOrderTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashierOrderTotals value)?  $default,){
final _that = this;
switch (_that) {
case _CashierOrderTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'subtotal_halalas')  int subtotalHalalas, @JsonKey(name: 'delivery_fee_halalas')  int deliveryFeeHalalas, @JsonKey(name: 'discount_halalas')  int discountHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashierOrderTotals() when $default != null:
return $default(_that.subtotalHalalas,_that.deliveryFeeHalalas,_that.discountHalalas,_that.totalHalalas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'subtotal_halalas')  int subtotalHalalas, @JsonKey(name: 'delivery_fee_halalas')  int deliveryFeeHalalas, @JsonKey(name: 'discount_halalas')  int discountHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas)  $default,) {final _that = this;
switch (_that) {
case _CashierOrderTotals():
return $default(_that.subtotalHalalas,_that.deliveryFeeHalalas,_that.discountHalalas,_that.totalHalalas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'subtotal_halalas')  int subtotalHalalas, @JsonKey(name: 'delivery_fee_halalas')  int deliveryFeeHalalas, @JsonKey(name: 'discount_halalas')  int discountHalalas, @JsonKey(name: 'total_halalas')  int totalHalalas)?  $default,) {final _that = this;
switch (_that) {
case _CashierOrderTotals() when $default != null:
return $default(_that.subtotalHalalas,_that.deliveryFeeHalalas,_that.discountHalalas,_that.totalHalalas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashierOrderTotals implements CashierOrderTotals {
  const _CashierOrderTotals({@JsonKey(name: 'subtotal_halalas') this.subtotalHalalas = 0, @JsonKey(name: 'delivery_fee_halalas') this.deliveryFeeHalalas = 0, @JsonKey(name: 'discount_halalas') this.discountHalalas = 0, @JsonKey(name: 'total_halalas') this.totalHalalas = 0});
  factory _CashierOrderTotals.fromJson(Map<String, dynamic> json) => _$CashierOrderTotalsFromJson(json);

@override@JsonKey(name: 'subtotal_halalas') final  int subtotalHalalas;
@override@JsonKey(name: 'delivery_fee_halalas') final  int deliveryFeeHalalas;
@override@JsonKey(name: 'discount_halalas') final  int discountHalalas;
@override@JsonKey(name: 'total_halalas') final  int totalHalalas;

/// Create a copy of CashierOrderTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashierOrderTotalsCopyWith<_CashierOrderTotals> get copyWith => __$CashierOrderTotalsCopyWithImpl<_CashierOrderTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashierOrderTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashierOrderTotals&&(identical(other.subtotalHalalas, subtotalHalalas) || other.subtotalHalalas == subtotalHalalas)&&(identical(other.deliveryFeeHalalas, deliveryFeeHalalas) || other.deliveryFeeHalalas == deliveryFeeHalalas)&&(identical(other.discountHalalas, discountHalalas) || other.discountHalalas == discountHalalas)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subtotalHalalas,deliveryFeeHalalas,discountHalalas,totalHalalas);

@override
String toString() {
  return 'CashierOrderTotals(subtotalHalalas: $subtotalHalalas, deliveryFeeHalalas: $deliveryFeeHalalas, discountHalalas: $discountHalalas, totalHalalas: $totalHalalas)';
}


}

/// @nodoc
abstract mixin class _$CashierOrderTotalsCopyWith<$Res> implements $CashierOrderTotalsCopyWith<$Res> {
  factory _$CashierOrderTotalsCopyWith(_CashierOrderTotals value, $Res Function(_CashierOrderTotals) _then) = __$CashierOrderTotalsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'subtotal_halalas') int subtotalHalalas,@JsonKey(name: 'delivery_fee_halalas') int deliveryFeeHalalas,@JsonKey(name: 'discount_halalas') int discountHalalas,@JsonKey(name: 'total_halalas') int totalHalalas
});




}
/// @nodoc
class __$CashierOrderTotalsCopyWithImpl<$Res>
    implements _$CashierOrderTotalsCopyWith<$Res> {
  __$CashierOrderTotalsCopyWithImpl(this._self, this._then);

  final _CashierOrderTotals _self;
  final $Res Function(_CashierOrderTotals) _then;

/// Create a copy of CashierOrderTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subtotalHalalas = null,Object? deliveryFeeHalalas = null,Object? discountHalalas = null,Object? totalHalalas = null,}) {
  return _then(_CashierOrderTotals(
subtotalHalalas: null == subtotalHalalas ? _self.subtotalHalalas : subtotalHalalas // ignore: cast_nullable_to_non_nullable
as int,deliveryFeeHalalas: null == deliveryFeeHalalas ? _self.deliveryFeeHalalas : deliveryFeeHalalas // ignore: cast_nullable_to_non_nullable
as int,discountHalalas: null == discountHalalas ? _self.discountHalalas : discountHalalas // ignore: cast_nullable_to_non_nullable
as int,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CashierOrder {

 int get id;@JsonKey(name: 'order_number') String get orderNumber; String get state;@JsonKey(name: 'captain_id') int? get captainId; CashierOrderCaptain? get captain;@JsonKey(name: 'items_count') int? get itemsCount; Map<String, dynamic>? get customer; CashierOrderTotals get totals; List<CashierOrderItem>? get items;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of CashierOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashierOrderCopyWith<CashierOrder> get copyWith => _$CashierOrderCopyWithImpl<CashierOrder>(this as CashierOrder, _$identity);

  /// Serializes this CashierOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashierOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.state, state) || other.state == state)&&(identical(other.captainId, captainId) || other.captainId == captainId)&&(identical(other.captain, captain) || other.captain == captain)&&(identical(other.itemsCount, itemsCount) || other.itemsCount == itemsCount)&&const DeepCollectionEquality().equals(other.customer, customer)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,state,captainId,captain,itemsCount,const DeepCollectionEquality().hash(customer),totals,const DeepCollectionEquality().hash(items),createdAt);

@override
String toString() {
  return 'CashierOrder(id: $id, orderNumber: $orderNumber, state: $state, captainId: $captainId, captain: $captain, itemsCount: $itemsCount, customer: $customer, totals: $totals, items: $items, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CashierOrderCopyWith<$Res>  {
  factory $CashierOrderCopyWith(CashierOrder value, $Res Function(CashierOrder) _then) = _$CashierOrderCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'order_number') String orderNumber, String state,@JsonKey(name: 'captain_id') int? captainId, CashierOrderCaptain? captain,@JsonKey(name: 'items_count') int? itemsCount, Map<String, dynamic>? customer, CashierOrderTotals totals, List<CashierOrderItem>? items,@JsonKey(name: 'created_at') DateTime? createdAt
});


$CashierOrderCaptainCopyWith<$Res>? get captain;$CashierOrderTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class _$CashierOrderCopyWithImpl<$Res>
    implements $CashierOrderCopyWith<$Res> {
  _$CashierOrderCopyWithImpl(this._self, this._then);

  final CashierOrder _self;
  final $Res Function(CashierOrder) _then;

/// Create a copy of CashierOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? state = null,Object? captainId = freezed,Object? captain = freezed,Object? itemsCount = freezed,Object? customer = freezed,Object? totals = null,Object? items = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,captainId: freezed == captainId ? _self.captainId : captainId // ignore: cast_nullable_to_non_nullable
as int?,captain: freezed == captain ? _self.captain : captain // ignore: cast_nullable_to_non_nullable
as CashierOrderCaptain?,itemsCount: freezed == itemsCount ? _self.itemsCount : itemsCount // ignore: cast_nullable_to_non_nullable
as int?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as CashierOrderTotals,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CashierOrderItem>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CashierOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashierOrderCaptainCopyWith<$Res>? get captain {
    if (_self.captain == null) {
    return null;
  }

  return $CashierOrderCaptainCopyWith<$Res>(_self.captain!, (value) {
    return _then(_self.copyWith(captain: value));
  });
}/// Create a copy of CashierOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashierOrderTotalsCopyWith<$Res> get totals {
  
  return $CashierOrderTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [CashierOrder].
extension CashierOrderPatterns on CashierOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashierOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashierOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashierOrder value)  $default,){
final _that = this;
switch (_that) {
case _CashierOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashierOrder value)?  $default,){
final _that = this;
switch (_that) {
case _CashierOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_number')  String orderNumber,  String state, @JsonKey(name: 'captain_id')  int? captainId,  CashierOrderCaptain? captain, @JsonKey(name: 'items_count')  int? itemsCount,  Map<String, dynamic>? customer,  CashierOrderTotals totals,  List<CashierOrderItem>? items, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashierOrder() when $default != null:
return $default(_that.id,_that.orderNumber,_that.state,_that.captainId,_that.captain,_that.itemsCount,_that.customer,_that.totals,_that.items,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_number')  String orderNumber,  String state, @JsonKey(name: 'captain_id')  int? captainId,  CashierOrderCaptain? captain, @JsonKey(name: 'items_count')  int? itemsCount,  Map<String, dynamic>? customer,  CashierOrderTotals totals,  List<CashierOrderItem>? items, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CashierOrder():
return $default(_that.id,_that.orderNumber,_that.state,_that.captainId,_that.captain,_that.itemsCount,_that.customer,_that.totals,_that.items,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'order_number')  String orderNumber,  String state, @JsonKey(name: 'captain_id')  int? captainId,  CashierOrderCaptain? captain, @JsonKey(name: 'items_count')  int? itemsCount,  Map<String, dynamic>? customer,  CashierOrderTotals totals,  List<CashierOrderItem>? items, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CashierOrder() when $default != null:
return $default(_that.id,_that.orderNumber,_that.state,_that.captainId,_that.captain,_that.itemsCount,_that.customer,_that.totals,_that.items,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashierOrder extends CashierOrder {
  const _CashierOrder({required this.id, @JsonKey(name: 'order_number') required this.orderNumber, required this.state, @JsonKey(name: 'captain_id') this.captainId, this.captain, @JsonKey(name: 'items_count') this.itemsCount, final  Map<String, dynamic>? customer, required this.totals, final  List<CashierOrderItem>? items, @JsonKey(name: 'created_at') this.createdAt}): _customer = customer,_items = items,super._();
  factory _CashierOrder.fromJson(Map<String, dynamic> json) => _$CashierOrderFromJson(json);

@override final  int id;
@override@JsonKey(name: 'order_number') final  String orderNumber;
@override final  String state;
@override@JsonKey(name: 'captain_id') final  int? captainId;
@override final  CashierOrderCaptain? captain;
@override@JsonKey(name: 'items_count') final  int? itemsCount;
 final  Map<String, dynamic>? _customer;
@override Map<String, dynamic>? get customer {
  final value = _customer;
  if (value == null) return null;
  if (_customer is EqualUnmodifiableMapView) return _customer;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  CashierOrderTotals totals;
 final  List<CashierOrderItem>? _items;
@override List<CashierOrderItem>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of CashierOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashierOrderCopyWith<_CashierOrder> get copyWith => __$CashierOrderCopyWithImpl<_CashierOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashierOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashierOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.state, state) || other.state == state)&&(identical(other.captainId, captainId) || other.captainId == captainId)&&(identical(other.captain, captain) || other.captain == captain)&&(identical(other.itemsCount, itemsCount) || other.itemsCount == itemsCount)&&const DeepCollectionEquality().equals(other._customer, _customer)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,state,captainId,captain,itemsCount,const DeepCollectionEquality().hash(_customer),totals,const DeepCollectionEquality().hash(_items),createdAt);

@override
String toString() {
  return 'CashierOrder(id: $id, orderNumber: $orderNumber, state: $state, captainId: $captainId, captain: $captain, itemsCount: $itemsCount, customer: $customer, totals: $totals, items: $items, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CashierOrderCopyWith<$Res> implements $CashierOrderCopyWith<$Res> {
  factory _$CashierOrderCopyWith(_CashierOrder value, $Res Function(_CashierOrder) _then) = __$CashierOrderCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'order_number') String orderNumber, String state,@JsonKey(name: 'captain_id') int? captainId, CashierOrderCaptain? captain,@JsonKey(name: 'items_count') int? itemsCount, Map<String, dynamic>? customer, CashierOrderTotals totals, List<CashierOrderItem>? items,@JsonKey(name: 'created_at') DateTime? createdAt
});


@override $CashierOrderCaptainCopyWith<$Res>? get captain;@override $CashierOrderTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class __$CashierOrderCopyWithImpl<$Res>
    implements _$CashierOrderCopyWith<$Res> {
  __$CashierOrderCopyWithImpl(this._self, this._then);

  final _CashierOrder _self;
  final $Res Function(_CashierOrder) _then;

/// Create a copy of CashierOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? state = null,Object? captainId = freezed,Object? captain = freezed,Object? itemsCount = freezed,Object? customer = freezed,Object? totals = null,Object? items = freezed,Object? createdAt = freezed,}) {
  return _then(_CashierOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,captainId: freezed == captainId ? _self.captainId : captainId // ignore: cast_nullable_to_non_nullable
as int?,captain: freezed == captain ? _self.captain : captain // ignore: cast_nullable_to_non_nullable
as CashierOrderCaptain?,itemsCount: freezed == itemsCount ? _self.itemsCount : itemsCount // ignore: cast_nullable_to_non_nullable
as int?,customer: freezed == customer ? _self._customer : customer // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as CashierOrderTotals,items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CashierOrderItem>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CashierOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashierOrderCaptainCopyWith<$Res>? get captain {
    if (_self.captain == null) {
    return null;
  }

  return $CashierOrderCaptainCopyWith<$Res>(_self.captain!, (value) {
    return _then(_self.copyWith(captain: value));
  });
}/// Create a copy of CashierOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CashierOrderTotalsCopyWith<$Res> get totals {
  
  return $CashierOrderTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// @nodoc
mixin _$AvailableCaptain {

 int get id; String? get name; String? get phone;@JsonKey(name: 'is_available') bool get isAvailable;@JsonKey(name: 'completed_today') int get completedToday;
/// Create a copy of AvailableCaptain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailableCaptainCopyWith<AvailableCaptain> get copyWith => _$AvailableCaptainCopyWithImpl<AvailableCaptain>(this as AvailableCaptain, _$identity);

  /// Serializes this AvailableCaptain to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailableCaptain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.completedToday, completedToday) || other.completedToday == completedToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,isAvailable,completedToday);

@override
String toString() {
  return 'AvailableCaptain(id: $id, name: $name, phone: $phone, isAvailable: $isAvailable, completedToday: $completedToday)';
}


}

/// @nodoc
abstract mixin class $AvailableCaptainCopyWith<$Res>  {
  factory $AvailableCaptainCopyWith(AvailableCaptain value, $Res Function(AvailableCaptain) _then) = _$AvailableCaptainCopyWithImpl;
@useResult
$Res call({
 int id, String? name, String? phone,@JsonKey(name: 'is_available') bool isAvailable,@JsonKey(name: 'completed_today') int completedToday
});




}
/// @nodoc
class _$AvailableCaptainCopyWithImpl<$Res>
    implements $AvailableCaptainCopyWith<$Res> {
  _$AvailableCaptainCopyWithImpl(this._self, this._then);

  final AvailableCaptain _self;
  final $Res Function(AvailableCaptain) _then;

/// Create a copy of AvailableCaptain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? phone = freezed,Object? isAvailable = null,Object? completedToday = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,completedToday: null == completedToday ? _self.completedToday : completedToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailableCaptain].
extension AvailableCaptainPatterns on AvailableCaptain {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailableCaptain value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailableCaptain() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailableCaptain value)  $default,){
final _that = this;
switch (_that) {
case _AvailableCaptain():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailableCaptain value)?  $default,){
final _that = this;
switch (_that) {
case _AvailableCaptain() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  String? phone, @JsonKey(name: 'is_available')  bool isAvailable, @JsonKey(name: 'completed_today')  int completedToday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailableCaptain() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.isAvailable,_that.completedToday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  String? phone, @JsonKey(name: 'is_available')  bool isAvailable, @JsonKey(name: 'completed_today')  int completedToday)  $default,) {final _that = this;
switch (_that) {
case _AvailableCaptain():
return $default(_that.id,_that.name,_that.phone,_that.isAvailable,_that.completedToday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  String? phone, @JsonKey(name: 'is_available')  bool isAvailable, @JsonKey(name: 'completed_today')  int completedToday)?  $default,) {final _that = this;
switch (_that) {
case _AvailableCaptain() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.isAvailable,_that.completedToday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailableCaptain implements AvailableCaptain {
  const _AvailableCaptain({required this.id, this.name, this.phone, @JsonKey(name: 'is_available') this.isAvailable = true, @JsonKey(name: 'completed_today') this.completedToday = 0});
  factory _AvailableCaptain.fromJson(Map<String, dynamic> json) => _$AvailableCaptainFromJson(json);

@override final  int id;
@override final  String? name;
@override final  String? phone;
@override@JsonKey(name: 'is_available') final  bool isAvailable;
@override@JsonKey(name: 'completed_today') final  int completedToday;

/// Create a copy of AvailableCaptain
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailableCaptainCopyWith<_AvailableCaptain> get copyWith => __$AvailableCaptainCopyWithImpl<_AvailableCaptain>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailableCaptainToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailableCaptain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.completedToday, completedToday) || other.completedToday == completedToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,isAvailable,completedToday);

@override
String toString() {
  return 'AvailableCaptain(id: $id, name: $name, phone: $phone, isAvailable: $isAvailable, completedToday: $completedToday)';
}


}

/// @nodoc
abstract mixin class _$AvailableCaptainCopyWith<$Res> implements $AvailableCaptainCopyWith<$Res> {
  factory _$AvailableCaptainCopyWith(_AvailableCaptain value, $Res Function(_AvailableCaptain) _then) = __$AvailableCaptainCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, String? phone,@JsonKey(name: 'is_available') bool isAvailable,@JsonKey(name: 'completed_today') int completedToday
});




}
/// @nodoc
class __$AvailableCaptainCopyWithImpl<$Res>
    implements _$AvailableCaptainCopyWith<$Res> {
  __$AvailableCaptainCopyWithImpl(this._self, this._then);

  final _AvailableCaptain _self;
  final $Res Function(_AvailableCaptain) _then;

/// Create a copy of AvailableCaptain
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? phone = freezed,Object? isAvailable = null,Object? completedToday = null,}) {
  return _then(_AvailableCaptain(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,completedToday: null == completedToday ? _self.completedToday : completedToday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
