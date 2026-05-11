// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthInitResponse {

 bool get success; String get message; bool get registered;@JsonKey(name: 'created_at')@DateTimeConverter() DateTime get createdAt;@JsonKey(name: 'last_login_at')@NullableDateTimeConverter() DateTime? get lastLoginAt;
/// Create a copy of AuthInitResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthInitResponseCopyWith<AuthInitResponse> get copyWith => _$AuthInitResponseCopyWithImpl<AuthInitResponse>(this as AuthInitResponse, _$identity);

  /// Serializes this AuthInitResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthInitResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.registered, registered) || other.registered == registered)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,registered,createdAt,lastLoginAt);

@override
String toString() {
  return 'AuthInitResponse(success: $success, message: $message, registered: $registered, createdAt: $createdAt, lastLoginAt: $lastLoginAt)';
}


}

/// @nodoc
abstract mixin class $AuthInitResponseCopyWith<$Res>  {
  factory $AuthInitResponseCopyWith(AuthInitResponse value, $Res Function(AuthInitResponse) _then) = _$AuthInitResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, bool registered,@JsonKey(name: 'created_at')@DateTimeConverter() DateTime createdAt,@JsonKey(name: 'last_login_at')@NullableDateTimeConverter() DateTime? lastLoginAt
});




}
/// @nodoc
class _$AuthInitResponseCopyWithImpl<$Res>
    implements $AuthInitResponseCopyWith<$Res> {
  _$AuthInitResponseCopyWithImpl(this._self, this._then);

  final AuthInitResponse _self;
  final $Res Function(AuthInitResponse) _then;

/// Create a copy of AuthInitResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? registered = null,Object? createdAt = null,Object? lastLoginAt = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthInitResponse].
extension AuthInitResponsePatterns on AuthInitResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthInitResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthInitResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthInitResponse value)  $default,){
final _that = this;
switch (_that) {
case _AuthInitResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthInitResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AuthInitResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  bool registered, @JsonKey(name: 'created_at')@DateTimeConverter()  DateTime createdAt, @JsonKey(name: 'last_login_at')@NullableDateTimeConverter()  DateTime? lastLoginAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthInitResponse() when $default != null:
return $default(_that.success,_that.message,_that.registered,_that.createdAt,_that.lastLoginAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  bool registered, @JsonKey(name: 'created_at')@DateTimeConverter()  DateTime createdAt, @JsonKey(name: 'last_login_at')@NullableDateTimeConverter()  DateTime? lastLoginAt)  $default,) {final _that = this;
switch (_that) {
case _AuthInitResponse():
return $default(_that.success,_that.message,_that.registered,_that.createdAt,_that.lastLoginAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  bool registered, @JsonKey(name: 'created_at')@DateTimeConverter()  DateTime createdAt, @JsonKey(name: 'last_login_at')@NullableDateTimeConverter()  DateTime? lastLoginAt)?  $default,) {final _that = this;
switch (_that) {
case _AuthInitResponse() when $default != null:
return $default(_that.success,_that.message,_that.registered,_that.createdAt,_that.lastLoginAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthInitResponse implements AuthInitResponse {
  const _AuthInitResponse({this.success = true, this.message = '', this.registered = false, @JsonKey(name: 'created_at')@DateTimeConverter() required this.createdAt, @JsonKey(name: 'last_login_at')@NullableDateTimeConverter() this.lastLoginAt});
  factory _AuthInitResponse.fromJson(Map<String, dynamic> json) => _$AuthInitResponseFromJson(json);

@override@JsonKey() final  bool success;
@override@JsonKey() final  String message;
@override@JsonKey() final  bool registered;
@override@JsonKey(name: 'created_at')@DateTimeConverter() final  DateTime createdAt;
@override@JsonKey(name: 'last_login_at')@NullableDateTimeConverter() final  DateTime? lastLoginAt;

/// Create a copy of AuthInitResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthInitResponseCopyWith<_AuthInitResponse> get copyWith => __$AuthInitResponseCopyWithImpl<_AuthInitResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthInitResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthInitResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.registered, registered) || other.registered == registered)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,registered,createdAt,lastLoginAt);

@override
String toString() {
  return 'AuthInitResponse(success: $success, message: $message, registered: $registered, createdAt: $createdAt, lastLoginAt: $lastLoginAt)';
}


}

/// @nodoc
abstract mixin class _$AuthInitResponseCopyWith<$Res> implements $AuthInitResponseCopyWith<$Res> {
  factory _$AuthInitResponseCopyWith(_AuthInitResponse value, $Res Function(_AuthInitResponse) _then) = __$AuthInitResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, bool registered,@JsonKey(name: 'created_at')@DateTimeConverter() DateTime createdAt,@JsonKey(name: 'last_login_at')@NullableDateTimeConverter() DateTime? lastLoginAt
});




}
/// @nodoc
class __$AuthInitResponseCopyWithImpl<$Res>
    implements _$AuthInitResponseCopyWith<$Res> {
  __$AuthInitResponseCopyWithImpl(this._self, this._then);

  final _AuthInitResponse _self;
  final $Res Function(_AuthInitResponse) _then;

/// Create a copy of AuthInitResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? registered = null,Object? createdAt = null,Object? lastLoginAt = freezed,}) {
  return _then(_AuthInitResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,registered: null == registered ? _self.registered : registered // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
