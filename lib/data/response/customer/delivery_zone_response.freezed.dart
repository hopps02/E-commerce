// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_zone_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapDeliveryZone {

 int get id;@JsonKey(name: 'city_id') int get cityId;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn;@JsonKey(name: 'delivery_fee_halalas') int? get deliveryFeeHalalas;@JsonKey(name: 'polygon_geojson', fromJson: _polygonFromJson, includeToJson: false) List<LatLng> get polygon;
/// Create a copy of MapDeliveryZone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapDeliveryZoneCopyWith<MapDeliveryZone> get copyWith => _$MapDeliveryZoneCopyWithImpl<MapDeliveryZone>(this as MapDeliveryZone, _$identity);

  /// Serializes this MapDeliveryZone to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapDeliveryZone&&(identical(other.id, id) || other.id == id)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.deliveryFeeHalalas, deliveryFeeHalalas) || other.deliveryFeeHalalas == deliveryFeeHalalas)&&const DeepCollectionEquality().equals(other.polygon, polygon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cityId,nameAr,nameEn,deliveryFeeHalalas,const DeepCollectionEquality().hash(polygon));

@override
String toString() {
  return 'MapDeliveryZone(id: $id, cityId: $cityId, nameAr: $nameAr, nameEn: $nameEn, deliveryFeeHalalas: $deliveryFeeHalalas, polygon: $polygon)';
}


}

/// @nodoc
abstract mixin class $MapDeliveryZoneCopyWith<$Res>  {
  factory $MapDeliveryZoneCopyWith(MapDeliveryZone value, $Res Function(MapDeliveryZone) _then) = _$MapDeliveryZoneCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'city_id') int cityId,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'delivery_fee_halalas') int? deliveryFeeHalalas,@JsonKey(name: 'polygon_geojson', fromJson: _polygonFromJson, includeToJson: false) List<LatLng> polygon
});




}
/// @nodoc
class _$MapDeliveryZoneCopyWithImpl<$Res>
    implements $MapDeliveryZoneCopyWith<$Res> {
  _$MapDeliveryZoneCopyWithImpl(this._self, this._then);

  final MapDeliveryZone _self;
  final $Res Function(MapDeliveryZone) _then;

/// Create a copy of MapDeliveryZone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cityId = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? deliveryFeeHalalas = freezed,Object? polygon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cityId: null == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,deliveryFeeHalalas: freezed == deliveryFeeHalalas ? _self.deliveryFeeHalalas : deliveryFeeHalalas // ignore: cast_nullable_to_non_nullable
as int?,polygon: null == polygon ? _self.polygon : polygon // ignore: cast_nullable_to_non_nullable
as List<LatLng>,
  ));
}

}


