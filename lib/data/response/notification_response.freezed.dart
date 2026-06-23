// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MobileNotification {

 int get id; String get type;@JsonKey(name: 'title_ar') String get titleAr;@JsonKey(name: 'title_en') String get titleEn;@JsonKey(name: 'body_ar') String get bodyAr;@JsonKey(name: 'body_en') String get bodyEn; Map<String, dynamic> get payload; bool get read;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of MobileNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MobileNotificationCopyWith<MobileNotification> get copyWith => _$MobileNotificationCopyWithImpl<MobileNotification>(this as MobileNotification, _$identity);

  /// Serializes this MobileNotification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MobileNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.bodyAr, bodyAr) || other.bodyAr == bodyAr)&&(identical(other.bodyEn, bodyEn) || other.bodyEn == bodyEn)&&const DeepCollectionEquality().equals(other.payload, payload)&&(identical(other.read, read) || other.read == read)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,titleAr,titleEn,bodyAr,bodyEn,const DeepCollectionEquality().hash(payload),read,createdAt);

@override
String toString() {
  return 'MobileNotification(id: $id, type: $type, titleAr: $titleAr, titleEn: $titleEn, bodyAr: $bodyAr, bodyEn: $bodyEn, payload: $payload, read: $read, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MobileNotificationCopyWith<$Res>  {
  factory $MobileNotificationCopyWith(MobileNotification value, $Res Function(MobileNotification) _then) = _$MobileNotificationCopyWithImpl;
@useResult
$Res call({
 int id, String type,@JsonKey(name: 'title_ar') String titleAr,@JsonKey(name: 'title_en') String titleEn,@JsonKey(name: 'body_ar') String bodyAr,@JsonKey(name: 'body_en') String bodyEn, Map<String, dynamic> payload, bool read,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$MobileNotificationCopyWithImpl<$Res>
    implements $MobileNotificationCopyWith<$Res> {
  _$MobileNotificationCopyWithImpl(this._self, this._then);

  final MobileNotification _self;
  final $Res Function(MobileNotification) _then;

/// Create a copy of MobileNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? titleAr = null,Object? titleEn = null,Object? bodyAr = null,Object? bodyEn = null,Object? payload = null,Object? read = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,bodyAr: null == bodyAr ? _self.bodyAr : bodyAr // ignore: cast_nullable_to_non_nullable
as String,bodyEn: null == bodyEn ? _self.bodyEn : bodyEn // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MobileNotification].
extension MobileNotificationPatterns on MobileNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MobileNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MobileNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MobileNotification value)  $default,){
final _that = this;
switch (_that) {
case _MobileNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MobileNotification value)?  $default,){
final _that = this;
switch (_that) {
case _MobileNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type, @JsonKey(name: 'title_ar')  String titleAr, @JsonKey(name: 'title_en')  String titleEn, @JsonKey(name: 'body_ar')  String bodyAr, @JsonKey(name: 'body_en')  String bodyEn,  Map<String, dynamic> payload,  bool read, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MobileNotification() when $default != null:
return $default(_that.id,_that.type,_that.titleAr,_that.titleEn,_that.bodyAr,_that.bodyEn,_that.payload,_that.read,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type, @JsonKey(name: 'title_ar')  String titleAr, @JsonKey(name: 'title_en')  String titleEn, @JsonKey(name: 'body_ar')  String bodyAr, @JsonKey(name: 'body_en')  String bodyEn,  Map<String, dynamic> payload,  bool read, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MobileNotification():
return $default(_that.id,_that.type,_that.titleAr,_that.titleEn,_that.bodyAr,_that.bodyEn,_that.payload,_that.read,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type, @JsonKey(name: 'title_ar')  String titleAr, @JsonKey(name: 'title_en')  String titleEn, @JsonKey(name: 'body_ar')  String bodyAr, @JsonKey(name: 'body_en')  String bodyEn,  Map<String, dynamic> payload,  bool read, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MobileNotification() when $default != null:
return $default(_that.id,_that.type,_that.titleAr,_that.titleEn,_that.bodyAr,_that.bodyEn,_that.payload,_that.read,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MobileNotification extends MobileNotification {
  const _MobileNotification({required this.id, this.type = '', @JsonKey(name: 'title_ar') this.titleAr = '', @JsonKey(name: 'title_en') this.titleEn = '', @JsonKey(name: 'body_ar') this.bodyAr = '', @JsonKey(name: 'body_en') this.bodyEn = '', final  Map<String, dynamic> payload = const <String, dynamic>{}, this.read = false, @JsonKey(name: 'created_at') required this.createdAt}): _payload = payload,super._();
  factory _MobileNotification.fromJson(Map<String, dynamic> json) => _$MobileNotificationFromJson(json);

@override final  int id;
@override@JsonKey() final  String type;
@override@JsonKey(name: 'title_ar') final  String titleAr;
@override@JsonKey(name: 'title_en') final  String titleEn;
@override@JsonKey(name: 'body_ar') final  String bodyAr;
@override@JsonKey(name: 'body_en') final  String bodyEn;
 final  Map<String, dynamic> _payload;
@override@JsonKey() Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

@override@JsonKey() final  bool read;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of MobileNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MobileNotificationCopyWith<_MobileNotification> get copyWith => __$MobileNotificationCopyWithImpl<_MobileNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MobileNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MobileNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.bodyAr, bodyAr) || other.bodyAr == bodyAr)&&(identical(other.bodyEn, bodyEn) || other.bodyEn == bodyEn)&&const DeepCollectionEquality().equals(other._payload, _payload)&&(identical(other.read, read) || other.read == read)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,titleAr,titleEn,bodyAr,bodyEn,const DeepCollectionEquality().hash(_payload),read,createdAt);

@override
String toString() {
  return 'MobileNotification(id: $id, type: $type, titleAr: $titleAr, titleEn: $titleEn, bodyAr: $bodyAr, bodyEn: $bodyEn, payload: $payload, read: $read, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MobileNotificationCopyWith<$Res> implements $MobileNotificationCopyWith<$Res> {
  factory _$MobileNotificationCopyWith(_MobileNotification value, $Res Function(_MobileNotification) _then) = __$MobileNotificationCopyWithImpl;
@override @useResult
$Res call({
 int id, String type,@JsonKey(name: 'title_ar') String titleAr,@JsonKey(name: 'title_en') String titleEn,@JsonKey(name: 'body_ar') String bodyAr,@JsonKey(name: 'body_en') String bodyEn, Map<String, dynamic> payload, bool read,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$MobileNotificationCopyWithImpl<$Res>
    implements _$MobileNotificationCopyWith<$Res> {
  __$MobileNotificationCopyWithImpl(this._self, this._then);

  final _MobileNotification _self;
  final $Res Function(_MobileNotification) _then;

/// Create a copy of MobileNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? titleAr = null,Object? titleEn = null,Object? bodyAr = null,Object? bodyEn = null,Object? payload = null,Object? read = null,Object? createdAt = null,}) {
  return _then(_MobileNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,bodyAr: null == bodyAr ? _self.bodyAr : bodyAr // ignore: cast_nullable_to_non_nullable
as String,bodyEn: null == bodyEn ? _self.bodyEn : bodyEn // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$UnreadNotificationsCount {

 int get unread;
/// Create a copy of UnreadNotificationsCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnreadNotificationsCountCopyWith<UnreadNotificationsCount> get copyWith => _$UnreadNotificationsCountCopyWithImpl<UnreadNotificationsCount>(this as UnreadNotificationsCount, _$identity);

  /// Serializes this UnreadNotificationsCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnreadNotificationsCount&&(identical(other.unread, unread) || other.unread == unread));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unread);

@override
String toString() {
  return 'UnreadNotificationsCount(unread: $unread)';
}


}

/// @nodoc
abstract mixin class $UnreadNotificationsCountCopyWith<$Res>  {
  factory $UnreadNotificationsCountCopyWith(UnreadNotificationsCount value, $Res Function(UnreadNotificationsCount) _then) = _$UnreadNotificationsCountCopyWithImpl;
@useResult
$Res call({
 int unread
});




}
/// @nodoc
class _$UnreadNotificationsCountCopyWithImpl<$Res>
    implements $UnreadNotificationsCountCopyWith<$Res> {
  _$UnreadNotificationsCountCopyWithImpl(this._self, this._then);

  final UnreadNotificationsCount _self;
  final $Res Function(UnreadNotificationsCount) _then;

/// Create a copy of UnreadNotificationsCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unread = null,}) {
  return _then(_self.copyWith(
unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UnreadNotificationsCount].
extension UnreadNotificationsCountPatterns on UnreadNotificationsCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnreadNotificationsCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnreadNotificationsCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnreadNotificationsCount value)  $default,){
final _that = this;
switch (_that) {
case _UnreadNotificationsCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnreadNotificationsCount value)?  $default,){
final _that = this;
switch (_that) {
case _UnreadNotificationsCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int unread)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnreadNotificationsCount() when $default != null:
return $default(_that.unread);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int unread)  $default,) {final _that = this;
switch (_that) {
case _UnreadNotificationsCount():
return $default(_that.unread);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int unread)?  $default,) {final _that = this;
switch (_that) {
case _UnreadNotificationsCount() when $default != null:
return $default(_that.unread);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UnreadNotificationsCount implements UnreadNotificationsCount {
  const _UnreadNotificationsCount({this.unread = 0});
  factory _UnreadNotificationsCount.fromJson(Map<String, dynamic> json) => _$UnreadNotificationsCountFromJson(json);

@override@JsonKey() final  int unread;

/// Create a copy of UnreadNotificationsCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnreadNotificationsCountCopyWith<_UnreadNotificationsCount> get copyWith => __$UnreadNotificationsCountCopyWithImpl<_UnreadNotificationsCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnreadNotificationsCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnreadNotificationsCount&&(identical(other.unread, unread) || other.unread == unread));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unread);

@override
String toString() {
  return 'UnreadNotificationsCount(unread: $unread)';
}


}

/// @nodoc
abstract mixin class _$UnreadNotificationsCountCopyWith<$Res> implements $UnreadNotificationsCountCopyWith<$Res> {
  factory _$UnreadNotificationsCountCopyWith(_UnreadNotificationsCount value, $Res Function(_UnreadNotificationsCount) _then) = __$UnreadNotificationsCountCopyWithImpl;
@override @useResult
$Res call({
 int unread
});




}
/// @nodoc
class __$UnreadNotificationsCountCopyWithImpl<$Res>
    implements _$UnreadNotificationsCountCopyWith<$Res> {
  __$UnreadNotificationsCountCopyWithImpl(this._self, this._then);

  final _UnreadNotificationsCount _self;
  final $Res Function(_UnreadNotificationsCount) _then;

/// Create a copy of UnreadNotificationsCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unread = null,}) {
  return _then(_UnreadNotificationsCount(
unread: null == unread ? _self.unread : unread // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MarkedNotificationsCount {

 int get marked;
/// Create a copy of MarkedNotificationsCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkedNotificationsCountCopyWith<MarkedNotificationsCount> get copyWith => _$MarkedNotificationsCountCopyWithImpl<MarkedNotificationsCount>(this as MarkedNotificationsCount, _$identity);

  /// Serializes this MarkedNotificationsCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkedNotificationsCount&&(identical(other.marked, marked) || other.marked == marked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,marked);

@override
String toString() {
  return 'MarkedNotificationsCount(marked: $marked)';
}


}

/// @nodoc
abstract mixin class $MarkedNotificationsCountCopyWith<$Res>  {
  factory $MarkedNotificationsCountCopyWith(MarkedNotificationsCount value, $Res Function(MarkedNotificationsCount) _then) = _$MarkedNotificationsCountCopyWithImpl;
@useResult
$Res call({
 int marked
});




}
/// @nodoc
class _$MarkedNotificationsCountCopyWithImpl<$Res>
    implements $MarkedNotificationsCountCopyWith<$Res> {
  _$MarkedNotificationsCountCopyWithImpl(this._self, this._then);

  final MarkedNotificationsCount _self;
  final $Res Function(MarkedNotificationsCount) _then;

/// Create a copy of MarkedNotificationsCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? marked = null,}) {
  return _then(_self.copyWith(
marked: null == marked ? _self.marked : marked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MarkedNotificationsCount].
extension MarkedNotificationsCountPatterns on MarkedNotificationsCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkedNotificationsCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkedNotificationsCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkedNotificationsCount value)  $default,){
final _that = this;
switch (_that) {
case _MarkedNotificationsCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkedNotificationsCount value)?  $default,){
final _that = this;
switch (_that) {
case _MarkedNotificationsCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int marked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarkedNotificationsCount() when $default != null:
return $default(_that.marked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int marked)  $default,) {final _that = this;
switch (_that) {
case _MarkedNotificationsCount():
return $default(_that.marked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int marked)?  $default,) {final _that = this;
switch (_that) {
case _MarkedNotificationsCount() when $default != null:
return $default(_that.marked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarkedNotificationsCount implements MarkedNotificationsCount {
  const _MarkedNotificationsCount({this.marked = 0});
  factory _MarkedNotificationsCount.fromJson(Map<String, dynamic> json) => _$MarkedNotificationsCountFromJson(json);

@override@JsonKey() final  int marked;

/// Create a copy of MarkedNotificationsCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkedNotificationsCountCopyWith<_MarkedNotificationsCount> get copyWith => __$MarkedNotificationsCountCopyWithImpl<_MarkedNotificationsCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarkedNotificationsCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkedNotificationsCount&&(identical(other.marked, marked) || other.marked == marked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,marked);

@override
String toString() {
  return 'MarkedNotificationsCount(marked: $marked)';
}


}

/// @nodoc
abstract mixin class _$MarkedNotificationsCountCopyWith<$Res> implements $MarkedNotificationsCountCopyWith<$Res> {
  factory _$MarkedNotificationsCountCopyWith(_MarkedNotificationsCount value, $Res Function(_MarkedNotificationsCount) _then) = __$MarkedNotificationsCountCopyWithImpl;
@override @useResult
$Res call({
 int marked
});




}
/// @nodoc
class __$MarkedNotificationsCountCopyWithImpl<$Res>
    implements _$MarkedNotificationsCountCopyWith<$Res> {
  __$MarkedNotificationsCountCopyWithImpl(this._self, this._then);

  final _MarkedNotificationsCount _self;
  final $Res Function(_MarkedNotificationsCount) _then;

/// Create a copy of MarkedNotificationsCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? marked = null,}) {
  return _then(_MarkedNotificationsCount(
marked: null == marked ? _self.marked : marked // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
