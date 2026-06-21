// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceSuggestion {

@JsonKey(name: 'place_id') String get placeId;@JsonKey(name: 'primary_text') String get primaryText;@JsonKey(name: 'secondary_text') String? get secondaryText; String get description;
/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceSuggestionCopyWith<PlaceSuggestion> get copyWith => _$PlaceSuggestionCopyWithImpl<PlaceSuggestion>(this as PlaceSuggestion, _$identity);

  /// Serializes this PlaceSuggestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSuggestion&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.primaryText, primaryText) || other.primaryText == primaryText)&&(identical(other.secondaryText, secondaryText) || other.secondaryText == secondaryText)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,primaryText,secondaryText,description);

@override
String toString() {
  return 'PlaceSuggestion(placeId: $placeId, primaryText: $primaryText, secondaryText: $secondaryText, description: $description)';
}


}

/// @nodoc
abstract mixin class $PlaceSuggestionCopyWith<$Res>  {
  factory $PlaceSuggestionCopyWith(PlaceSuggestion value, $Res Function(PlaceSuggestion) _then) = _$PlaceSuggestionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'place_id') String placeId,@JsonKey(name: 'primary_text') String primaryText,@JsonKey(name: 'secondary_text') String? secondaryText, String description
});




}
/// @nodoc
class _$PlaceSuggestionCopyWithImpl<$Res>
    implements $PlaceSuggestionCopyWith<$Res> {
  _$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final PlaceSuggestion _self;
  final $Res Function(PlaceSuggestion) _then;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? primaryText = null,Object? secondaryText = freezed,Object? description = null,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,primaryText: null == primaryText ? _self.primaryText : primaryText // ignore: cast_nullable_to_non_nullable
as String,secondaryText: freezed == secondaryText ? _self.secondaryText : secondaryText // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceSuggestion].
extension PlaceSuggestionPatterns on PlaceSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'place_id')  String placeId, @JsonKey(name: 'primary_text')  String primaryText, @JsonKey(name: 'secondary_text')  String? secondaryText,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
return $default(_that.placeId,_that.primaryText,_that.secondaryText,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'place_id')  String placeId, @JsonKey(name: 'primary_text')  String primaryText, @JsonKey(name: 'secondary_text')  String? secondaryText,  String description)  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestion():
return $default(_that.placeId,_that.primaryText,_that.secondaryText,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'place_id')  String placeId, @JsonKey(name: 'primary_text')  String primaryText, @JsonKey(name: 'secondary_text')  String? secondaryText,  String description)?  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
return $default(_that.placeId,_that.primaryText,_that.secondaryText,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceSuggestion implements PlaceSuggestion {
  const _PlaceSuggestion({@JsonKey(name: 'place_id') required this.placeId, @JsonKey(name: 'primary_text') required this.primaryText, @JsonKey(name: 'secondary_text') this.secondaryText, required this.description});
  factory _PlaceSuggestion.fromJson(Map<String, dynamic> json) => _$PlaceSuggestionFromJson(json);

@override@JsonKey(name: 'place_id') final  String placeId;
@override@JsonKey(name: 'primary_text') final  String primaryText;
@override@JsonKey(name: 'secondary_text') final  String? secondaryText;
@override final  String description;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceSuggestionCopyWith<_PlaceSuggestion> get copyWith => __$PlaceSuggestionCopyWithImpl<_PlaceSuggestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceSuggestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceSuggestion&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.primaryText, primaryText) || other.primaryText == primaryText)&&(identical(other.secondaryText, secondaryText) || other.secondaryText == secondaryText)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,primaryText,secondaryText,description);

@override
String toString() {
  return 'PlaceSuggestion(placeId: $placeId, primaryText: $primaryText, secondaryText: $secondaryText, description: $description)';
}


}

