// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

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

@JsonKey(name: 'access_token') String? get accessToken;@JsonKey(name: 'token_type') String? get tokenType;@JsonKey(name: 'refresh_token') String? get refreshToken;@JsonKey(name: 'expires_in') int? get expiresIn; MobileAccountInfo get account;@JsonKey(name: 'active_role') String get activeRole; Map<String, dynamic>? get profile; Map<String, dynamic> get scopes;@JsonKey(name: 'next_screen') String? get nextScreen; bool get blocked;// True only for a brand-new signup — the welcome screen shows just then.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSession&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.account, account) || other.account == account)&&(identical(other.activeRole, activeRole) || other.activeRole == activeRole)&&const DeepCollectionEquality().equals(other.profile, profile)&&const DeepCollectionEquality().equals(other.scopes, scopes)&&(identical(other.nextScreen, nextScreen) || other.nextScreen == nextScreen)&&(identical(other.blocked, blocked) || other.blocked == blocked)&&(identical(other.isNew, isNew) || other.isNew == isNew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,tokenType,refreshToken,expiresIn,account,activeRole,const DeepCollectionEquality().hash(profile),const DeepCollectionEquality().hash(scopes),nextScreen,blocked,isNew);

@override
String toString() {
  return 'AuthSession(accessToken: $accessToken, tokenType: $tokenType, refreshToken: $refreshToken, expiresIn: $expiresIn, account: $account, activeRole: $activeRole, profile: $profile, scopes: $scopes, nextScreen: $nextScreen, blocked: $blocked, isNew: $isNew)';
}


}

