// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestOtpBody {

 String get phone;
/// Create a copy of RequestOtpBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestOtpBodyCopyWith<RequestOtpBody> get copyWith => _$RequestOtpBodyCopyWithImpl<RequestOtpBody>(this as RequestOtpBody, _$identity);

  /// Serializes this RequestOtpBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestOtpBody&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'RequestOtpBody(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $RequestOtpBodyCopyWith<$Res>  {
  factory $RequestOtpBodyCopyWith(RequestOtpBody value, $Res Function(RequestOtpBody) _then) = _$RequestOtpBodyCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$RequestOtpBodyCopyWithImpl<$Res>
    implements $RequestOtpBodyCopyWith<$Res> {
  _$RequestOtpBodyCopyWithImpl(this._self, this._then);

  final RequestOtpBody _self;
  final $Res Function(RequestOtpBody) _then;

/// Create a copy of RequestOtpBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestOtpBody].
extension RequestOtpBodyPatterns on RequestOtpBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestOtpBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestOtpBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestOtpBody value)  $default,){
final _that = this;
switch (_that) {
case _RequestOtpBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestOtpBody value)?  $default,){
final _that = this;
switch (_that) {
case _RequestOtpBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestOtpBody() when $default != null:
return $default(_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone)  $default,) {final _that = this;
switch (_that) {
case _RequestOtpBody():
return $default(_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone)?  $default,) {final _that = this;
switch (_that) {
case _RequestOtpBody() when $default != null:
return $default(_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestOtpBody implements RequestOtpBody {
  const _RequestOtpBody({required this.phone});
  factory _RequestOtpBody.fromJson(Map<String, dynamic> json) => _$RequestOtpBodyFromJson(json);

@override final  String phone;

/// Create a copy of RequestOtpBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestOtpBodyCopyWith<_RequestOtpBody> get copyWith => __$RequestOtpBodyCopyWithImpl<_RequestOtpBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestOtpBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestOtpBody&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'RequestOtpBody(phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$RequestOtpBodyCopyWith<$Res> implements $RequestOtpBodyCopyWith<$Res> {
  factory _$RequestOtpBodyCopyWith(_RequestOtpBody value, $Res Function(_RequestOtpBody) _then) = __$RequestOtpBodyCopyWithImpl;
@override @useResult
$Res call({
 String phone
});




}
/// @nodoc
class __$RequestOtpBodyCopyWithImpl<$Res>
    implements _$RequestOtpBodyCopyWith<$Res> {
  __$RequestOtpBodyCopyWithImpl(this._self, this._then);

  final _RequestOtpBody _self;
  final $Res Function(_RequestOtpBody) _then;

/// Create a copy of RequestOtpBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(_RequestOtpBody(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VerifyOtpBody {

 String get phone; String get code;
/// Create a copy of VerifyOtpBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpBodyCopyWith<VerifyOtpBody> get copyWith => _$VerifyOtpBodyCopyWithImpl<VerifyOtpBody>(this as VerifyOtpBody, _$identity);

  /// Serializes this VerifyOtpBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpBody&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone,code);

@override
String toString() {
  return 'VerifyOtpBody(phone: $phone, code: $code)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpBodyCopyWith<$Res>  {
  factory $VerifyOtpBodyCopyWith(VerifyOtpBody value, $Res Function(VerifyOtpBody) _then) = _$VerifyOtpBodyCopyWithImpl;
@useResult
$Res call({
 String phone, String code
});




}
/// @nodoc
class _$VerifyOtpBodyCopyWithImpl<$Res>
    implements $VerifyOtpBodyCopyWith<$Res> {
  _$VerifyOtpBodyCopyWithImpl(this._self, this._then);

  final VerifyOtpBody _self;
  final $Res Function(VerifyOtpBody) _then;

/// Create a copy of VerifyOtpBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? code = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpBody].
extension VerifyOtpBodyPatterns on VerifyOtpBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyOtpBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOtpBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyOtpBody value)  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyOtpBody value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phone,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOtpBody() when $default != null:
return $default(_that.phone,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phone,  String code)  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpBody():
return $default(_that.phone,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phone,  String code)?  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpBody() when $default != null:
return $default(_that.phone,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyOtpBody implements VerifyOtpBody {
  const _VerifyOtpBody({required this.phone, required this.code});
  factory _VerifyOtpBody.fromJson(Map<String, dynamic> json) => _$VerifyOtpBodyFromJson(json);

@override final  String phone;
@override final  String code;

/// Create a copy of VerifyOtpBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpBodyCopyWith<_VerifyOtpBody> get copyWith => __$VerifyOtpBodyCopyWithImpl<_VerifyOtpBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyOtpBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpBody&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phone,code);

@override
String toString() {
  return 'VerifyOtpBody(phone: $phone, code: $code)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpBodyCopyWith<$Res> implements $VerifyOtpBodyCopyWith<$Res> {
  factory _$VerifyOtpBodyCopyWith(_VerifyOtpBody value, $Res Function(_VerifyOtpBody) _then) = __$VerifyOtpBodyCopyWithImpl;
@override @useResult
$Res call({
 String phone, String code
});




}
/// @nodoc
class __$VerifyOtpBodyCopyWithImpl<$Res>
    implements _$VerifyOtpBodyCopyWith<$Res> {
  __$VerifyOtpBodyCopyWithImpl(this._self, this._then);

  final _VerifyOtpBody _self;
  final $Res Function(_VerifyOtpBody) _then;

/// Create a copy of VerifyOtpBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? code = null,}) {
  return _then(_VerifyOtpBody(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegisterDeviceBody {

 String get token; String get platform; String get locale;@JsonKey(name: 'app_version') String? get appVersion;
/// Create a copy of RegisterDeviceBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterDeviceBodyCopyWith<RegisterDeviceBody> get copyWith => _$RegisterDeviceBodyCopyWithImpl<RegisterDeviceBody>(this as RegisterDeviceBody, _$identity);

  /// Serializes this RegisterDeviceBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterDeviceBody&&(identical(other.token, token) || other.token == token)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,platform,locale,appVersion);

@override
String toString() {
  return 'RegisterDeviceBody(token: $token, platform: $platform, locale: $locale, appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class $RegisterDeviceBodyCopyWith<$Res>  {
  factory $RegisterDeviceBodyCopyWith(RegisterDeviceBody value, $Res Function(RegisterDeviceBody) _then) = _$RegisterDeviceBodyCopyWithImpl;
@useResult
$Res call({
 String token, String platform, String locale,@JsonKey(name: 'app_version') String? appVersion
});




}
/// @nodoc
class _$RegisterDeviceBodyCopyWithImpl<$Res>
    implements $RegisterDeviceBodyCopyWith<$Res> {
  _$RegisterDeviceBodyCopyWithImpl(this._self, this._then);

  final RegisterDeviceBody _self;
  final $Res Function(RegisterDeviceBody) _then;

/// Create a copy of RegisterDeviceBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? platform = null,Object? locale = null,Object? appVersion = freezed,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterDeviceBody].
extension RegisterDeviceBodyPatterns on RegisterDeviceBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterDeviceBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterDeviceBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterDeviceBody value)  $default,){
final _that = this;
switch (_that) {
case _RegisterDeviceBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterDeviceBody value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterDeviceBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  String platform,  String locale, @JsonKey(name: 'app_version')  String? appVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterDeviceBody() when $default != null:
return $default(_that.token,_that.platform,_that.locale,_that.appVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  String platform,  String locale, @JsonKey(name: 'app_version')  String? appVersion)  $default,) {final _that = this;
switch (_that) {
case _RegisterDeviceBody():
return $default(_that.token,_that.platform,_that.locale,_that.appVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  String platform,  String locale, @JsonKey(name: 'app_version')  String? appVersion)?  $default,) {final _that = this;
switch (_that) {
case _RegisterDeviceBody() when $default != null:
return $default(_that.token,_that.platform,_that.locale,_that.appVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterDeviceBody implements RegisterDeviceBody {
  const _RegisterDeviceBody({required this.token, required this.platform, required this.locale, @JsonKey(name: 'app_version') this.appVersion});
  factory _RegisterDeviceBody.fromJson(Map<String, dynamic> json) => _$RegisterDeviceBodyFromJson(json);

@override final  String token;
@override final  String platform;
@override final  String locale;
@override@JsonKey(name: 'app_version') final  String? appVersion;

/// Create a copy of RegisterDeviceBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterDeviceBodyCopyWith<_RegisterDeviceBody> get copyWith => __$RegisterDeviceBodyCopyWithImpl<_RegisterDeviceBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterDeviceBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterDeviceBody&&(identical(other.token, token) || other.token == token)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,platform,locale,appVersion);

@override
String toString() {
  return 'RegisterDeviceBody(token: $token, platform: $platform, locale: $locale, appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class _$RegisterDeviceBodyCopyWith<$Res> implements $RegisterDeviceBodyCopyWith<$Res> {
  factory _$RegisterDeviceBodyCopyWith(_RegisterDeviceBody value, $Res Function(_RegisterDeviceBody) _then) = __$RegisterDeviceBodyCopyWithImpl;
@override @useResult
$Res call({
 String token, String platform, String locale,@JsonKey(name: 'app_version') String? appVersion
});




}
/// @nodoc
class __$RegisterDeviceBodyCopyWithImpl<$Res>
    implements _$RegisterDeviceBodyCopyWith<$Res> {
  __$RegisterDeviceBodyCopyWithImpl(this._self, this._then);

  final _RegisterDeviceBody _self;
  final $Res Function(_RegisterDeviceBody) _then;

/// Create a copy of RegisterDeviceBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? platform = null,Object? locale = null,Object? appVersion = freezed,}) {
  return _then(_RegisterDeviceBody(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