/// Adds pattern-matching-related methods to [MapDeliveryZone].
extension MapDeliveryZonePatterns on MapDeliveryZone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapDeliveryZone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapDeliveryZone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapDeliveryZone value)  $default,){
final _that = this;
switch (_that) {
case _MapDeliveryZone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapDeliveryZone value)?  $default,){
final _that = this;
switch (_that) {
case _MapDeliveryZone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'city_id')  int cityId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'delivery_fee_halalas')  int? deliveryFeeHalalas, @JsonKey(name: 'polygon_geojson', fromJson: _polygonFromJson, includeToJson: false)  List<LatLng> polygon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapDeliveryZone() when $default != null:
return $default(_that.id,_that.cityId,_that.nameAr,_that.nameEn,_that.deliveryFeeHalalas,_that.polygon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'city_id')  int cityId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'delivery_fee_halalas')  int? deliveryFeeHalalas, @JsonKey(name: 'polygon_geojson', fromJson: _polygonFromJson, includeToJson: false)  List<LatLng> polygon)  $default,) {final _that = this;
switch (_that) {
case _MapDeliveryZone():
return $default(_that.id,_that.cityId,_that.nameAr,_that.nameEn,_that.deliveryFeeHalalas,_that.polygon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'city_id')  int cityId, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'delivery_fee_halalas')  int? deliveryFeeHalalas, @JsonKey(name: 'polygon_geojson', fromJson: _polygonFromJson, includeToJson: false)  List<LatLng> polygon)?  $default,) {final _that = this;
switch (_that) {
case _MapDeliveryZone() when $default != null:
return $default(_that.id,_that.cityId,_that.nameAr,_that.nameEn,_that.deliveryFeeHalalas,_that.polygon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapDeliveryZone extends MapDeliveryZone {
  const _MapDeliveryZone({required this.id, @JsonKey(name: 'city_id') required this.cityId, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, @JsonKey(name: 'delivery_fee_halalas') this.deliveryFeeHalalas, @JsonKey(name: 'polygon_geojson', fromJson: _polygonFromJson, includeToJson: false) final  List<LatLng> polygon = const <LatLng>[]}): _polygon = polygon,super._();
  factory _MapDeliveryZone.fromJson(Map<String, dynamic> json) => _$MapDeliveryZoneFromJson(json);

@override final  int id;
@override@JsonKey(name: 'city_id') final  int cityId;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override@JsonKey(name: 'delivery_fee_halalas') final  int? deliveryFeeHalalas;
 final  List<LatLng> _polygon;
@override@JsonKey(name: 'polygon_geojson', fromJson: _polygonFromJson, includeToJson: false) List<LatLng> get polygon {
  if (_polygon is EqualUnmodifiableListView) return _polygon;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_polygon);
}


/// Create a copy of MapDeliveryZone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapDeliveryZoneCopyWith<_MapDeliveryZone> get copyWith => __$MapDeliveryZoneCopyWithImpl<_MapDeliveryZone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapDeliveryZoneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapDeliveryZone&&(identical(other.id, id) || other.id == id)&&(identical(other.cityId, cityId) || other.cityId == cityId)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.deliveryFeeHalalas, deliveryFeeHalalas) || other.deliveryFeeHalalas == deliveryFeeHalalas)&&const DeepCollectionEquality().equals(other._polygon, _polygon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cityId,nameAr,nameEn,deliveryFeeHalalas,const DeepCollectionEquality().hash(_polygon));

@override
String toString() {
  return 'MapDeliveryZone(id: $id, cityId: $cityId, nameAr: $nameAr, nameEn: $nameEn, deliveryFeeHalalas: $deliveryFeeHalalas, polygon: $polygon)';
}


}

/// @nodoc
abstract mixin class _$MapDeliveryZoneCopyWith<$Res> implements $MapDeliveryZoneCopyWith<$Res> {
  factory _$MapDeliveryZoneCopyWith(_MapDeliveryZone value, $Res Function(_MapDeliveryZone) _then) = __$MapDeliveryZoneCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'city_id') int cityId,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'delivery_fee_halalas') int? deliveryFeeHalalas,@JsonKey(name: 'polygon_geojson', fromJson: _polygonFromJson, includeToJson: false) List<LatLng> polygon
});




}
/// @nodoc
class __$MapDeliveryZoneCopyWithImpl<$Res>
    implements _$MapDeliveryZoneCopyWith<$Res> {
  __$MapDeliveryZoneCopyWithImpl(this._self, this._then);

  final _MapDeliveryZone _self;
  final $Res Function(_MapDeliveryZone) _then;

/// Create a copy of MapDeliveryZone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cityId = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? deliveryFeeHalalas = freezed,Object? polygon = null,}) {
  return _then(_MapDeliveryZone(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cityId: null == cityId ? _self.cityId : cityId // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,deliveryFeeHalalas: freezed == deliveryFeeHalalas ? _self.deliveryFeeHalalas : deliveryFeeHalalas // ignore: cast_nullable_to_non_nullable
as int?,polygon: null == polygon ? _self._polygon : polygon // ignore: cast_nullable_to_non_nullable
as List<LatLng>,
  ));
}


}


