// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'captain_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CaptainProfile {

 int get id;@JsonKey(name: 'merchant_id') int get merchantId;@JsonKey(name: 'branch_id') int get branchId; String? get name; String get phone;@JsonKey(name: 'is_available') bool get isAvailable;
/// Create a copy of CaptainProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptainProfileCopyWith<CaptainProfile> get copyWith => _$CaptainProfileCopyWithImpl<CaptainProfile>(this as CaptainProfile, _$identity);

  /// Serializes this CaptainProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptainProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.merchantId, merchantId) || other.merchantId == merchantId)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,merchantId,branchId,name,phone,isAvailable);

@override
String toString() {
  return 'CaptainProfile(id: $id, merchantId: $merchantId, branchId: $branchId, name: $name, phone: $phone, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $CaptainProfileCopyWith<$Res>  {
  factory $CaptainProfileCopyWith(CaptainProfile value, $Res Function(CaptainProfile) _then) = _$CaptainProfileCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'merchant_id') int merchantId,@JsonKey(name: 'branch_id') int branchId, String? name, String phone,@JsonKey(name: 'is_available') bool isAvailable
});




}
/// @nodoc
class _$CaptainProfileCopyWithImpl<$Res>
    implements $CaptainProfileCopyWith<$Res> {
  _$CaptainProfileCopyWithImpl(this._self, this._then);

  final CaptainProfile _self;
  final $Res Function(CaptainProfile) _then;

/// Create a copy of CaptainProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? merchantId = null,Object? branchId = null,Object? name = freezed,Object? phone = null,Object? isAvailable = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,merchantId: null == merchantId ? _self.merchantId : merchantId // ignore: cast_nullable_to_non_nullable
as int,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CaptainProfile].
extension CaptainProfilePatterns on CaptainProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CaptainProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CaptainProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CaptainProfile value)  $default,){
final _that = this;
switch (_that) {
case _CaptainProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CaptainProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CaptainProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'merchant_id')  int merchantId, @JsonKey(name: 'branch_id')  int branchId,  String? name,  String phone, @JsonKey(name: 'is_available')  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CaptainProfile() when $default != null:
return $default(_that.id,_that.merchantId,_that.branchId,_that.name,_that.phone,_that.isAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'merchant_id')  int merchantId, @JsonKey(name: 'branch_id')  int branchId,  String? name,  String phone, @JsonKey(name: 'is_available')  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _CaptainProfile():
return $default(_that.id,_that.merchantId,_that.branchId,_that.name,_that.phone,_that.isAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'merchant_id')  int merchantId, @JsonKey(name: 'branch_id')  int branchId,  String? name,  String phone, @JsonKey(name: 'is_available')  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _CaptainProfile() when $default != null:
return $default(_that.id,_that.merchantId,_that.branchId,_that.name,_that.phone,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CaptainProfile implements CaptainProfile {
  const _CaptainProfile({required this.id, @JsonKey(name: 'merchant_id') required this.merchantId, @JsonKey(name: 'branch_id') required this.branchId, this.name, required this.phone, @JsonKey(name: 'is_available') this.isAvailable = true});
  factory _CaptainProfile.fromJson(Map<String, dynamic> json) => _$CaptainProfileFromJson(json);

@override final  int id;
@override@JsonKey(name: 'merchant_id') final  int merchantId;
@override@JsonKey(name: 'branch_id') final  int branchId;
@override final  String? name;
@override final  String phone;
@override@JsonKey(name: 'is_available') final  bool isAvailable;

/// Create a copy of CaptainProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptainProfileCopyWith<_CaptainProfile> get copyWith => __$CaptainProfileCopyWithImpl<_CaptainProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CaptainProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaptainProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.merchantId, merchantId) || other.merchantId == merchantId)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,merchantId,branchId,name,phone,isAvailable);

@override
String toString() {
  return 'CaptainProfile(id: $id, merchantId: $merchantId, branchId: $branchId, name: $name, phone: $phone, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$CaptainProfileCopyWith<$Res> implements $CaptainProfileCopyWith<$Res> {
  factory _$CaptainProfileCopyWith(_CaptainProfile value, $Res Function(_CaptainProfile) _then) = __$CaptainProfileCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'merchant_id') int merchantId,@JsonKey(name: 'branch_id') int branchId, String? name, String phone,@JsonKey(name: 'is_available') bool isAvailable
});




}
/// @nodoc
class __$CaptainProfileCopyWithImpl<$Res>
    implements _$CaptainProfileCopyWith<$Res> {
  __$CaptainProfileCopyWithImpl(this._self, this._then);

  final _CaptainProfile _self;
  final $Res Function(_CaptainProfile) _then;

/// Create a copy of CaptainProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? merchantId = null,Object? branchId = null,Object? name = freezed,Object? phone = null,Object? isAvailable = null,}) {
  return _then(_CaptainProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,merchantId: null == merchantId ? _self.merchantId : merchantId // ignore: cast_nullable_to_non_nullable
as int,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CaptainOrderLine {

 int get id;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn; int get quantity;@JsonKey(name: 'unit_price_halalas') int get unitPriceHalalas; bool get removed;
/// Create a copy of CaptainOrderLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptainOrderLineCopyWith<CaptainOrderLine> get copyWith => _$CaptainOrderLineCopyWithImpl<CaptainOrderLine>(this as CaptainOrderLine, _$identity);

  /// Serializes this CaptainOrderLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptainOrderLine&&(identical(other.id, id) || other.id == id)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPriceHalalas, unitPriceHalalas) || other.unitPriceHalalas == unitPriceHalalas)&&(identical(other.removed, removed) || other.removed == removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameAr,nameEn,quantity,unitPriceHalalas,removed);

@override
String toString() {
  return 'CaptainOrderLine(id: $id, nameAr: $nameAr, nameEn: $nameEn, quantity: $quantity, unitPriceHalalas: $unitPriceHalalas, removed: $removed)';
}


}

/// @nodoc
abstract mixin class $CaptainOrderLineCopyWith<$Res>  {
  factory $CaptainOrderLineCopyWith(CaptainOrderLine value, $Res Function(CaptainOrderLine) _then) = _$CaptainOrderLineCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, int quantity,@JsonKey(name: 'unit_price_halalas') int unitPriceHalalas, bool removed
});




}
/// @nodoc
class _$CaptainOrderLineCopyWithImpl<$Res>
    implements $CaptainOrderLineCopyWith<$Res> {
  _$CaptainOrderLineCopyWithImpl(this._self, this._then);

  final CaptainOrderLine _self;
  final $Res Function(CaptainOrderLine) _then;

/// Create a copy of CaptainOrderLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? quantity = null,Object? unitPriceHalalas = null,Object? removed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPriceHalalas: null == unitPriceHalalas ? _self.unitPriceHalalas : unitPriceHalalas // ignore: cast_nullable_to_non_nullable
as int,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CaptainOrderLine].
extension CaptainOrderLinePatterns on CaptainOrderLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CaptainOrderLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CaptainOrderLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CaptainOrderLine value)  $default,){
final _that = this;
switch (_that) {
case _CaptainOrderLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CaptainOrderLine value)?  $default,){
final _that = this;
switch (_that) {
case _CaptainOrderLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  int quantity, @JsonKey(name: 'unit_price_halalas')  int unitPriceHalalas,  bool removed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CaptainOrderLine() when $default != null:
return $default(_that.id,_that.nameAr,_that.nameEn,_that.quantity,_that.unitPriceHalalas,_that.removed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  int quantity, @JsonKey(name: 'unit_price_halalas')  int unitPriceHalalas,  bool removed)  $default,) {final _that = this;
switch (_that) {
case _CaptainOrderLine():
return $default(_that.id,_that.nameAr,_that.nameEn,_that.quantity,_that.unitPriceHalalas,_that.removed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn,  int quantity, @JsonKey(name: 'unit_price_halalas')  int unitPriceHalalas,  bool removed)?  $default,) {final _that = this;
switch (_that) {
case _CaptainOrderLine() when $default != null:
return $default(_that.id,_that.nameAr,_that.nameEn,_that.quantity,_that.unitPriceHalalas,_that.removed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CaptainOrderLine extends CaptainOrderLine {
  const _CaptainOrderLine({required this.id, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, required this.quantity, @JsonKey(name: 'unit_price_halalas') this.unitPriceHalalas = 0, this.removed = false}): super._();
  factory _CaptainOrderLine.fromJson(Map<String, dynamic> json) => _$CaptainOrderLineFromJson(json);

@override final  int id;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override final  int quantity;
@override@JsonKey(name: 'unit_price_halalas') final  int unitPriceHalalas;
@override@JsonKey() final  bool removed;

/// Create a copy of CaptainOrderLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptainOrderLineCopyWith<_CaptainOrderLine> get copyWith => __$CaptainOrderLineCopyWithImpl<_CaptainOrderLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CaptainOrderLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaptainOrderLine&&(identical(other.id, id) || other.id == id)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPriceHalalas, unitPriceHalalas) || other.unitPriceHalalas == unitPriceHalalas)&&(identical(other.removed, removed) || other.removed == removed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameAr,nameEn,quantity,unitPriceHalalas,removed);

@override
String toString() {
  return 'CaptainOrderLine(id: $id, nameAr: $nameAr, nameEn: $nameEn, quantity: $quantity, unitPriceHalalas: $unitPriceHalalas, removed: $removed)';
}


}

/// @nodoc
abstract mixin class _$CaptainOrderLineCopyWith<$Res> implements $CaptainOrderLineCopyWith<$Res> {
  factory _$CaptainOrderLineCopyWith(_CaptainOrderLine value, $Res Function(_CaptainOrderLine) _then) = __$CaptainOrderLineCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn, int quantity,@JsonKey(name: 'unit_price_halalas') int unitPriceHalalas, bool removed
});




}
/// @nodoc
class __$CaptainOrderLineCopyWithImpl<$Res>
    implements _$CaptainOrderLineCopyWith<$Res> {
  __$CaptainOrderLineCopyWithImpl(this._self, this._then);

  final _CaptainOrderLine _self;
  final $Res Function(_CaptainOrderLine) _then;

/// Create a copy of CaptainOrderLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? quantity = null,Object? unitPriceHalalas = null,Object? removed = null,}) {
  return _then(_CaptainOrderLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,unitPriceHalalas: null == unitPriceHalalas ? _self.unitPriceHalalas : unitPriceHalalas // ignore: cast_nullable_to_non_nullable
as int,removed: null == removed ? _self.removed : removed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CaptainOrderCustomer {

 String? get name; String? get phone;
/// Create a copy of CaptainOrderCustomer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptainOrderCustomerCopyWith<CaptainOrderCustomer> get copyWith => _$CaptainOrderCustomerCopyWithImpl<CaptainOrderCustomer>(this as CaptainOrderCustomer, _$identity);

  /// Serializes this CaptainOrderCustomer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptainOrderCustomer&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,phone);

@override
String toString() {
  return 'CaptainOrderCustomer(name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $CaptainOrderCustomerCopyWith<$Res>  {
  factory $CaptainOrderCustomerCopyWith(CaptainOrderCustomer value, $Res Function(CaptainOrderCustomer) _then) = _$CaptainOrderCustomerCopyWithImpl;
@useResult
$Res call({
 String? name, String? phone
});




}
/// @nodoc
class _$CaptainOrderCustomerCopyWithImpl<$Res>
    implements $CaptainOrderCustomerCopyWith<$Res> {
  _$CaptainOrderCustomerCopyWithImpl(this._self, this._then);

  final CaptainOrderCustomer _self;
  final $Res Function(CaptainOrderCustomer) _then;

/// Create a copy of CaptainOrderCustomer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? phone = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CaptainOrderCustomer].
extension CaptainOrderCustomerPatterns on CaptainOrderCustomer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CaptainOrderCustomer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CaptainOrderCustomer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CaptainOrderCustomer value)  $default,){
final _that = this;
switch (_that) {
case _CaptainOrderCustomer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CaptainOrderCustomer value)?  $default,){
final _that = this;
switch (_that) {
case _CaptainOrderCustomer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CaptainOrderCustomer() when $default != null:
return $default(_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? phone)  $default,) {final _that = this;
switch (_that) {
case _CaptainOrderCustomer():
return $default(_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? phone)?  $default,) {final _that = this;
switch (_that) {
case _CaptainOrderCustomer() when $default != null:
return $default(_that.name,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CaptainOrderCustomer implements CaptainOrderCustomer {
  const _CaptainOrderCustomer({this.name, this.phone});
  factory _CaptainOrderCustomer.fromJson(Map<String, dynamic> json) => _$CaptainOrderCustomerFromJson(json);

@override final  String? name;
@override final  String? phone;

/// Create a copy of CaptainOrderCustomer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptainOrderCustomerCopyWith<_CaptainOrderCustomer> get copyWith => __$CaptainOrderCustomerCopyWithImpl<_CaptainOrderCustomer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CaptainOrderCustomerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaptainOrderCustomer&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,phone);

@override
String toString() {
  return 'CaptainOrderCustomer(name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$CaptainOrderCustomerCopyWith<$Res> implements $CaptainOrderCustomerCopyWith<$Res> {
  factory _$CaptainOrderCustomerCopyWith(_CaptainOrderCustomer value, $Res Function(_CaptainOrderCustomer) _then) = __$CaptainOrderCustomerCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? phone
});




}
/// @nodoc
class __$CaptainOrderCustomerCopyWithImpl<$Res>
    implements _$CaptainOrderCustomerCopyWith<$Res> {
  __$CaptainOrderCustomerCopyWithImpl(this._self, this._then);

  final _CaptainOrderCustomer _self;
  final $Res Function(_CaptainOrderCustomer) _then;

/// Create a copy of CaptainOrderCustomer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? phone = freezed,}) {
  return _then(_CaptainOrderCustomer(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CaptainOrder {

 int get id;@JsonKey(name: 'order_number') String get orderNumber; String get state; CaptainOrderCustomer? get customer; Map<String, dynamic>? get dropoff;@JsonKey(name: 'payment_method') String? get paymentMethod;@JsonKey(name: 'total_halalas') int get totalHalalas;@JsonKey(name: 'cash_to_collect_halalas') int get cashToCollectHalalas;@JsonKey(name: 'failure_reason') String? get failureReason; List<CaptainOrderLine>? get items;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of CaptainOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptainOrderCopyWith<CaptainOrder> get copyWith => _$CaptainOrderCopyWithImpl<CaptainOrder>(this as CaptainOrder, _$identity);

  /// Serializes this CaptainOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptainOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.state, state) || other.state == state)&&(identical(other.customer, customer) || other.customer == customer)&&const DeepCollectionEquality().equals(other.dropoff, dropoff)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas)&&(identical(other.cashToCollectHalalas, cashToCollectHalalas) || other.cashToCollectHalalas == cashToCollectHalalas)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,state,customer,const DeepCollectionEquality().hash(dropoff),paymentMethod,totalHalalas,cashToCollectHalalas,failureReason,const DeepCollectionEquality().hash(items),createdAt);

@override
String toString() {
  return 'CaptainOrder(id: $id, orderNumber: $orderNumber, state: $state, customer: $customer, dropoff: $dropoff, paymentMethod: $paymentMethod, totalHalalas: $totalHalalas, cashToCollectHalalas: $cashToCollectHalalas, failureReason: $failureReason, items: $items, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $CaptainOrderCopyWith<$Res>  {
  factory $CaptainOrderCopyWith(CaptainOrder value, $Res Function(CaptainOrder) _then) = _$CaptainOrderCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'order_number') String orderNumber, String state, CaptainOrderCustomer? customer, Map<String, dynamic>? dropoff,@JsonKey(name: 'payment_method') String? paymentMethod,@JsonKey(name: 'total_halalas') int totalHalalas,@JsonKey(name: 'cash_to_collect_halalas') int cashToCollectHalalas,@JsonKey(name: 'failure_reason') String? failureReason, List<CaptainOrderLine>? items,@JsonKey(name: 'created_at') DateTime? createdAt
});


$CaptainOrderCustomerCopyWith<$Res>? get customer;

}
/// @nodoc
class _$CaptainOrderCopyWithImpl<$Res>
    implements $CaptainOrderCopyWith<$Res> {
  _$CaptainOrderCopyWithImpl(this._self, this._then);

  final CaptainOrder _self;
  final $Res Function(CaptainOrder) _then;

/// Create a copy of CaptainOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? state = null,Object? customer = freezed,Object? dropoff = freezed,Object? paymentMethod = freezed,Object? totalHalalas = null,Object? cashToCollectHalalas = null,Object? failureReason = freezed,Object? items = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as CaptainOrderCustomer?,dropoff: freezed == dropoff ? _self.dropoff : dropoff // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,cashToCollectHalalas: null == cashToCollectHalalas ? _self.cashToCollectHalalas : cashToCollectHalalas // ignore: cast_nullable_to_non_nullable
as int,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CaptainOrderLine>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CaptainOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CaptainOrderCustomerCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CaptainOrderCustomerCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// Adds pattern-matching-related methods to [CaptainOrder].
extension CaptainOrderPatterns on CaptainOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CaptainOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CaptainOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CaptainOrder value)  $default,){
final _that = this;
switch (_that) {
case _CaptainOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CaptainOrder value)?  $default,){
final _that = this;
switch (_that) {
case _CaptainOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_number')  String orderNumber,  String state,  CaptainOrderCustomer? customer,  Map<String, dynamic>? dropoff, @JsonKey(name: 'payment_method')  String? paymentMethod, @JsonKey(name: 'total_halalas')  int totalHalalas, @JsonKey(name: 'cash_to_collect_halalas')  int cashToCollectHalalas, @JsonKey(name: 'failure_reason')  String? failureReason,  List<CaptainOrderLine>? items, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CaptainOrder() when $default != null:
return $default(_that.id,_that.orderNumber,_that.state,_that.customer,_that.dropoff,_that.paymentMethod,_that.totalHalalas,_that.cashToCollectHalalas,_that.failureReason,_that.items,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'order_number')  String orderNumber,  String state,  CaptainOrderCustomer? customer,  Map<String, dynamic>? dropoff, @JsonKey(name: 'payment_method')  String? paymentMethod, @JsonKey(name: 'total_halalas')  int totalHalalas, @JsonKey(name: 'cash_to_collect_halalas')  int cashToCollectHalalas, @JsonKey(name: 'failure_reason')  String? failureReason,  List<CaptainOrderLine>? items, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _CaptainOrder():
return $default(_that.id,_that.orderNumber,_that.state,_that.customer,_that.dropoff,_that.paymentMethod,_that.totalHalalas,_that.cashToCollectHalalas,_that.failureReason,_that.items,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'order_number')  String orderNumber,  String state,  CaptainOrderCustomer? customer,  Map<String, dynamic>? dropoff, @JsonKey(name: 'payment_method')  String? paymentMethod, @JsonKey(name: 'total_halalas')  int totalHalalas, @JsonKey(name: 'cash_to_collect_halalas')  int cashToCollectHalalas, @JsonKey(name: 'failure_reason')  String? failureReason,  List<CaptainOrderLine>? items, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CaptainOrder() when $default != null:
return $default(_that.id,_that.orderNumber,_that.state,_that.customer,_that.dropoff,_that.paymentMethod,_that.totalHalalas,_that.cashToCollectHalalas,_that.failureReason,_that.items,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CaptainOrder extends CaptainOrder {
  const _CaptainOrder({required this.id, @JsonKey(name: 'order_number') required this.orderNumber, required this.state, this.customer, final  Map<String, dynamic>? dropoff, @JsonKey(name: 'payment_method') this.paymentMethod, @JsonKey(name: 'total_halalas') this.totalHalalas = 0, @JsonKey(name: 'cash_to_collect_halalas') this.cashToCollectHalalas = 0, @JsonKey(name: 'failure_reason') this.failureReason, final  List<CaptainOrderLine>? items, @JsonKey(name: 'created_at') this.createdAt}): _dropoff = dropoff,_items = items,super._();
  factory _CaptainOrder.fromJson(Map<String, dynamic> json) => _$CaptainOrderFromJson(json);

@override final  int id;
@override@JsonKey(name: 'order_number') final  String orderNumber;
@override final  String state;
@override final  CaptainOrderCustomer? customer;
 final  Map<String, dynamic>? _dropoff;
@override Map<String, dynamic>? get dropoff {
  final value = _dropoff;
  if (value == null) return null;
  if (_dropoff is EqualUnmodifiableMapView) return _dropoff;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'payment_method') final  String? paymentMethod;
@override@JsonKey(name: 'total_halalas') final  int totalHalalas;
@override@JsonKey(name: 'cash_to_collect_halalas') final  int cashToCollectHalalas;
@override@JsonKey(name: 'failure_reason') final  String? failureReason;
 final  List<CaptainOrderLine>? _items;
@override List<CaptainOrderLine>? get items {
  final value = _items;
  if (value == null) return null;
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of CaptainOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptainOrderCopyWith<_CaptainOrder> get copyWith => __$CaptainOrderCopyWithImpl<_CaptainOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CaptainOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaptainOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.state, state) || other.state == state)&&(identical(other.customer, customer) || other.customer == customer)&&const DeepCollectionEquality().equals(other._dropoff, _dropoff)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.totalHalalas, totalHalalas) || other.totalHalalas == totalHalalas)&&(identical(other.cashToCollectHalalas, cashToCollectHalalas) || other.cashToCollectHalalas == cashToCollectHalalas)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,state,customer,const DeepCollectionEquality().hash(_dropoff),paymentMethod,totalHalalas,cashToCollectHalalas,failureReason,const DeepCollectionEquality().hash(_items),createdAt);

@override
String toString() {
  return 'CaptainOrder(id: $id, orderNumber: $orderNumber, state: $state, customer: $customer, dropoff: $dropoff, paymentMethod: $paymentMethod, totalHalalas: $totalHalalas, cashToCollectHalalas: $cashToCollectHalalas, failureReason: $failureReason, items: $items, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CaptainOrderCopyWith<$Res> implements $CaptainOrderCopyWith<$Res> {
  factory _$CaptainOrderCopyWith(_CaptainOrder value, $Res Function(_CaptainOrder) _then) = __$CaptainOrderCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'order_number') String orderNumber, String state, CaptainOrderCustomer? customer, Map<String, dynamic>? dropoff,@JsonKey(name: 'payment_method') String? paymentMethod,@JsonKey(name: 'total_halalas') int totalHalalas,@JsonKey(name: 'cash_to_collect_halalas') int cashToCollectHalalas,@JsonKey(name: 'failure_reason') String? failureReason, List<CaptainOrderLine>? items,@JsonKey(name: 'created_at') DateTime? createdAt
});


@override $CaptainOrderCustomerCopyWith<$Res>? get customer;

}
/// @nodoc
class __$CaptainOrderCopyWithImpl<$Res>
    implements _$CaptainOrderCopyWith<$Res> {
  __$CaptainOrderCopyWithImpl(this._self, this._then);

  final _CaptainOrder _self;
  final $Res Function(_CaptainOrder) _then;

/// Create a copy of CaptainOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? state = null,Object? customer = freezed,Object? dropoff = freezed,Object? paymentMethod = freezed,Object? totalHalalas = null,Object? cashToCollectHalalas = null,Object? failureReason = freezed,Object? items = freezed,Object? createdAt = freezed,}) {
  return _then(_CaptainOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as CaptainOrderCustomer?,dropoff: freezed == dropoff ? _self._dropoff : dropoff // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,totalHalalas: null == totalHalalas ? _self.totalHalalas : totalHalalas // ignore: cast_nullable_to_non_nullable
as int,cashToCollectHalalas: null == cashToCollectHalalas ? _self.cashToCollectHalalas : cashToCollectHalalas // ignore: cast_nullable_to_non_nullable
as int,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CaptainOrderLine>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CaptainOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CaptainOrderCustomerCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CaptainOrderCustomerCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}

// dart format on
