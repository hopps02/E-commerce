// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthInitRequest {

@Query('email') String get email;@Query('birth_date')@DateTimeConverter() DateTime get birthDate;
/// Create a copy of AuthInitRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthInitRequestCopyWith<AuthInitRequest> get copyWith => _$AuthInitRequestCopyWithImpl<AuthInitRequest>(this as AuthInitRequest, _$identity);

  /// Serializes this AuthInitRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthInitRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,birthDate);

@override
String toString() {
  return 'AuthInitRequest(email: $email, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class $AuthInitRequestCopyWith<$Res>  {
  factory $AuthInitRequestCopyWith(AuthInitRequest value, $Res Function(AuthInitRequest) _then) = _$AuthInitRequestCopyWithImpl;
@useResult
$Res call({
@Query('email') String email,@Query('birth_date')@DateTimeConverter() DateTime birthDate
});




}
/// @nodoc
class _$AuthInitRequestCopyWithImpl<$Res>
    implements $AuthInitRequestCopyWith<$Res> {
  _$AuthInitRequestCopyWithImpl(this._self, this._then);

  final AuthInitRequest _self;
  final $Res Function(AuthInitRequest) _then;

/// Create a copy of AuthInitRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? birthDate = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthInitRequest].
extension AuthInitRequestPatterns on AuthInitRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthInitRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthInitRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthInitRequest value)  $default,){
final _that = this;
switch (_that) {
case _AuthInitRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthInitRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AuthInitRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@Query('email')  String email, @Query('birth_date')@DateTimeConverter()  DateTime birthDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthInitRequest() when $default != null:
return $default(_that.email,_that.birthDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@Query('email')  String email, @Query('birth_date')@DateTimeConverter()  DateTime birthDate)  $default,) {final _that = this;
switch (_that) {
case _AuthInitRequest():
return $default(_that.email,_that.birthDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@Query('email')  String email, @Query('birth_date')@DateTimeConverter()  DateTime birthDate)?  $default,) {final _that = this;
switch (_that) {
case _AuthInitRequest() when $default != null:
return $default(_that.email,_that.birthDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthInitRequest implements AuthInitRequest {
  const _AuthInitRequest({@Query('email') required this.email, @Query('birth_date')@DateTimeConverter() required this.birthDate});
  factory _AuthInitRequest.fromJson(Map<String, dynamic> json) => _$AuthInitRequestFromJson(json);

@override@Query('email') final  String email;
@override@Query('birth_date')@DateTimeConverter() final  DateTime birthDate;

/// Create a copy of AuthInitRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthInitRequestCopyWith<_AuthInitRequest> get copyWith => __$AuthInitRequestCopyWithImpl<_AuthInitRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthInitRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthInitRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,birthDate);

@override
String toString() {
  return 'AuthInitRequest(email: $email, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class _$AuthInitRequestCopyWith<$Res> implements $AuthInitRequestCopyWith<$Res> {
  factory _$AuthInitRequestCopyWith(_AuthInitRequest value, $Res Function(_AuthInitRequest) _then) = __$AuthInitRequestCopyWithImpl;
@override @useResult
$Res call({
@Query('email') String email,@Query('birth_date')@DateTimeConverter() DateTime birthDate
});




}
/// @nodoc
class __$AuthInitRequestCopyWithImpl<$Res>
    implements _$AuthInitRequestCopyWith<$Res> {
  __$AuthInitRequestCopyWithImpl(this._self, this._then);

  final _AuthInitRequest _self;
  final $Res Function(_AuthInitRequest) _then;

/// Create a copy of AuthInitRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? birthDate = null,}) {
  return _then(_AuthInitRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
