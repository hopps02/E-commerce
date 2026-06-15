// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RateOrderBody {

@JsonKey(name: 'overall_stars') int get overallStars;@JsonKey(name: 'captain_stars') int get captainStars;@JsonKey(name: 'order_accuracy_stars') int get orderAccuracyStars;@JsonKey(name: 'delivery_speed_stars') int get deliverySpeedStars; String? get comment;
/// Create a copy of RateOrderBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateOrderBodyCopyWith<RateOrderBody> get copyWith => _$RateOrderBodyCopyWithImpl<RateOrderBody>(this as RateOrderBody, _$identity);

  /// Serializes this RateOrderBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateOrderBody&&(identical(other.overallStars, overallStars) || other.overallStars == overallStars)&&(identical(other.captainStars, captainStars) || other.captainStars == captainStars)&&(identical(other.orderAccuracyStars, orderAccuracyStars) || other.orderAccuracyStars == orderAccuracyStars)&&(identical(other.deliverySpeedStars, deliverySpeedStars) || other.deliverySpeedStars == deliverySpeedStars)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overallStars,captainStars,orderAccuracyStars,deliverySpeedStars,comment);

@override
String toString() {
  return 'RateOrderBody(overallStars: $overallStars, captainStars: $captainStars, orderAccuracyStars: $orderAccuracyStars, deliverySpeedStars: $deliverySpeedStars, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $RateOrderBodyCopyWith<$Res>  {
  factory $RateOrderBodyCopyWith(RateOrderBody value, $Res Function(RateOrderBody) _then) = _$RateOrderBodyCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'overall_stars') int overallStars,@JsonKey(name: 'captain_stars') int captainStars,@JsonKey(name: 'order_accuracy_stars') int orderAccuracyStars,@JsonKey(name: 'delivery_speed_stars') int deliverySpeedStars, String? comment
});




}
/// @nodoc
class _$RateOrderBodyCopyWithImpl<$Res>
    implements $RateOrderBodyCopyWith<$Res> {
  _$RateOrderBodyCopyWithImpl(this._self, this._then);

  final RateOrderBody _self;
  final $Res Function(RateOrderBody) _then;

/// Create a copy of RateOrderBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overallStars = null,Object? captainStars = null,Object? orderAccuracyStars = null,Object? deliverySpeedStars = null,Object? comment = freezed,}) {
  return _then(_self.copyWith(
overallStars: null == overallStars ? _self.overallStars : overallStars // ignore: cast_nullable_to_non_nullable
as int,captainStars: null == captainStars ? _self.captainStars : captainStars // ignore: cast_nullable_to_non_nullable
as int,orderAccuracyStars: null == orderAccuracyStars ? _self.orderAccuracyStars : orderAccuracyStars // ignore: cast_nullable_to_non_nullable
as int,deliverySpeedStars: null == deliverySpeedStars ? _self.deliverySpeedStars : deliverySpeedStars // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RateOrderBody].
extension RateOrderBodyPatterns on RateOrderBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateOrderBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateOrderBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateOrderBody value)  $default,){
final _that = this;
switch (_that) {
case _RateOrderBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateOrderBody value)?  $default,){
final _that = this;
switch (_that) {
case _RateOrderBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'overall_stars')  int overallStars, @JsonKey(name: 'captain_stars')  int captainStars, @JsonKey(name: 'order_accuracy_stars')  int orderAccuracyStars, @JsonKey(name: 'delivery_speed_stars')  int deliverySpeedStars,  String? comment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateOrderBody() when $default != null:
return $default(_that.overallStars,_that.captainStars,_that.orderAccuracyStars,_that.deliverySpeedStars,_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'overall_stars')  int overallStars, @JsonKey(name: 'captain_stars')  int captainStars, @JsonKey(name: 'order_accuracy_stars')  int orderAccuracyStars, @JsonKey(name: 'delivery_speed_stars')  int deliverySpeedStars,  String? comment)  $default,) {final _that = this;
switch (_that) {
case _RateOrderBody():
return $default(_that.overallStars,_that.captainStars,_that.orderAccuracyStars,_that.deliverySpeedStars,_that.comment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'overall_stars')  int overallStars, @JsonKey(name: 'captain_stars')  int captainStars, @JsonKey(name: 'order_accuracy_stars')  int orderAccuracyStars, @JsonKey(name: 'delivery_speed_stars')  int deliverySpeedStars,  String? comment)?  $default,) {final _that = this;
switch (_that) {
case _RateOrderBody() when $default != null:
return $default(_that.overallStars,_that.captainStars,_that.orderAccuracyStars,_that.deliverySpeedStars,_that.comment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateOrderBody implements RateOrderBody {
  const _RateOrderBody({@JsonKey(name: 'overall_stars') required this.overallStars, @JsonKey(name: 'captain_stars') required this.captainStars, @JsonKey(name: 'order_accuracy_stars') required this.orderAccuracyStars, @JsonKey(name: 'delivery_speed_stars') required this.deliverySpeedStars, this.comment});
  factory _RateOrderBody.fromJson(Map<String, dynamic> json) => _$RateOrderBodyFromJson(json);

@override@JsonKey(name: 'overall_stars') final  int overallStars;
@override@JsonKey(name: 'captain_stars') final  int captainStars;
@override@JsonKey(name: 'order_accuracy_stars') final  int orderAccuracyStars;
@override@JsonKey(name: 'delivery_speed_stars') final  int deliverySpeedStars;
@override final  String? comment;

/// Create a copy of RateOrderBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateOrderBodyCopyWith<_RateOrderBody> get copyWith => __$RateOrderBodyCopyWithImpl<_RateOrderBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateOrderBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateOrderBody&&(identical(other.overallStars, overallStars) || other.overallStars == overallStars)&&(identical(other.captainStars, captainStars) || other.captainStars == captainStars)&&(identical(other.orderAccuracyStars, orderAccuracyStars) || other.orderAccuracyStars == orderAccuracyStars)&&(identical(other.deliverySpeedStars, deliverySpeedStars) || other.deliverySpeedStars == deliverySpeedStars)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,overallStars,captainStars,orderAccuracyStars,deliverySpeedStars,comment);

@override
String toString() {
  return 'RateOrderBody(overallStars: $overallStars, captainStars: $captainStars, orderAccuracyStars: $orderAccuracyStars, deliverySpeedStars: $deliverySpeedStars, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$RateOrderBodyCopyWith<$Res> implements $RateOrderBodyCopyWith<$Res> {
  factory _$RateOrderBodyCopyWith(_RateOrderBody value, $Res Function(_RateOrderBody) _then) = __$RateOrderBodyCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'overall_stars') int overallStars,@JsonKey(name: 'captain_stars') int captainStars,@JsonKey(name: 'order_accuracy_stars') int orderAccuracyStars,@JsonKey(name: 'delivery_speed_stars') int deliverySpeedStars, String? comment
});




}
/// @nodoc
class __$RateOrderBodyCopyWithImpl<$Res>
    implements _$RateOrderBodyCopyWith<$Res> {
  __$RateOrderBodyCopyWithImpl(this._self, this._then);

  final _RateOrderBody _self;
  final $Res Function(_RateOrderBody) _then;

/// Create a copy of RateOrderBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overallStars = null,Object? captainStars = null,Object? orderAccuracyStars = null,Object? deliverySpeedStars = null,Object? comment = freezed,}) {
  return _then(_RateOrderBody(
overallStars: null == overallStars ? _self.overallStars : overallStars // ignore: cast_nullable_to_non_nullable
as int,captainStars: null == captainStars ? _self.captainStars : captainStars // ignore: cast_nullable_to_non_nullable
as int,orderAccuracyStars: null == orderAccuracyStars ? _self.orderAccuracyStars : orderAccuracyStars // ignore: cast_nullable_to_non_nullable
as int,deliverySpeedStars: null == deliverySpeedStars ? _self.deliverySpeedStars : deliverySpeedStars // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OpenTicketBody {

 String get title; String get description; String get category; String get priority;@JsonKey(name: 'order_id') int? get orderId;
/// Create a copy of OpenTicketBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenTicketBodyCopyWith<OpenTicketBody> get copyWith => _$OpenTicketBodyCopyWithImpl<OpenTicketBody>(this as OpenTicketBody, _$identity);

  /// Serializes this OpenTicketBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenTicketBody&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.orderId, orderId) || other.orderId == orderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,category,priority,orderId);

@override
String toString() {
  return 'OpenTicketBody(title: $title, description: $description, category: $category, priority: $priority, orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $OpenTicketBodyCopyWith<$Res>  {
  factory $OpenTicketBodyCopyWith(OpenTicketBody value, $Res Function(OpenTicketBody) _then) = _$OpenTicketBodyCopyWithImpl;
@useResult
$Res call({
 String title, String description, String category, String priority,@JsonKey(name: 'order_id') int? orderId
});




}
/// @nodoc
class _$OpenTicketBodyCopyWithImpl<$Res>
    implements $OpenTicketBodyCopyWith<$Res> {
  _$OpenTicketBodyCopyWithImpl(this._self, this._then);

  final OpenTicketBody _self;
  final $Res Function(OpenTicketBody) _then;

/// Create a copy of OpenTicketBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? category = null,Object? priority = null,Object? orderId = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenTicketBody].
extension OpenTicketBodyPatterns on OpenTicketBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenTicketBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenTicketBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenTicketBody value)  $default,){
final _that = this;
switch (_that) {
case _OpenTicketBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenTicketBody value)?  $default,){
final _that = this;
switch (_that) {
case _OpenTicketBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String category,  String priority, @JsonKey(name: 'order_id')  int? orderId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenTicketBody() when $default != null:
return $default(_that.title,_that.description,_that.category,_that.priority,_that.orderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String category,  String priority, @JsonKey(name: 'order_id')  int? orderId)  $default,) {final _that = this;
switch (_that) {
case _OpenTicketBody():
return $default(_that.title,_that.description,_that.category,_that.priority,_that.orderId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String category,  String priority, @JsonKey(name: 'order_id')  int? orderId)?  $default,) {final _that = this;
switch (_that) {
case _OpenTicketBody() when $default != null:
return $default(_that.title,_that.description,_that.category,_that.priority,_that.orderId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenTicketBody implements OpenTicketBody {
  const _OpenTicketBody({required this.title, required this.description, this.category = 'inquiry', this.priority = 'normal', @JsonKey(name: 'order_id') this.orderId});
  factory _OpenTicketBody.fromJson(Map<String, dynamic> json) => _$OpenTicketBodyFromJson(json);

@override final  String title;
@override final  String description;
@override@JsonKey() final  String category;
@override@JsonKey() final  String priority;
@override@JsonKey(name: 'order_id') final  int? orderId;

/// Create a copy of OpenTicketBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenTicketBodyCopyWith<_OpenTicketBody> get copyWith => __$OpenTicketBodyCopyWithImpl<_OpenTicketBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenTicketBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenTicketBody&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.orderId, orderId) || other.orderId == orderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,category,priority,orderId);

@override
String toString() {
  return 'OpenTicketBody(title: $title, description: $description, category: $category, priority: $priority, orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class _$OpenTicketBodyCopyWith<$Res> implements $OpenTicketBodyCopyWith<$Res> {
  factory _$OpenTicketBodyCopyWith(_OpenTicketBody value, $Res Function(_OpenTicketBody) _then) = __$OpenTicketBodyCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String category, String priority,@JsonKey(name: 'order_id') int? orderId
});




}
/// @nodoc
class __$OpenTicketBodyCopyWithImpl<$Res>
    implements _$OpenTicketBodyCopyWith<$Res> {
  __$OpenTicketBodyCopyWithImpl(this._self, this._then);

  final _OpenTicketBody _self;
  final $Res Function(_OpenTicketBody) _then;

/// Create a copy of OpenTicketBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? category = null,Object? priority = null,Object? orderId = freezed,}) {
  return _then(_OpenTicketBody(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ReplyTicketBody {

 String get body;
/// Create a copy of ReplyTicketBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyTicketBodyCopyWith<ReplyTicketBody> get copyWith => _$ReplyTicketBodyCopyWithImpl<ReplyTicketBody>(this as ReplyTicketBody, _$identity);

  /// Serializes this ReplyTicketBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyTicketBody&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,body);

@override
String toString() {
  return 'ReplyTicketBody(body: $body)';
}


}

/// @nodoc
abstract mixin class $ReplyTicketBodyCopyWith<$Res>  {
  factory $ReplyTicketBodyCopyWith(ReplyTicketBody value, $Res Function(ReplyTicketBody) _then) = _$ReplyTicketBodyCopyWithImpl;
@useResult
$Res call({
 String body
});




}
/// @nodoc
class _$ReplyTicketBodyCopyWithImpl<$Res>
    implements $ReplyTicketBodyCopyWith<$Res> {
  _$ReplyTicketBodyCopyWithImpl(this._self, this._then);

  final ReplyTicketBody _self;
  final $Res Function(ReplyTicketBody) _then;

/// Create a copy of ReplyTicketBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? body = null,}) {
  return _then(_self.copyWith(
body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplyTicketBody].
extension ReplyTicketBodyPatterns on ReplyTicketBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyTicketBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyTicketBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyTicketBody value)  $default,){
final _that = this;
switch (_that) {
case _ReplyTicketBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyTicketBody value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyTicketBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyTicketBody() when $default != null:
return $default(_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String body)  $default,) {final _that = this;
switch (_that) {
case _ReplyTicketBody():
return $default(_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String body)?  $default,) {final _that = this;
switch (_that) {
case _ReplyTicketBody() when $default != null:
return $default(_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyTicketBody implements ReplyTicketBody {
  const _ReplyTicketBody({required this.body});
  factory _ReplyTicketBody.fromJson(Map<String, dynamic> json) => _$ReplyTicketBodyFromJson(json);

@override final  String body;

/// Create a copy of ReplyTicketBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyTicketBodyCopyWith<_ReplyTicketBody> get copyWith => __$ReplyTicketBodyCopyWithImpl<_ReplyTicketBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyTicketBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyTicketBody&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,body);

@override
String toString() {
  return 'ReplyTicketBody(body: $body)';
}


}

/// @nodoc
abstract mixin class _$ReplyTicketBodyCopyWith<$Res> implements $ReplyTicketBodyCopyWith<$Res> {
  factory _$ReplyTicketBodyCopyWith(_ReplyTicketBody value, $Res Function(_ReplyTicketBody) _then) = __$ReplyTicketBodyCopyWithImpl;
@override @useResult
$Res call({
 String body
});




}
/// @nodoc
class __$ReplyTicketBodyCopyWithImpl<$Res>
    implements _$ReplyTicketBodyCopyWith<$Res> {
  __$ReplyTicketBodyCopyWithImpl(this._self, this._then);

  final _ReplyTicketBody _self;
  final $Res Function(_ReplyTicketBody) _then;

/// Create a copy of ReplyTicketBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? body = null,}) {
  return _then(_ReplyTicketBody(
body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