/// @nodoc
mixin _$CityCenter {

 int get id;@JsonKey(name: 'name_ar') String? get nameAr;@JsonKey(name: 'name_en') String? get nameEn;@JsonKey(name: 'center_lat') double? get centerLat;@JsonKey(name: 'center_lng') double? get centerLng;@JsonKey(name: 'default_zoom') int get defaultZoom;
/// Create a copy of CityCenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityCenterCopyWith<CityCenter> get copyWith => _$CityCenterCopyWithImpl<CityCenter>(this as CityCenter, _$identity);

  /// Serializes this CityCenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityCenter&&(identical(other.id, id) || other.id == id)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.centerLat, centerLat) || other.centerLat == centerLat)&&(identical(other.centerLng, centerLng) || other.centerLng == centerLng)&&(identical(other.defaultZoom, defaultZoom) || other.defaultZoom == defaultZoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameAr,nameEn,centerLat,centerLng,defaultZoom);

@override
String toString() {
  return 'CityCenter(id: $id, nameAr: $nameAr, nameEn: $nameEn, centerLat: $centerLat, centerLng: $centerLng, defaultZoom: $defaultZoom)';
}


}

/// @nodoc
abstract mixin class $CityCenterCopyWith<$Res>  {
  factory $CityCenterCopyWith(CityCenter value, $Res Function(CityCenter) _then) = _$CityCenterCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'center_lat') double? centerLat,@JsonKey(name: 'center_lng') double? centerLng,@JsonKey(name: 'default_zoom') int defaultZoom
});




}
/// @nodoc
class _$CityCenterCopyWithImpl<$Res>
    implements $CityCenterCopyWith<$Res> {
  _$CityCenterCopyWithImpl(this._self, this._then);

  final CityCenter _self;
  final $Res Function(CityCenter) _then;

/// Create a copy of CityCenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? centerLat = freezed,Object? centerLng = freezed,Object? defaultZoom = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,centerLat: freezed == centerLat ? _self.centerLat : centerLat // ignore: cast_nullable_to_non_nullable
as double?,centerLng: freezed == centerLng ? _self.centerLng : centerLng // ignore: cast_nullable_to_non_nullable
as double?,defaultZoom: null == defaultZoom ? _self.defaultZoom : defaultZoom // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CityCenter].
extension CityCenterPatterns on CityCenter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityCenter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityCenter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityCenter value)  $default,){
final _that = this;
switch (_that) {
case _CityCenter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityCenter value)?  $default,){
final _that = this;
switch (_that) {
case _CityCenter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'center_lat')  double? centerLat, @JsonKey(name: 'center_lng')  double? centerLng, @JsonKey(name: 'default_zoom')  int defaultZoom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityCenter() when $default != null:
return $default(_that.id,_that.nameAr,_that.nameEn,_that.centerLat,_that.centerLng,_that.defaultZoom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'center_lat')  double? centerLat, @JsonKey(name: 'center_lng')  double? centerLng, @JsonKey(name: 'default_zoom')  int defaultZoom)  $default,) {final _that = this;
switch (_that) {
case _CityCenter():
return $default(_that.id,_that.nameAr,_that.nameEn,_that.centerLat,_that.centerLng,_that.defaultZoom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'name_ar')  String? nameAr, @JsonKey(name: 'name_en')  String? nameEn, @JsonKey(name: 'center_lat')  double? centerLat, @JsonKey(name: 'center_lng')  double? centerLng, @JsonKey(name: 'default_zoom')  int defaultZoom)?  $default,) {final _that = this;
switch (_that) {
case _CityCenter() when $default != null:
return $default(_that.id,_that.nameAr,_that.nameEn,_that.centerLat,_that.centerLng,_that.defaultZoom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityCenter extends CityCenter {
  const _CityCenter({required this.id, @JsonKey(name: 'name_ar') this.nameAr, @JsonKey(name: 'name_en') this.nameEn, @JsonKey(name: 'center_lat') this.centerLat, @JsonKey(name: 'center_lng') this.centerLng, @JsonKey(name: 'default_zoom') this.defaultZoom = 12}): super._();
  factory _CityCenter.fromJson(Map<String, dynamic> json) => _$CityCenterFromJson(json);

@override final  int id;
@override@JsonKey(name: 'name_ar') final  String? nameAr;
@override@JsonKey(name: 'name_en') final  String? nameEn;
@override@JsonKey(name: 'center_lat') final  double? centerLat;
@override@JsonKey(name: 'center_lng') final  double? centerLng;
@override@JsonKey(name: 'default_zoom') final  int defaultZoom;

/// Create a copy of CityCenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityCenterCopyWith<_CityCenter> get copyWith => __$CityCenterCopyWithImpl<_CityCenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityCenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityCenter&&(identical(other.id, id) || other.id == id)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.centerLat, centerLat) || other.centerLat == centerLat)&&(identical(other.centerLng, centerLng) || other.centerLng == centerLng)&&(identical(other.defaultZoom, defaultZoom) || other.defaultZoom == defaultZoom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nameAr,nameEn,centerLat,centerLng,defaultZoom);

@override
String toString() {
  return 'CityCenter(id: $id, nameAr: $nameAr, nameEn: $nameEn, centerLat: $centerLat, centerLng: $centerLng, defaultZoom: $defaultZoom)';
}


}

/// @nodoc
abstract mixin class _$CityCenterCopyWith<$Res> implements $CityCenterCopyWith<$Res> {
  factory _$CityCenterCopyWith(_CityCenter value, $Res Function(_CityCenter) _then) = __$CityCenterCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'name_ar') String? nameAr,@JsonKey(name: 'name_en') String? nameEn,@JsonKey(name: 'center_lat') double? centerLat,@JsonKey(name: 'center_lng') double? centerLng,@JsonKey(name: 'default_zoom') int defaultZoom
});




}
/// @nodoc
class __$CityCenterCopyWithImpl<$Res>
    implements _$CityCenterCopyWith<$Res> {
  __$CityCenterCopyWithImpl(this._self, this._then);

  final _CityCenter _self;
  final $Res Function(_CityCenter) _then;

/// Create a copy of CityCenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameAr = freezed,Object? nameEn = freezed,Object? centerLat = freezed,Object? centerLng = freezed,Object? defaultZoom = null,}) {
  return _then(_CityCenter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,nameEn: freezed == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String?,centerLat: freezed == centerLat ? _self.centerLat : centerLat // ignore: cast_nullable_to_non_nullable
as double?,centerLng: freezed == centerLng ? _self.centerLng : centerLng // ignore: cast_nullable_to_non_nullable
as double?,defaultZoom: null == defaultZoom ? _self.defaultZoom : defaultZoom // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DeliveryZonesResult {

@JsonKey(name: 'data') List<MapDeliveryZone> get zones;@JsonKey(readValue: _readCityCenter) CityCenter? get city;
/// Create a copy of DeliveryZonesResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeliveryZonesResultCopyWith<DeliveryZonesResult> get copyWith => _$DeliveryZonesResultCopyWithImpl<DeliveryZonesResult>(this as DeliveryZonesResult, _$identity);

  /// Serializes this DeliveryZonesResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeliveryZonesResult&&const DeepCollectionEquality().equals(other.zones, zones)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(zones),city);

@override
String toString() {
  return 'DeliveryZonesResult(zones: $zones, city: $city)';
}


}

/// @nodoc
abstract mixin class $DeliveryZonesResultCopyWith<$Res>  {
  factory $DeliveryZonesResultCopyWith(DeliveryZonesResult value, $Res Function(DeliveryZonesResult) _then) = _$DeliveryZonesResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<MapDeliveryZone> zones,@JsonKey(readValue: _readCityCenter) CityCenter? city
});