/// @nodoc
abstract mixin class $AuthSessionCopyWith<$Res>  {
  factory $AuthSessionCopyWith(AuthSession value, $Res Function(AuthSession) _then) = _$AuthSessionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'token_type') String? tokenType,@JsonKey(name: 'refresh_token') String? refreshToken,@JsonKey(name: 'expires_in') int? expiresIn, MobileAccountInfo account,@JsonKey(name: 'active_role') String activeRole, Map<String, dynamic>? profile, Map<String, dynamic> scopes,@JsonKey(name: 'next_screen') String? nextScreen, bool blocked,@JsonKey(name: 'is_new') bool isNew
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
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,Object? tokenType = freezed,Object? refreshToken = freezed,Object? expiresIn = freezed,Object? account = null,Object? activeRole = null,Object? profile = freezed,Object? scopes = null,Object? nextScreen = freezed,Object? blocked = null,Object? isNew = null,}) {
  return _then(_self.copyWith(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'token_type')  String? tokenType, @JsonKey(name: 'refresh_token')  String? refreshToken, @JsonKey(name: 'expires_in')  int? expiresIn,  MobileAccountInfo account, @JsonKey(name: 'active_role')  String activeRole,  Map<String, dynamic>? profile,  Map<String, dynamic> scopes, @JsonKey(name: 'next_screen')  String? nextScreen,  bool blocked, @JsonKey(name: 'is_new')  bool isNew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.accessToken,_that.tokenType,_that.refreshToken,_that.expiresIn,_that.account,_that.activeRole,_that.profile,_that.scopes,_that.nextScreen,_that.blocked,_that.isNew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'token_type')  String? tokenType, @JsonKey(name: 'refresh_token')  String? refreshToken, @JsonKey(name: 'expires_in')  int? expiresIn,  MobileAccountInfo account, @JsonKey(name: 'active_role')  String activeRole,  Map<String, dynamic>? profile,  Map<String, dynamic> scopes, @JsonKey(name: 'next_screen')  String? nextScreen,  bool blocked, @JsonKey(name: 'is_new')  bool isNew)  $default,) {final _that = this;
switch (_that) {
case _AuthSession():
return $default(_that.accessToken,_that.tokenType,_that.refreshToken,_that.expiresIn,_that.account,_that.activeRole,_that.profile,_that.scopes,_that.nextScreen,_that.blocked,_that.isNew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'access_token')  String? accessToken, @JsonKey(name: 'token_type')  String? tokenType, @JsonKey(name: 'refresh_token')  String? refreshToken, @JsonKey(name: 'expires_in')  int? expiresIn,  MobileAccountInfo account, @JsonKey(name: 'active_role')  String activeRole,  Map<String, dynamic>? profile,  Map<String, dynamic> scopes, @JsonKey(name: 'next_screen')  String? nextScreen,  bool blocked, @JsonKey(name: 'is_new')  bool isNew)?  $default,) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.accessToken,_that.tokenType,_that.refreshToken,_that.expiresIn,_that.account,_that.activeRole,_that.profile,_that.scopes,_that.nextScreen,_that.blocked,_that.isNew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthSession extends AuthSession {
  const _AuthSession({@JsonKey(name: 'access_token') this.accessToken, @JsonKey(name: 'token_type') this.tokenType, @JsonKey(name: 'refresh_token') this.refreshToken, @JsonKey(name: 'expires_in') this.expiresIn, required this.account, @JsonKey(name: 'active_role') required this.activeRole, final  Map<String, dynamic>? profile, final  Map<String, dynamic> scopes = const <String, dynamic>{}, @JsonKey(name: 'next_screen') this.nextScreen, this.blocked = false, @JsonKey(name: 'is_new') this.isNew = false}): _profile = profile,_scopes = scopes,super._();
  factory _AuthSession.fromJson(Map<String, dynamic> json) => _$AuthSessionFromJson(json);

@override@JsonKey(name: 'access_token') final  String? accessToken;
@override@JsonKey(name: 'token_type') final  String? tokenType;
@override@JsonKey(name: 'refresh_token') final  String? refreshToken;
@override@JsonKey(name: 'expires_in') final  int? expiresIn;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSession&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.account, account) || other.account == account)&&(identical(other.activeRole, activeRole) || other.activeRole == activeRole)&&const DeepCollectionEquality().equals(other._profile, _profile)&&const DeepCollectionEquality().equals(other._scopes, _scopes)&&(identical(other.nextScreen, nextScreen) || other.nextScreen == nextScreen)&&(identical(other.blocked, blocked) || other.blocked == blocked)&&(identical(other.isNew, isNew) || other.isNew == isNew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,tokenType,refreshToken,expiresIn,account,activeRole,const DeepCollectionEquality().hash(_profile),const DeepCollectionEquality().hash(_scopes),nextScreen,blocked,isNew);

@override
String toString() {
  return 'AuthSession(accessToken: $accessToken, tokenType: $tokenType, refreshToken: $refreshToken, expiresIn: $expiresIn, account: $account, activeRole: $activeRole, profile: $profile, scopes: $scopes, nextScreen: $nextScreen, blocked: $blocked, isNew: $isNew)';
}


}

/// @nodoc
abstract mixin class _$AuthSessionCopyWith<$Res> implements $AuthSessionCopyWith<$Res> {
  factory _$AuthSessionCopyWith(_AuthSession value, $Res Function(_AuthSession) _then) = __$AuthSessionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'token_type') String? tokenType,@JsonKey(name: 'refresh_token') String? refreshToken,@JsonKey(name: 'expires_in') int? expiresIn, MobileAccountInfo account,@JsonKey(name: 'active_role') String activeRole, Map<String, dynamic>? profile, Map<String, dynamic> scopes,@JsonKey(name: 'next_screen') String? nextScreen, bool blocked,@JsonKey(name: 'is_new') bool isNew
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
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,Object? tokenType = freezed,Object? refreshToken = freezed,Object? expiresIn = freezed,Object? account = null,Object? activeRole = null,Object? profile = freezed,Object? scopes = null,Object? nextScreen = freezed,Object? blocked = null,Object? isNew = null,}) {
  return _then(_AuthSession(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
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
