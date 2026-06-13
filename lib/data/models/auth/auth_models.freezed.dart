// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

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


/// @nodoc
mixin _$OtpRequested {

@JsonKey(name: 'expires_in_seconds') int get expiresInSeconds;@JsonKey(name: 'resend_after_seconds') int get resendAfterSeconds;@JsonKey(name: 'masked_phone') String? get maskedPhone;
/// Create a copy of OtpRequested
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpRequestedCopyWith<OtpRequested> get copyWith => _$OtpRequestedCopyWithImpl<OtpRequested>(this as OtpRequested, _$identity);

  /// Serializes this OtpRequested to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpRequested&&(identical(other.expiresInSeconds, expiresInSeconds) || other.expiresInSeconds == expiresInSeconds)&&(identical(other.resendAfterSeconds, resendAfterSeconds) || other.resendAfterSeconds == resendAfterSeconds)&&(identical(other.maskedPhone, maskedPhone) || other.maskedPhone == maskedPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresInSeconds,resendAfterSeconds,maskedPhone);

@override
String toString() {
  return 'OtpRequested(expiresInSeconds: $expiresInSeconds, resendAfterSeconds: $resendAfterSeconds, maskedPhone: $maskedPhone)';
}


}

/// @nodoc
abstract mixin class $OtpRequestedCopyWith<$Res>  {
  factory $OtpRequestedCopyWith(OtpRequested value, $Res Function(OtpRequested) _then) = _$OtpRequestedCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'expires_in_seconds') int expiresInSeconds,@JsonKey(name: 'resend_after_seconds') int resendAfterSeconds,@JsonKey(name: 'masked_phone') String? maskedPhone
});




}
/// @nodoc
class _$OtpRequestedCopyWithImpl<$Res>
    implements $OtpRequestedCopyWith<$Res> {
  _$OtpRequestedCopyWithImpl(this._self, this._then);

  final OtpRequested _self;
  final $Res Function(OtpRequested) _then;

/// Create a copy of OtpRequested
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expiresInSeconds = null,Object? resendAfterSeconds = null,Object? maskedPhone = freezed,}) {
  return _then(_self.copyWith(
expiresInSeconds: null == expiresInSeconds ? _self.expiresInSeconds : expiresInSeconds // ignore: cast_nullable_to_non_nullable
as int,resendAfterSeconds: null == resendAfterSeconds ? _self.resendAfterSeconds : resendAfterSeconds // ignore: cast_nullable_to_non_nullable
as int,maskedPhone: freezed == maskedPhone ? _self.maskedPhone : maskedPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpRequested].
extension OtpRequestedPatterns on OtpRequested {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpRequested value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpRequested() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpRequested value)  $default,){
final _that = this;
switch (_that) {
case _OtpRequested():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpRequested value)?  $default,){
final _that = this;
switch (_that) {
case _OtpRequested() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'expires_in_seconds')  int expiresInSeconds, @JsonKey(name: 'resend_after_seconds')  int resendAfterSeconds, @JsonKey(name: 'masked_phone')  String? maskedPhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpRequested() when $default != null:
return $default(_that.expiresInSeconds,_that.resendAfterSeconds,_that.maskedPhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'expires_in_seconds')  int expiresInSeconds, @JsonKey(name: 'resend_after_seconds')  int resendAfterSeconds, @JsonKey(name: 'masked_phone')  String? maskedPhone)  $default,) {final _that = this;
switch (_that) {
case _OtpRequested():
return $default(_that.expiresInSeconds,_that.resendAfterSeconds,_that.maskedPhone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'expires_in_seconds')  int expiresInSeconds, @JsonKey(name: 'resend_after_seconds')  int resendAfterSeconds, @JsonKey(name: 'masked_phone')  String? maskedPhone)?  $default,) {final _that = this;
switch (_that) {
case _OtpRequested() when $default != null:
return $default(_that.expiresInSeconds,_that.resendAfterSeconds,_that.maskedPhone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtpRequested implements OtpRequested {
  const _OtpRequested({@JsonKey(name: 'expires_in_seconds') required this.expiresInSeconds, @JsonKey(name: 'resend_after_seconds') required this.resendAfterSeconds, @JsonKey(name: 'masked_phone') this.maskedPhone});
  factory _OtpRequested.fromJson(Map<String, dynamic> json) => _$OtpRequestedFromJson(json);

@override@JsonKey(name: 'expires_in_seconds') final  int expiresInSeconds;
@override@JsonKey(name: 'resend_after_seconds') final  int resendAfterSeconds;
@override@JsonKey(name: 'masked_phone') final  String? maskedPhone;

/// Create a copy of OtpRequested
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpRequestedCopyWith<_OtpRequested> get copyWith => __$OtpRequestedCopyWithImpl<_OtpRequested>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpRequestedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpRequested&&(identical(other.expiresInSeconds, expiresInSeconds) || other.expiresInSeconds == expiresInSeconds)&&(identical(other.resendAfterSeconds, resendAfterSeconds) || other.resendAfterSeconds == resendAfterSeconds)&&(identical(other.maskedPhone, maskedPhone) || other.maskedPhone == maskedPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresInSeconds,resendAfterSeconds,maskedPhone);

@override
String toString() {
  return 'OtpRequested(expiresInSeconds: $expiresInSeconds, resendAfterSeconds: $resendAfterSeconds, maskedPhone: $maskedPhone)';
}


}

/// @nodoc
abstract mixin class _$OtpRequestedCopyWith<$Res> implements $OtpRequestedCopyWith<$Res> {
  factory _$OtpRequestedCopyWith(_OtpRequested value, $Res Function(_OtpRequested) _then) = __$OtpRequestedCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'expires_in_seconds') int expiresInSeconds,@JsonKey(name: 'resend_after_seconds') int resendAfterSeconds,@JsonKey(name: 'masked_phone') String? maskedPhone
});




}
/// @nodoc
class __$OtpRequestedCopyWithImpl<$Res>
    implements _$OtpRequestedCopyWith<$Res> {
  __$OtpRequestedCopyWithImpl(this._self, this._then);

  final _OtpRequested _self;
  final $Res Function(_OtpRequested) _then;

/// Create a copy of OtpRequested
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expiresInSeconds = null,Object? resendAfterSeconds = null,Object? maskedPhone = freezed,}) {
  return _then(_OtpRequested(
expiresInSeconds: null == expiresInSeconds ? _self.expiresInSeconds : expiresInSeconds // ignore: cast_nullable_to_non_nullable
as int,resendAfterSeconds: null == resendAfterSeconds ? _self.resendAfterSeconds : resendAfterSeconds // ignore: cast_nullable_to_non_nullable
as int,maskedPhone: freezed == maskedPhone ? _self.maskedPhone : maskedPhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MobileAccountInfo {

 int get id; String get phone; String get role; String get status;@JsonKey(name: 'preferred_locale') String get preferredLocale;
/// Create a copy of MobileAccountInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MobileAccountInfoCopyWith<MobileAccountInfo> get copyWith => _$MobileAccountInfoCopyWithImpl<MobileAccountInfo>(this as MobileAccountInfo, _$identity);

  /// Serializes this MobileAccountInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MobileAccountInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.preferredLocale, preferredLocale) || other.preferredLocale == preferredLocale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,role,status,preferredLocale);

@override
String toString() {
  return 'MobileAccountInfo(id: $id, phone: $phone, role: $role, status: $status, preferredLocale: $preferredLocale)';
}


}

/// @nodoc
abstract mixin class $MobileAccountInfoCopyWith<$Res>  {
  factory $MobileAccountInfoCopyWith(MobileAccountInfo value, $Res Function(MobileAccountInfo) _then) = _$MobileAccountInfoCopyWithImpl;
@useResult
$Res call({
 int id, String phone, String role, String status,@JsonKey(name: 'preferred_locale') String preferredLocale
});




}
/// @nodoc
class _$MobileAccountInfoCopyWithImpl<$Res>
    implements $MobileAccountInfoCopyWith<$Res> {
  _$MobileAccountInfoCopyWithImpl(this._self, this._then);

  final MobileAccountInfo _self;
  final $Res Function(MobileAccountInfo) _then;

/// Create a copy of MobileAccountInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phone = null,Object? role = null,Object? status = null,Object? preferredLocale = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,preferredLocale: null == preferredLocale ? _self.preferredLocale : preferredLocale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MobileAccountInfo].
extension MobileAccountInfoPatterns on MobileAccountInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MobileAccountInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MobileAccountInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MobileAccountInfo value)  $default,){
final _that = this;
switch (_that) {
case _MobileAccountInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MobileAccountInfo value)?  $default,){
final _that = this;
switch (_that) {
case _MobileAccountInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String phone,  String role,  String status, @JsonKey(name: 'preferred_locale')  String preferredLocale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MobileAccountInfo() when $default != null:
return $default(_that.id,_that.phone,_that.role,_that.status,_that.preferredLocale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String phone,  String role,  String status, @JsonKey(name: 'preferred_locale')  String preferredLocale)  $default,) {final _that = this;
switch (_that) {
case _MobileAccountInfo():
return $default(_that.id,_that.phone,_that.role,_that.status,_that.preferredLocale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String phone,  String role,  String status, @JsonKey(name: 'preferred_locale')  String preferredLocale)?  $default,) {final _that = this;
switch (_that) {
case _MobileAccountInfo() when $default != null:
return $default(_that.id,_that.phone,_that.role,_that.status,_that.preferredLocale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MobileAccountInfo implements MobileAccountInfo {
  const _MobileAccountInfo({required this.id, required this.phone, required this.role, required this.status, @JsonKey(name: 'preferred_locale') required this.preferredLocale});
  factory _MobileAccountInfo.fromJson(Map<String, dynamic> json) => _$MobileAccountInfoFromJson(json);

@override final  int id;
@override final  String phone;
@override final  String role;
@override final  String status;
@override@JsonKey(name: 'preferred_locale') final  String preferredLocale;

/// Create a copy of MobileAccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MobileAccountInfoCopyWith<_MobileAccountInfo> get copyWith => __$MobileAccountInfoCopyWithImpl<_MobileAccountInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MobileAccountInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MobileAccountInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.preferredLocale, preferredLocale) || other.preferredLocale == preferredLocale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,role,status,preferredLocale);

@override
String toString() {
  return 'MobileAccountInfo(id: $id, phone: $phone, role: $role, status: $status, preferredLocale: $preferredLocale)';
}


}

/// @nodoc
abstract mixin class _$MobileAccountInfoCopyWith<$Res> implements $MobileAccountInfoCopyWith<$Res> {
  factory _$MobileAccountInfoCopyWith(_MobileAccountInfo value, $Res Function(_MobileAccountInfo) _then) = __$MobileAccountInfoCopyWithImpl;
@override @useResult
$Res call({
 int id, String phone, String role, String status,@JsonKey(name: 'preferred_locale') String preferredLocale
});




}
/// @nodoc
class __$MobileAccountInfoCopyWithImpl<$Res>
    implements _$MobileAccountInfoCopyWith<$Res> {
  __$MobileAccountInfoCopyWithImpl(this._self, this._then);

  final _MobileAccountInfo _self;
  final $Res Function(_MobileAccountInfo) _then;

/// Create a copy of MobileAccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phone = null,Object? role = null,Object? status = null,Object? preferredLocale = null,}) {
  return _then(_MobileAccountInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,preferredLocale: null == preferredLocale ? _self.preferredLocale : preferredLocale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AuthSession {

@JsonKey(name: 'access_token') String? get accessToken;@JsonKey(name: 'token_type') String? get tokenType; MobileAccountInfo get account;@JsonKey(name: 'active_role') String get activeRole; Map<String, dynamic>? get profile; Map<String, dynamic> get scopes;@JsonKey(name: 'next_screen') String? get nextScreen; bool get blocked;// True only for a brand-new signup — the welcome screen shows just then.
@JsonKey(name: 'is_new') bool get isNew;
/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSessionCopyWith<AuthSession> get copyWith => _$AuthSessionCopyWithImpl<AuthSession>(this as AuthSession, _$identity);

  /// Serializes this AuthSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSession&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.account, account) || other.account == account)&&(identical(other.activeRole, activeRole) || other.activeRole == activeRole)&&const DeepCollectionEquality().equals(other.profile, profile)&&const DeepCollectionEquality().equals(other.scopes, scopes)&&(identical(other.nextScreen, nextScreen) || other.nextScreen == nextScreen)&&(identical(other.blocked, blocked) || other.blocked == blocked)&&(identical(other.isNew, isNew) || other.isNew == isNew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,tokenType,account,activeRole,const DeepCollectionEquality().hash(profile),const DeepCollectionEquality().hash(scopes),nextScreen,blocked,isNew);

@override
String toString() {
  return 'AuthSession(accessToken: $accessToken, tokenType: $tokenType, account: $account, activeRole: $activeRole, profile: $profile, scopes: $scopes, nextScreen: $nextScreen, blocked: $blocked, isNew: $isNew)';
}


}

/// @nodoc
abstract mixin class $AuthSessionCopyWith<$Res>  {
  factory $AuthSessionCopyWith(AuthSession value, $Res Function(AuthSession) _then) = _$AuthSessionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'token_type') String? tokenType, MobileAccountInfo account,@JsonKey(name: 'active_role') String activeRole, Map<String, dynamic>? profile, Map<String, dynamic> scopes,@JsonKey(name: 'next_screen') String? nextScreen, bool blocked,@JsonKey(name: 'is_new') bool isNew
});


$MobileAccountInfoCopyWith<$Res> get account;

}
/// @nodoc
class _$AuthSessionCopyWithImpl<$Res>
    implements $AuthSessionCopyWith<$Res> {
  _$AuthSessionCopyWithImpl(this._self, this._then);

  final AuthSession _self;
  final $Res Function(AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,Object? tokenType = freezed,Object? account = null,Object? activeRole = null,Object? profile = freezed,Object? scopes = null,Object? nextScreen = freezed,Object? blocked = null,Object? isNew = null,}) {
  return _then(_self.copyWith(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MobileAccountInfo,activeRole: null == activeRole ? _self.activeRole : activeRole // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,scopes: null == scopes ? _self.scopes : scopes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,nextScreen: freezed == nextScreen ? _self.nextScreen : nextScreen // ignore: cast_nullable_to_non_nullable
as String?,blocked: null == blocked ? _self.blocked : blocked // ignore: cast_nullable_to_non_nullable
as bool,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MobileAccountInfoCopyWith<$Res> get account {
  
  return $MobileAccountInfoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthSession].
extension AuthSessionPatterns on AuthSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthSession value)  $default,){
final _that = this;
switch (_that) {
case _AuthSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthSession value)?  $default,){
final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'token_type')  String? tokenType,  MobileAccountInfo account, @JsonKey(name: 'active_role')  String activeRole,  Map<String, dynamic>? profile,  Map<String, dynamic> scopes, @JsonKey(name: 'next_screen')  String? nextScreen,  bool blocked, @JsonKey(name: 'is_new')  bool isNew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.accessToken,_that.tokenType,_that.account,_that.activeRole,_that.profile,_that.scopes,_that.nextScreen,_that.blocked,_that.isNew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'token_type')  String? tokenType,  MobileAccountInfo account, @JsonKey(name: 'active_role')  String activeRole,  Map<String, dynamic>? profile,  Map<String, dynamic> scopes, @JsonKey(name: 'next_screen')  String? nextScreen,  bool blocked, @JsonKey(name: 'is_new')  bool isNew)  $default,) {final _that = this;
switch (_that) {
case _AuthSession():
return $default(_that.accessToken,_that.tokenType,_that.account,_that.activeRole,_that.profile,_that.scopes,_that.nextScreen,_that.blocked,_that.isNew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'token_type')  String? tokenType,  MobileAccountInfo account, @JsonKey(name: 'active_role')  String activeRole,  Map<String, dynamic>? profile,  Map<String, dynamic> scopes, @JsonKey(name: 'next_screen')  String? nextScreen,  bool blocked, @JsonKey(name: 'is_new')  bool isNew)?  $default,) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.accessToken,_that.tokenType,_that.account,_that.activeRole,_that.profile,_that.scopes,_that.nextScreen,_that.blocked,_that.isNew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthSession extends AuthSession {
  const _AuthSession({@JsonKey(name: 'access_token') this.accessToken, @JsonKey(name: 'token_type') this.tokenType, required this.account, @JsonKey(name: 'active_role') required this.activeRole, final  Map<String, dynamic>? profile, final  Map<String, dynamic> scopes = const <String, dynamic>{}, @JsonKey(name: 'next_screen') this.nextScreen, this.blocked = false, @JsonKey(name: 'is_new') this.isNew = false}): _profile = profile,_scopes = scopes,super._();
  factory _AuthSession.fromJson(Map<String, dynamic> json) => _$AuthSessionFromJson(json);

@override@JsonKey(name: 'access_token') final  String? accessToken;
@override@JsonKey(name: 'token_type') final  String? tokenType;
@override final  MobileAccountInfo account;
@override@JsonKey(name: 'active_role') final  String activeRole;
 final  Map<String, dynamic>? _profile;
@override Map<String, dynamic>? get profile {
  final value = _profile;
  if (value == null) return null;
  if (_profile is EqualUnmodifiableMapView) return _profile;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic> _scopes;
@override@JsonKey() Map<String, dynamic> get scopes {
  if (_scopes is EqualUnmodifiableMapView) return _scopes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scopes);
}

@override@JsonKey(name: 'next_screen') final  String? nextScreen;
@override@JsonKey() final  bool blocked;
// True only for a brand-new signup — the welcome screen shows just then.
@override@JsonKey(name: 'is_new') final  bool isNew;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSessionCopyWith<_AuthSession> get copyWith => __$AuthSessionCopyWithImpl<_AuthSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSession&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.account, account) || other.account == account)&&(identical(other.activeRole, activeRole) || other.activeRole == activeRole)&&const DeepCollectionEquality().equals(other._profile, _profile)&&const DeepCollectionEquality().equals(other._scopes, _scopes)&&(identical(other.nextScreen, nextScreen) || other.nextScreen == nextScreen)&&(identical(other.blocked, blocked) || other.blocked == blocked)&&(identical(other.isNew, isNew) || other.isNew == isNew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,tokenType,account,activeRole,const DeepCollectionEquality().hash(_profile),const DeepCollectionEquality().hash(_scopes),nextScreen,blocked,isNew);

@override
String toString() {
  return 'AuthSession(accessToken: $accessToken, tokenType: $tokenType, account: $account, activeRole: $activeRole, profile: $profile, scopes: $scopes, nextScreen: $nextScreen, blocked: $blocked, isNew: $isNew)';
}


}

/// @nodoc
abstract mixin class _$AuthSessionCopyWith<$Res> implements $AuthSessionCopyWith<$Res> {
  factory _$AuthSessionCopyWith(_AuthSession value, $Res Function(_AuthSession) _then) = __$AuthSessionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'token_type') String? tokenType, MobileAccountInfo account,@JsonKey(name: 'active_role') String activeRole, Map<String, dynamic>? profile, Map<String, dynamic> scopes,@JsonKey(name: 'next_screen') String? nextScreen, bool blocked,@JsonKey(name: 'is_new') bool isNew
});