/// @nodoc
abstract mixin class _$PlaceSuggestionCopyWith<$Res> implements $PlaceSuggestionCopyWith<$Res> {
  factory _$PlaceSuggestionCopyWith(_PlaceSuggestion value, $Res Function(_PlaceSuggestion) _then) = __$PlaceSuggestionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'place_id') String placeId,@JsonKey(name: 'primary_text') String primaryText,@JsonKey(name: 'secondary_text') String? secondaryText, String description
});




}
/// @nodoc
class __$PlaceSuggestionCopyWithImpl<$Res>
    implements _$PlaceSuggestionCopyWith<$Res> {
  __$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final _PlaceSuggestion _self;
  final $Res Function(_PlaceSuggestion) _then;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? primaryText = null,Object? secondaryText = freezed,Object? description = null,}) {
  return _then(_PlaceSuggestion(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,primaryText: null == primaryText ? _self.primaryText : primaryText // ignore: cast_nullable_to_non_nullable
as String,secondaryText: freezed == secondaryText ? _self.secondaryText : secondaryText // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PlaceLocation {

 double get lat; double get lng; String? get name; String? get address;
/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceLocationCopyWith<PlaceLocation> get copyWith => _$PlaceLocationCopyWithImpl<PlaceLocation>(this as PlaceLocation, _$identity);

  /// Serializes this PlaceLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceLocation&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lng,name,address);

@override
String toString() {
  return 'PlaceLocation(lat: $lat, lng: $lng, name: $name, address: $address)';
}


}

/// @nodoc
abstract mixin class $PlaceLocationCopyWith<$Res>  {
  factory $PlaceLocationCopyWith(PlaceLocation value, $Res Function(PlaceLocation) _then) = _$PlaceLocationCopyWithImpl;
@useResult
$Res call({
 double lat, double lng, String? name, String? address
});




}
/// @nodoc
class _$PlaceLocationCopyWithImpl<$Res>
    implements $PlaceLocationCopyWith<$Res> {
  _$PlaceLocationCopyWithImpl(this._self, this._then);

  final PlaceLocation _self;
  final $Res Function(PlaceLocation) _then;

/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,Object? name = freezed,Object? address = freezed,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceLocation].
extension PlaceLocationPatterns on PlaceLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceLocation value)  $default,){
final _that = this;
switch (_that) {
case _PlaceLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceLocation value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lng,  String? name,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceLocation() when $default != null:
return $default(_that.lat,_that.lng,_that.name,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lng,  String? name,  String? address)  $default,) {final _that = this;
switch (_that) {
case _PlaceLocation():
return $default(_that.lat,_that.lng,_that.name,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lng,  String? name,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _PlaceLocation() when $default != null:
return $default(_that.lat,_that.lng,_that.name,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceLocation implements PlaceLocation {
  const _PlaceLocation({required this.lat, required this.lng, this.name, this.address});
  factory _PlaceLocation.fromJson(Map<String, dynamic> json) => _$PlaceLocationFromJson(json);

@override final  double lat;
@override final  double lng;
@override final  String? name;
@override final  String? address;

/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceLocationCopyWith<_PlaceLocation> get copyWith => __$PlaceLocationCopyWithImpl<_PlaceLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceLocation&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lng,name,address);

@override
String toString() {
  return 'PlaceLocation(lat: $lat, lng: $lng, name: $name, address: $address)';
}


}

/// @nodoc
abstract mixin class _$PlaceLocationCopyWith<$Res> implements $PlaceLocationCopyWith<$Res> {
  factory _$PlaceLocationCopyWith(_PlaceLocation value, $Res Function(_PlaceLocation) _then) = __$PlaceLocationCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng, String? name, String? address
});




}
/// @nodoc
class __$PlaceLocationCopyWithImpl<$Res>
    implements _$PlaceLocationCopyWith<$Res> {
  __$PlaceLocationCopyWithImpl(this._self, this._then);

  final _PlaceLocation _self;
  final $Res Function(_PlaceLocation) _then;

/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,Object? name = freezed,Object? address = freezed,}) {
  return _then(_PlaceLocation(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PlacesAutocompleteResult {

@JsonKey(name: 'data') List<PlaceSuggestion> get suggestions;
/// Create a copy of PlacesAutocompleteResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacesAutocompleteResultCopyWith<PlacesAutocompleteResult> get copyWith => _$PlacesAutocompleteResultCopyWithImpl<PlacesAutocompleteResult>(this as PlacesAutocompleteResult, _$identity);

  /// Serializes this PlacesAutocompleteResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesAutocompleteResult&&const DeepCollectionEquality().equals(other.suggestions, suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(suggestions));

@override
String toString() {
  return 'PlacesAutocompleteResult(suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class $PlacesAutocompleteResultCopyWith<$Res>  {
  factory $PlacesAutocompleteResultCopyWith(PlacesAutocompleteResult value, $Res Function(PlacesAutocompleteResult) _then) = _$PlacesAutocompleteResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') List<PlaceSuggestion> suggestions
});




}
/// @nodoc
class _$PlacesAutocompleteResultCopyWithImpl<$Res>
    implements $PlacesAutocompleteResultCopyWith<$Res> {
  _$PlacesAutocompleteResultCopyWithImpl(this._self, this._then);

  final PlacesAutocompleteResult _self;
  final $Res Function(PlacesAutocompleteResult) _then;

/// Create a copy of PlacesAutocompleteResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestions = null,}) {
  return _then(_self.copyWith(
suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<PlaceSuggestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacesAutocompleteResult].
extension PlacesAutocompleteResultPatterns on PlacesAutocompleteResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacesAutocompleteResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacesAutocompleteResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacesAutocompleteResult value)  $default,){
final _that = this;
switch (_that) {
case _PlacesAutocompleteResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacesAutocompleteResult value)?  $default,){
final _that = this;
switch (_that) {
case _PlacesAutocompleteResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<PlaceSuggestion> suggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacesAutocompleteResult() when $default != null:
return $default(_that.suggestions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  List<PlaceSuggestion> suggestions)  $default,) {final _that = this;
switch (_that) {
case _PlacesAutocompleteResult():
return $default(_that.suggestions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  List<PlaceSuggestion> suggestions)?  $default,) {final _that = this;
switch (_that) {
case _PlacesAutocompleteResult() when $default != null:
return $default(_that.suggestions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacesAutocompleteResult implements PlacesAutocompleteResult {
  const _PlacesAutocompleteResult({@JsonKey(name: 'data') final  List<PlaceSuggestion> suggestions = const <PlaceSuggestion>[]}): _suggestions = suggestions;
  factory _PlacesAutocompleteResult.fromJson(Map<String, dynamic> json) => _$PlacesAutocompleteResultFromJson(json);

 final  List<PlaceSuggestion> _suggestions;
@override@JsonKey(name: 'data') List<PlaceSuggestion> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}


/// Create a copy of PlacesAutocompleteResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacesAutocompleteResultCopyWith<_PlacesAutocompleteResult> get copyWith => __$PlacesAutocompleteResultCopyWithImpl<_PlacesAutocompleteResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacesAutocompleteResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacesAutocompleteResult&&const DeepCollectionEquality().equals(other._suggestions, _suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_suggestions));

@override
String toString() {
  return 'PlacesAutocompleteResult(suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class _$PlacesAutocompleteResultCopyWith<$Res> implements $PlacesAutocompleteResultCopyWith<$Res> {
  factory _$PlacesAutocompleteResultCopyWith(_PlacesAutocompleteResult value, $Res Function(_PlacesAutocompleteResult) _then) = __$PlacesAutocompleteResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') List<PlaceSuggestion> suggestions
});




}
/// @nodoc
class __$PlacesAutocompleteResultCopyWithImpl<$Res>
    implements _$PlacesAutocompleteResultCopyWith<$Res> {
  __$PlacesAutocompleteResultCopyWithImpl(this._self, this._then);

  final _PlacesAutocompleteResult _self;
  final $Res Function(_PlacesAutocompleteResult) _then;

/// Create a copy of PlacesAutocompleteResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestions = null,}) {
  return _then(_PlacesAutocompleteResult(
suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<PlaceSuggestion>,
  ));
}


}


/// @nodoc
mixin _$PlaceDetailsResult {

@JsonKey(name: 'data') PlaceLocation get location;
/// Create a copy of PlaceDetailsResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDetailsResultCopyWith<PlaceDetailsResult> get copyWith => _$PlaceDetailsResultCopyWithImpl<PlaceDetailsResult>(this as PlaceDetailsResult, _$identity);

  /// Serializes this PlaceDetailsResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDetailsResult&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'PlaceDetailsResult(location: $location)';
}


}

/// @nodoc
abstract mixin class $PlaceDetailsResultCopyWith<$Res>  {
  factory $PlaceDetailsResultCopyWith(PlaceDetailsResult value, $Res Function(PlaceDetailsResult) _then) = _$PlaceDetailsResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'data') PlaceLocation location
});


$PlaceLocationCopyWith<$Res> get location;

}
/// @nodoc
class _$PlaceDetailsResultCopyWithImpl<$Res>
    implements $PlaceDetailsResultCopyWith<$Res> {
  _$PlaceDetailsResultCopyWithImpl(this._self, this._then);

  final PlaceDetailsResult _self;
  final $Res Function(PlaceDetailsResult) _then;

/// Create a copy of PlaceDetailsResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as PlaceLocation,
  ));
}
/// Create a copy of PlaceDetailsResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceLocationCopyWith<$Res> get location {
  
  return $PlaceLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceDetailsResult].