$CityCenterCopyWith<$Res>? get city;

}
/// @nodoc
class _$DeliveryZonesResultCopyWithImpl<$Res>
    implements $DeliveryZonesResultCopyWith<$Res> {
  _$DeliveryZonesResultCopyWithImpl(this._self, this._then);

  final DeliveryZonesResult _self;
  final $Res Function(DeliveryZonesResult) _then;

/// Create a copy of DeliveryZonesResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? zones = null,Object? city = freezed,}) {
  return _then(_self.copyWith(
zones: null == zones ? _self.zones : zones // ignore: cast_nullable_to_non_nullable
as List<MapDeliveryZone>,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityCenter?,
  ));
}
/// Create a copy of DeliveryZonesResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityCenterCopyWith<$Res>? get city {
    if (_self.city == null) {
    return null;
  }

  return $CityCenterCopyWith<$Res>(_self.city!, (value) {
    return _then(_self.copyWith(city: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeliveryZonesResult].
extension DeliveryZonesResultPatterns on DeliveryZonesResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeliveryZonesResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeliveryZonesResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeliveryZonesResult value)  $default,){
final _that = this;
switch (_that) {
case _DeliveryZonesResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeliveryZonesResult value)?  $default,){
final _that = this;
switch (_that) {
case _DeliveryZonesResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<MapDeliveryZone> zones, @JsonKey(readValue: _readCityCenter)  CityCenter? city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeliveryZonesResult() when $default != null:
return $default(_that.zones,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<MapDeliveryZone> zones, @JsonKey(readValue: _readCityCenter)  CityCenter? city)  $default,) {final _that = this;
switch (_that) {
case _DeliveryZonesResult():
return $default(_that.zones,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<MapDeliveryZone> zones, @JsonKey(readValue: _readCityCenter)  CityCenter? city)?  $default,) {final _that = this;
switch (_that) {
case _DeliveryZonesResult() when $default != null:
return $default(_that.zones,_that.city);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeliveryZonesResult implements DeliveryZonesResult {
  const _DeliveryZonesResult({@JsonKey(name: 'data') final  List<MapDeliveryZone> zones = const <MapDeliveryZone>[], @JsonKey(readValue: _readCityCenter) this.city}): _zones = zones;
  factory _DeliveryZonesResult.fromJson(Map<String, dynamic> json) => _$DeliveryZonesResultFromJson(json);

 final  List<MapDeliveryZone> _zones;
@override@JsonKey(name: 'data') List<MapDeliveryZone> get zones {
  if (_zones is EqualUnmodifiableListView) return _zones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_zones);
}

@override@JsonKey(readValue: _readCityCenter) final  CityCenter? city;

/// Create a copy of DeliveryZonesResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeliveryZonesResultCopyWith<_DeliveryZonesResult> get copyWith => __$DeliveryZonesResultCopyWithImpl<_DeliveryZonesResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeliveryZonesResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeliveryZonesResult&&const DeepCollectionEquality().equals(other._zones, _zones)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_zones),city);

@override
String toString() {
  return 'DeliveryZonesResult(zones: $zones, city: $city)';
}


}

/// @nodoc
abstract mixin class _$DeliveryZonesResultCopyWith<$Res> implements $DeliveryZonesResultCopyWith<$Res> {
  factory _$DeliveryZonesResultCopyWith(_DeliveryZonesResult value, $Res Function(_DeliveryZonesResult) _then) = __$DeliveryZonesResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<MapDeliveryZone> zones,@JsonKey(readValue: _readCityCenter) CityCenter? city
});


@override $CityCenterCopyWith<$Res>? get city;

}
/// @nodoc
class __$DeliveryZonesResultCopyWithImpl<$Res>
    implements _$DeliveryZonesResultCopyWith<$Res> {
  __$DeliveryZonesResultCopyWithImpl(this._self, this._then);

  final _DeliveryZonesResult _self;
  final $Res Function(_DeliveryZonesResult) _then;

/// Create a copy of DeliveryZonesResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? zones = null,Object? city = freezed,}) {
  return _then(_DeliveryZonesResult(
zones: null == zones ? _self._zones : zones // ignore: cast_nullable_to_non_nullable
as List<MapDeliveryZone>,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityCenter?,
  ));
}

/// Create a copy of DeliveryZonesResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CityCenterCopyWith<$Res>? get city {
    if (_self.city == null) {
    return null;
  }

  return $CityCenterCopyWith<$Res>(_self.city!, (value) {
    return _then(_self.copyWith(city: value));
  });
}
}

// dart format on