@override $MobileAccountInfoCopyWith<$Res> get account;

}
/// @nodoc
class __$AuthSessionCopyWithImpl<$Res>
    implements _$AuthSessionCopyWith<$Res> {
  __$AuthSessionCopyWithImpl(this._self, this._then);

  final _AuthSession _self;
  final $Res Function(_AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,Object? tokenType = freezed,Object? account = null,Object? activeRole = null,Object? profile = freezed,Object? scopes = null,Object? nextScreen = freezed,Object? blocked = null,Object? isNew = null,}) {
  return _then(_AuthSession(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MobileAccountInfo,activeRole: null == activeRole ? _self.activeRole : activeRole // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self._profile : profile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,scopes: null == scopes ? _self._scopes : scopes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,nextScreen: freezed == nextScreen ? _self.nextScreen : nextScreen // ignore: cast_nullable_to_non_nullable
as String?,blocked: null == blocked ? _self.blocked : blocked // ignore: cast_nullable_to_non_nullable
as bool,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MobileAccountInfoCopyWith<$Res> get account {
  
  return $MobileAccountInfoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// @nodoc
mixin _$MeData {

 MobileAccountInfo get account;@JsonKey(name: 'active_role') String get activeRole; Map<String, dynamic>? get profile; Map<String, dynamic> get scopes;
/// Create a copy of MeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeDataCopyWith<MeData> get copyWith => _$MeDataCopyWithImpl<MeData>(this as MeData, _$identity);

  /// Serializes this MeData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeData&&(identical(other.account, account) || other.account == account)&&(identical(other.activeRole, activeRole) || other.activeRole == activeRole)&&const DeepCollectionEquality().equals(other.profile, profile)&&const DeepCollectionEquality().equals(other.scopes, scopes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,account,activeRole,const DeepCollectionEquality().hash(profile),const DeepCollectionEquality().hash(scopes));

@override
String toString() {
  return 'MeData(account: $account, activeRole: $activeRole, profile: $profile, scopes: $scopes)';
}


}

/// @nodoc
abstract mixin class $MeDataCopyWith<$Res>  {
  factory $MeDataCopyWith(MeData value, $Res Function(MeData) _then) = _$MeDataCopyWithImpl;
@useResult
$Res call({
 MobileAccountInfo account,@JsonKey(name: 'active_role') String activeRole, Map<String, dynamic>? profile, Map<String, dynamic> scopes
});


$MobileAccountInfoCopyWith<$Res> get account;

}
/// @nodoc
class _$MeDataCopyWithImpl<$Res>
    implements $MeDataCopyWith<$Res> {
  _$MeDataCopyWithImpl(this._self, this._then);

  final MeData _self;
  final $Res Function(MeData) _then;

/// Create a copy of MeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? activeRole = null,Object? profile = freezed,Object? scopes = null,}) {
  return _then(_self.copyWith(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MobileAccountInfo,activeRole: null == activeRole ? _self.activeRole : activeRole // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,scopes: null == scopes ? _self.scopes : scopes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of MeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MobileAccountInfoCopyWith<$Res> get account {
  
  return $MobileAccountInfoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [MeData].
extension MeDataPatterns on MeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeData value)  $default,){
final _that = this;
switch (_that) {
case _MeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeData value)?  $default,){
final _that = this;
switch (_that) {
case _MeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MobileAccountInfo account, @JsonKey(name: 'active_role')  String activeRole,  Map<String, dynamic>? profile,  Map<String, dynamic> scopes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeData() when $default != null:
return $default(_that.account,_that.activeRole,_that.profile,_that.scopes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MobileAccountInfo account, @JsonKey(name: 'active_role')  String activeRole,  Map<String, dynamic>? profile,  Map<String, dynamic> scopes)  $default,) {final _that = this;
switch (_that) {
case _MeData():
return $default(_that.account,_that.activeRole,_that.profile,_that.scopes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MobileAccountInfo account, @JsonKey(name: 'active_role')  String activeRole,  Map<String, dynamic>? profile,  Map<String, dynamic> scopes)?  $default,) {final _that = this;
switch (_that) {
case _MeData() when $default != null:
return $default(_that.account,_that.activeRole,_that.profile,_that.scopes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeData extends MeData {
  const _MeData({required this.account, @JsonKey(name: 'active_role') required this.activeRole, final  Map<String, dynamic>? profile, final  Map<String, dynamic> scopes = const <String, dynamic>{}}): _profile = profile,_scopes = scopes,super._();
  factory _MeData.fromJson(Map<String, dynamic> json) => _$MeDataFromJson(json);

@override final  MobileAccountInfo account;
@override@JsonKey(name: 'active_role') final  String activeRole;
 final  Map<String, dynamic>? _profile;
@override Map<String, dynamic>? get profile {
  final value = _profile;
  if (value == null) return null;
  if (_profile is EqualUnmodifiableMapView) return _profile;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic> _scopes;
@override@JsonKey() Map<String, dynamic> get scopes {
  if (_scopes is EqualUnmodifiableMapView) return _scopes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scopes);
}


/// Create a copy of MeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeDataCopyWith<_MeData> get copyWith => __$MeDataCopyWithImpl<_MeData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeData&&(identical(other.account, account) || other.account == account)&&(identical(other.activeRole, activeRole) || other.activeRole == activeRole)&&const DeepCollectionEquality().equals(other._profile, _profile)&&const DeepCollectionEquality().equals(other._scopes, _scopes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,account,activeRole,const DeepCollectionEquality().hash(_profile),const DeepCollectionEquality().hash(_scopes));

@override
String toString() {
  return 'MeData(account: $account, activeRole: $activeRole, profile: $profile, scopes: $scopes)';
}


}

/// @nodoc
abstract mixin class _$MeDataCopyWith<$Res> implements $MeDataCopyWith<$Res> {
  factory _$MeDataCopyWith(_MeData value, $Res Function(_MeData) _then) = __$MeDataCopyWithImpl;
@override @useResult
$Res call({
 MobileAccountInfo account,@JsonKey(name: 'active_role') String activeRole, Map<String, dynamic>? profile, Map<String, dynamic> scopes
});


@override $MobileAccountInfoCopyWith<$Res> get account;

}
/// @nodoc
class __$MeDataCopyWithImpl<$Res>
    implements _$MeDataCopyWith<$Res> {
  __$MeDataCopyWithImpl(this._self, this._then);

  final _MeData _self;
  final $Res Function(_MeData) _then;

/// Create a copy of MeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? activeRole = null,Object? profile = freezed,Object? scopes = null,}) {
  return _then(_MeData(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MobileAccountInfo,activeRole: null == activeRole ? _self.activeRole : activeRole // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self._profile : profile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,scopes: null == scopes ? _self._scopes : scopes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of MeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MobileAccountInfoCopyWith<$Res> get account {
  
  return $MobileAccountInfoCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
