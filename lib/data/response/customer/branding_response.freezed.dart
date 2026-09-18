// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branding_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Branding {

 String get primary; String get secondary; String get success; String get warning; String get danger; String get accent;/// The bundled font to use, when no file was uploaded.
@JsonKey(name: 'font_family') String get fontFamily;/// A font the panel uploaded. It wins over the bundled one once the app
/// has managed to download it.
@JsonKey(name: 'font_url') String? get fontUrl;@JsonKey(name: 'logo_url') String? get logoUrl; int get radius;
/// Create a copy of Branding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandingCopyWith<Branding> get copyWith => _$BrandingCopyWithImpl<Branding>(this as Branding, _$identity);

  /// Serializes this Branding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Branding&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.success, success) || other.success == success)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.danger, danger) || other.danger == danger)&&(identical(other.accent, accent) || other.accent == accent)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.fontUrl, fontUrl) || other.fontUrl == fontUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,primary,secondary,success,warning,danger,accent,fontFamily,fontUrl,logoUrl,radius);

@override
String toString() {
  return 'Branding(primary: $primary, secondary: $secondary, success: $success, warning: $warning, danger: $danger, accent: $accent, fontFamily: $fontFamily, fontUrl: $fontUrl, logoUrl: $logoUrl, radius: $radius)';
}


}