extension PlaceDetailsResultPatterns on PlaceDetailsResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDetailsResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDetailsResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDetailsResult value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailsResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDetailsResult value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailsResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  PlaceLocation location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDetailsResult() when $default != null:
return $default(_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'data')  PlaceLocation location)  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailsResult():
return $default(_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'data')  PlaceLocation location)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailsResult() when $default != null:
return $default(_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceDetailsResult implements PlaceDetailsResult {
  const _PlaceDetailsResult({@JsonKey(name: 'data') required this.location});
  factory _PlaceDetailsResult.fromJson(Map<String, dynamic> json) => _$PlaceDetailsResultFromJson(json);

@override@JsonKey(name: 'data') final  PlaceLocation location;

/// Create a copy of PlaceDetailsResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDetailsResultCopyWith<_PlaceDetailsResult> get copyWith => __$PlaceDetailsResultCopyWithImpl<_PlaceDetailsResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceDetailsResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDetailsResult&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'PlaceDetailsResult(location: $location)';
}


}

/// @nodoc
abstract mixin class _$PlaceDetailsResultCopyWith<$Res> implements $PlaceDetailsResultCopyWith<$Res> {
  factory _$PlaceDetailsResultCopyWith(_PlaceDetailsResult value, $Res Function(_PlaceDetailsResult) _then) = __$PlaceDetailsResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'data') PlaceLocation location
});


@override $PlaceLocationCopyWith<$Res> get location;

}
/// @nodoc
class __$PlaceDetailsResultCopyWithImpl<$Res>
    implements _$PlaceDetailsResultCopyWith<$Res> {
  __$PlaceDetailsResultCopyWithImpl(this._self, this._then);

  final _PlaceDetailsResult _self;
  final $Res Function(_PlaceDetailsResult) _then;

/// Create a copy of PlaceDetailsResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,}) {
  return _then(_PlaceDetailsResult(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as PlaceLocation,
  ));
}

/// Create a copy of PlaceDetailsResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceLocationCopyWith<$Res> get location {
  
  return $PlaceLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