/// @nodoc
abstract mixin class $BrandingCopyWith<$Res>  {
  factory $BrandingCopyWith(Branding value, $Res Function(Branding) _then) = _$BrandingCopyWithImpl;
@useResult
$Res call({
 String primary, String secondary, String success, String warning, String danger, String accent,@JsonKey(name: 'font_family') String fontFamily,@JsonKey(name: 'font_url') String? fontUrl,@JsonKey(name: 'logo_url') String? logoUrl, int radius
});




}
/// @nodoc
class _$BrandingCopyWithImpl<$Res>
    implements $BrandingCopyWith<$Res> {
  _$BrandingCopyWithImpl(this._self, this._then);

  final Branding _self;
  final $Res Function(Branding) _then;

/// Create a copy of Branding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primary = null,Object? secondary = null,Object? success = null,Object? warning = null,Object? danger = null,Object? accent = null,Object? fontFamily = null,Object? fontUrl = freezed,Object? logoUrl = freezed,Object? radius = null,}) {
  return _then(_self.copyWith(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as String,secondary: null == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String,danger: null == danger ? _self.danger : danger // ignore: cast_nullable_to_non_nullable
as String,accent: null == accent ? _self.accent : accent // ignore: cast_nullable_to_non_nullable
as String,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,fontUrl: freezed == fontUrl ? _self.fontUrl : fontUrl // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Branding].
extension BrandingPatterns on Branding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Branding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Branding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Branding value)  $default,){
final _that = this;
switch (_that) {
case _Branding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Branding value)?  $default,){
final _that = this;
switch (_that) {
case _Branding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String primary,  String secondary,  String success,  String warning,  String danger,  String accent, @JsonKey(name: 'font_family')  String fontFamily, @JsonKey(name: 'font_url')  String? fontUrl, @JsonKey(name: 'logo_url')  String? logoUrl,  int radius)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Branding() when $default != null:
return $default(_that.primary,_that.secondary,_that.success,_that.warning,_that.danger,_that.accent,_that.fontFamily,_that.fontUrl,_that.logoUrl,_that.radius);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String primary,  String secondary,  String success,  String warning,  String danger,  String accent, @JsonKey(name: 'font_family')  String fontFamily, @JsonKey(name: 'font_url')  String? fontUrl, @JsonKey(name: 'logo_url')  String? logoUrl,  int radius)  $default,) {final _that = this;
switch (_that) {
case _Branding():
return $default(_that.primary,_that.secondary,_that.success,_that.warning,_that.danger,_that.accent,_that.fontFamily,_that.fontUrl,_that.logoUrl,_that.radius);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String primary,  String secondary,  String success,  String warning,  String danger,  String accent, @JsonKey(name: 'font_family')  String fontFamily, @JsonKey(name: 'font_url')  String? fontUrl, @JsonKey(name: 'logo_url')  String? logoUrl,  int radius)?  $default,) {final _that = this;
switch (_that) {
case _Branding() when $default != null:
return $default(_that.primary,_that.secondary,_that.success,_that.warning,_that.danger,_that.accent,_that.fontFamily,_that.fontUrl,_that.logoUrl,_that.radius);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Branding extends Branding {
  const _Branding({this.primary = '#5130EC', this.secondary = '#A45C5C', this.success = '#2A9C64', this.warning = '#E1712A', this.danger = '#EF4444', this.accent = '#FFC120', @JsonKey(name: 'font_family') this.fontFamily = 'ibmp_plex_sans_arabic', @JsonKey(name: 'font_url') this.fontUrl, @JsonKey(name: 'logo_url') this.logoUrl, this.radius = 16}): super._();
  factory _Branding.fromJson(Map<String, dynamic> json) => _$BrandingFromJson(json);

@override@JsonKey() final  String primary;
@override@JsonKey() final  String secondary;
@override@JsonKey() final  String success;
@override@JsonKey() final  String warning;
@override@JsonKey() final  String danger;
@override@JsonKey() final  String accent;
/// The bundled font to use, when no file was uploaded.
@override@JsonKey(name: 'font_family') final  String fontFamily;
/// A font the panel uploaded. It wins over the bundled one once the app
/// has managed to download it.
@override@JsonKey(name: 'font_url') final  String? fontUrl;
@override@JsonKey(name: 'logo_url') final  String? logoUrl;
@override@JsonKey() final  int radius;

/// Create a copy of Branding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandingCopyWith<_Branding> get copyWith => __$BrandingCopyWithImpl<_Branding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BrandingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Branding&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.success, success) || other.success == success)&&(identical(other.warning, warning) || other.warning == warning)&&(identical(other.danger, danger) || other.danger == danger)&&(identical(other.accent, accent) || other.accent == accent)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.fontUrl, fontUrl) || other.fontUrl == fontUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,primary,secondary,success,warning,danger,accent,fontFamily,fontUrl,logoUrl,radius);

@override
String toString() {
  return 'Branding(primary: $primary, secondary: $secondary, success: $success, warning: $warning, danger: $danger, accent: $accent, fontFamily: $fontFamily, fontUrl: $fontUrl, logoUrl: $logoUrl, radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$BrandingCopyWith<$Res> implements $BrandingCopyWith<$Res> {
  factory _$BrandingCopyWith(_Branding value, $Res Function(_Branding) _then) = __$BrandingCopyWithImpl;
@override @useResult
$Res call({
 String primary, String secondary, String success, String warning, String danger, String accent,@JsonKey(name: 'font_family') String fontFamily,@JsonKey(name: 'font_url') String? fontUrl,@JsonKey(name: 'logo_url') String? logoUrl, int radius
});




}
/// @nodoc
class __$BrandingCopyWithImpl<$Res>
    implements _$BrandingCopyWith<$Res> {
  __$BrandingCopyWithImpl(this._self, this._then);

  final _Branding _self;
  final $Res Function(_Branding) _then;

/// Create a copy of Branding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? primary = null,Object? secondary = null,Object? success = null,Object? warning = null,Object? danger = null,Object? accent = null,Object? fontFamily = null,Object? fontUrl = freezed,Object? logoUrl = freezed,Object? radius = null,}) {
  return _then(_Branding(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as String,secondary: null == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as String,success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as String,danger: null == danger ? _self.danger : danger // ignore: cast_nullable_to_non_nullable
as String,accent: null == accent ? _self.accent : accent // ignore: cast_nullable_to_non_nullable
as String,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,fontUrl: freezed == fontUrl ? _self.fontUrl : fontUrl // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
