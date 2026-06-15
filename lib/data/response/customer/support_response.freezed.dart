// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TicketMessage {

 int get id;@JsonKey(name: 'sender_type') String get senderType; String get body;@JsonKey(name: 'is_internal_note') bool get isInternalNote;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of TicketMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketMessageCopyWith<TicketMessage> get copyWith => _$TicketMessageCopyWithImpl<TicketMessage>(this as TicketMessage, _$identity);

  /// Serializes this TicketMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.senderType, senderType) || other.senderType == senderType)&&(identical(other.body, body) || other.body == body)&&(identical(other.isInternalNote, isInternalNote) || other.isInternalNote == isInternalNote)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderType,body,isInternalNote,createdAt);

@override
String toString() {
  return 'TicketMessage(id: $id, senderType: $senderType, body: $body, isInternalNote: $isInternalNote, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TicketMessageCopyWith<$Res>  {
  factory $TicketMessageCopyWith(TicketMessage value, $Res Function(TicketMessage) _then) = _$TicketMessageCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'sender_type') String senderType, String body,@JsonKey(name: 'is_internal_note') bool isInternalNote,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$TicketMessageCopyWithImpl<$Res>
    implements $TicketMessageCopyWith<$Res> {
  _$TicketMessageCopyWithImpl(this._self, this._then);

  final TicketMessage _self;
  final $Res Function(TicketMessage) _then;

/// Create a copy of TicketMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderType = null,Object? body = null,Object? isInternalNote = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,senderType: null == senderType ? _self.senderType : senderType // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,isInternalNote: null == isInternalNote ? _self.isInternalNote : isInternalNote // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketMessage].
extension TicketMessagePatterns on TicketMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketMessage value)  $default,){
final _that = this;
switch (_that) {
case _TicketMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketMessage value)?  $default,){
final _that = this;
switch (_that) {
case _TicketMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'sender_type')  String senderType,  String body, @JsonKey(name: 'is_internal_note')  bool isInternalNote, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketMessage() when $default != null:
return $default(_that.id,_that.senderType,_that.body,_that.isInternalNote,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'sender_type')  String senderType,  String body, @JsonKey(name: 'is_internal_note')  bool isInternalNote, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TicketMessage():
return $default(_that.id,_that.senderType,_that.body,_that.isInternalNote,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'sender_type')  String senderType,  String body, @JsonKey(name: 'is_internal_note')  bool isInternalNote, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TicketMessage() when $default != null:
return $default(_that.id,_that.senderType,_that.body,_that.isInternalNote,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketMessage extends TicketMessage {
  const _TicketMessage({this.id = 0, @JsonKey(name: 'sender_type') this.senderType = '', this.body = '', @JsonKey(name: 'is_internal_note') this.isInternalNote = false, @JsonKey(name: 'created_at') this.createdAt}): super._();
  factory _TicketMessage.fromJson(Map<String, dynamic> json) => _$TicketMessageFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey(name: 'sender_type') final  String senderType;
@override@JsonKey() final  String body;
@override@JsonKey(name: 'is_internal_note') final  bool isInternalNote;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of TicketMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketMessageCopyWith<_TicketMessage> get copyWith => __$TicketMessageCopyWithImpl<_TicketMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.senderType, senderType) || other.senderType == senderType)&&(identical(other.body, body) || other.body == body)&&(identical(other.isInternalNote, isInternalNote) || other.isInternalNote == isInternalNote)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderType,body,isInternalNote,createdAt);

@override
String toString() {
  return 'TicketMessage(id: $id, senderType: $senderType, body: $body, isInternalNote: $isInternalNote, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TicketMessageCopyWith<$Res> implements $TicketMessageCopyWith<$Res> {
  factory _$TicketMessageCopyWith(_TicketMessage value, $Res Function(_TicketMessage) _then) = __$TicketMessageCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'sender_type') String senderType, String body,@JsonKey(name: 'is_internal_note') bool isInternalNote,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$TicketMessageCopyWithImpl<$Res>
    implements _$TicketMessageCopyWith<$Res> {
  __$TicketMessageCopyWithImpl(this._self, this._then);

  final _TicketMessage _self;
  final $Res Function(_TicketMessage) _then;

/// Create a copy of TicketMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderType = null,Object? body = null,Object? isInternalNote = null,Object? createdAt = freezed,}) {
  return _then(_TicketMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,senderType: null == senderType ? _self.senderType : senderType // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,isInternalNote: null == isInternalNote ? _self.isInternalNote : isInternalNote // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Ticket {

 int get id;@JsonKey(name: 'ticket_number') String get ticketNumber; String? get category; String? get priority; String get status; String get title; String get description;@JsonKey(name: 'merchant_id') int? get merchantId;@JsonKey(name: 'merchant_name_ar') String? get merchantNameAr;@JsonKey(name: 'merchant_name_en') String? get merchantNameEn;@JsonKey(name: 'opener_name') String? get openerName;@JsonKey(name: 'branch_id') int? get branchId;@JsonKey(name: 'order_id') int? get orderId;@JsonKey(name: 'last_message') TicketMessage? get lastMessage; List<TicketMessage>? get messages;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCopyWith<Ticket> get copyWith => _$TicketCopyWithImpl<Ticket>(this as Ticket, _$identity);

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ticket&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketNumber, ticketNumber) || other.ticketNumber == ticketNumber)&&(identical(other.category, category) || other.category == category)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.merchantId, merchantId) || other.merchantId == merchantId)&&(identical(other.merchantNameAr, merchantNameAr) || other.merchantNameAr == merchantNameAr)&&(identical(other.merchantNameEn, merchantNameEn) || other.merchantNameEn == merchantNameEn)&&(identical(other.openerName, openerName) || other.openerName == openerName)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketNumber,category,priority,status,title,description,merchantId,merchantNameAr,merchantNameEn,openerName,branchId,orderId,lastMessage,const DeepCollectionEquality().hash(messages),createdAt,updatedAt);

@override
String toString() {
  return 'Ticket(id: $id, ticketNumber: $ticketNumber, category: $category, priority: $priority, status: $status, title: $title, description: $description, merchantId: $merchantId, merchantNameAr: $merchantNameAr, merchantNameEn: $merchantNameEn, openerName: $openerName, branchId: $branchId, orderId: $orderId, lastMessage: $lastMessage, messages: $messages, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TicketCopyWith<$Res>  {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) _then) = _$TicketCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'ticket_number') String ticketNumber, String? category, String? priority, String status, String title, String description,@JsonKey(name: 'merchant_id') int? merchantId,@JsonKey(name: 'merchant_name_ar') String? merchantNameAr,@JsonKey(name: 'merchant_name_en') String? merchantNameEn,@JsonKey(name: 'opener_name') String? openerName,@JsonKey(name: 'branch_id') int? branchId,@JsonKey(name: 'order_id') int? orderId,@JsonKey(name: 'last_message') TicketMessage? lastMessage, List<TicketMessage>? messages,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


$TicketMessageCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class _$TicketCopyWithImpl<$Res>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._self, this._then);

  final Ticket _self;
  final $Res Function(Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ticketNumber = null,Object? category = freezed,Object? priority = freezed,Object? status = null,Object? title = null,Object? description = null,Object? merchantId = freezed,Object? merchantNameAr = freezed,Object? merchantNameEn = freezed,Object? openerName = freezed,Object? branchId = freezed,Object? orderId = freezed,Object? lastMessage = freezed,Object? messages = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ticketNumber: null == ticketNumber ? _self.ticketNumber : ticketNumber // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,merchantId: freezed == merchantId ? _self.merchantId : merchantId // ignore: cast_nullable_to_non_nullable
as int?,merchantNameAr: freezed == merchantNameAr ? _self.merchantNameAr : merchantNameAr // ignore: cast_nullable_to_non_nullable
as String?,merchantNameEn: freezed == merchantNameEn ? _self.merchantNameEn : merchantNameEn // ignore: cast_nullable_to_non_nullable
as String?,openerName: freezed == openerName ? _self.openerName : openerName // ignore: cast_nullable_to_non_nullable
as String?,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as TicketMessage?,messages: freezed == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<TicketMessage>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketMessageCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $TicketMessageCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [Ticket].
extension TicketPatterns on Ticket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ticket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ticket value)  $default,){
final _that = this;
switch (_that) {
case _Ticket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ticket value)?  $default,){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ticket_number')  String ticketNumber,  String? category,  String? priority,  String status,  String title,  String description, @JsonKey(name: 'merchant_id')  int? merchantId, @JsonKey(name: 'merchant_name_ar')  String? merchantNameAr, @JsonKey(name: 'merchant_name_en')  String? merchantNameEn, @JsonKey(name: 'opener_name')  String? openerName, @JsonKey(name: 'branch_id')  int? branchId, @JsonKey(name: 'order_id')  int? orderId, @JsonKey(name: 'last_message')  TicketMessage? lastMessage,  List<TicketMessage>? messages, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.ticketNumber,_that.category,_that.priority,_that.status,_that.title,_that.description,_that.merchantId,_that.merchantNameAr,_that.merchantNameEn,_that.openerName,_that.branchId,_that.orderId,_that.lastMessage,_that.messages,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ticket_number')  String ticketNumber,  String? category,  String? priority,  String status,  String title,  String description, @JsonKey(name: 'merchant_id')  int? merchantId, @JsonKey(name: 'merchant_name_ar')  String? merchantNameAr, @JsonKey(name: 'merchant_name_en')  String? merchantNameEn, @JsonKey(name: 'opener_name')  String? openerName, @JsonKey(name: 'branch_id')  int? branchId, @JsonKey(name: 'order_id')  int? orderId, @JsonKey(name: 'last_message')  TicketMessage? lastMessage,  List<TicketMessage>? messages, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Ticket():
return $default(_that.id,_that.ticketNumber,_that.category,_that.priority,_that.status,_that.title,_that.description,_that.merchantId,_that.merchantNameAr,_that.merchantNameEn,_that.openerName,_that.branchId,_that.orderId,_that.lastMessage,_that.messages,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'ticket_number')  String ticketNumber,  String? category,  String? priority,  String status,  String title,  String description, @JsonKey(name: 'merchant_id')  int? merchantId, @JsonKey(name: 'merchant_name_ar')  String? merchantNameAr, @JsonKey(name: 'merchant_name_en')  String? merchantNameEn, @JsonKey(name: 'opener_name')  String? openerName, @JsonKey(name: 'branch_id')  int? branchId, @JsonKey(name: 'order_id')  int? orderId, @JsonKey(name: 'last_message')  TicketMessage? lastMessage,  List<TicketMessage>? messages, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.ticketNumber,_that.category,_that.priority,_that.status,_that.title,_that.description,_that.merchantId,_that.merchantNameAr,_that.merchantNameEn,_that.openerName,_that.branchId,_that.orderId,_that.lastMessage,_that.messages,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ticket extends Ticket {
  const _Ticket({required this.id, @JsonKey(name: 'ticket_number') this.ticketNumber = '', this.category, this.priority, this.status = 'open', this.title = '', this.description = '', @JsonKey(name: 'merchant_id') this.merchantId, @JsonKey(name: 'merchant_name_ar') this.merchantNameAr, @JsonKey(name: 'merchant_name_en') this.merchantNameEn, @JsonKey(name: 'opener_name') this.openerName, @JsonKey(name: 'branch_id') this.branchId, @JsonKey(name: 'order_id') this.orderId, @JsonKey(name: 'last_message') this.lastMessage, final  List<TicketMessage>? messages, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): _messages = messages,super._();
  factory _Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

@override final  int id;
@override@JsonKey(name: 'ticket_number') final  String ticketNumber;
@override final  String? category;
@override final  String? priority;
@override@JsonKey() final  String status;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey(name: 'merchant_id') final  int? merchantId;
@override@JsonKey(name: 'merchant_name_ar') final  String? merchantNameAr;
@override@JsonKey(name: 'merchant_name_en') final  String? merchantNameEn;
@override@JsonKey(name: 'opener_name') final  String? openerName;
@override@JsonKey(name: 'branch_id') final  int? branchId;
@override@JsonKey(name: 'order_id') final  int? orderId;
@override@JsonKey(name: 'last_message') final  TicketMessage? lastMessage;
 final  List<TicketMessage>? _messages;
@override List<TicketMessage>? get messages {
  final value = _messages;
  if (value == null) return null;
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCopyWith<_Ticket> get copyWith => __$TicketCopyWithImpl<_Ticket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ticket&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketNumber, ticketNumber) || other.ticketNumber == ticketNumber)&&(identical(other.category, category) || other.category == category)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.merchantId, merchantId) || other.merchantId == merchantId)&&(identical(other.merchantNameAr, merchantNameAr) || other.merchantNameAr == merchantNameAr)&&(identical(other.merchantNameEn, merchantNameEn) || other.merchantNameEn == merchantNameEn)&&(identical(other.openerName, openerName) || other.openerName == openerName)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ticketNumber,category,priority,status,title,description,merchantId,merchantNameAr,merchantNameEn,openerName,branchId,orderId,lastMessage,const DeepCollectionEquality().hash(_messages),createdAt,updatedAt);

@override
String toString() {
  return 'Ticket(id: $id, ticketNumber: $ticketNumber, category: $category, priority: $priority, status: $status, title: $title, description: $description, merchantId: $merchantId, merchantNameAr: $merchantNameAr, merchantNameEn: $merchantNameEn, openerName: $openerName, branchId: $branchId, orderId: $orderId, lastMessage: $lastMessage, messages: $messages, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$TicketCopyWith(_Ticket value, $Res Function(_Ticket) _then) = __$TicketCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'ticket_number') String ticketNumber, String? category, String? priority, String status, String title, String description,@JsonKey(name: 'merchant_id') int? merchantId,@JsonKey(name: 'merchant_name_ar') String? merchantNameAr,@JsonKey(name: 'merchant_name_en') String? merchantNameEn,@JsonKey(name: 'opener_name') String? openerName,@JsonKey(name: 'branch_id') int? branchId,@JsonKey(name: 'order_id') int? orderId,@JsonKey(name: 'last_message') TicketMessage? lastMessage, List<TicketMessage>? messages,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


@override $TicketMessageCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class __$TicketCopyWithImpl<$Res>
    implements _$TicketCopyWith<$Res> {
  __$TicketCopyWithImpl(this._self, this._then);

  final _Ticket _self;
  final $Res Function(_Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ticketNumber = null,Object? category = freezed,Object? priority = freezed,Object? status = null,Object? title = null,Object? description = null,Object? merchantId = freezed,Object? merchantNameAr = freezed,Object? merchantNameEn = freezed,Object? openerName = freezed,Object? branchId = freezed,Object? orderId = freezed,Object? lastMessage = freezed,Object? messages = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Ticket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,ticketNumber: null == ticketNumber ? _self.ticketNumber : ticketNumber // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,merchantId: freezed == merchantId ? _self.merchantId : merchantId // ignore: cast_nullable_to_non_nullable
as int?,merchantNameAr: freezed == merchantNameAr ? _self.merchantNameAr : merchantNameAr // ignore: cast_nullable_to_non_nullable
as String?,merchantNameEn: freezed == merchantNameEn ? _self.merchantNameEn : merchantNameEn // ignore: cast_nullable_to_non_nullable
as String?,openerName: freezed == openerName ? _self.openerName : openerName // ignore: cast_nullable_to_non_nullable
as String?,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as int?,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int?,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as TicketMessage?,messages: freezed == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<TicketMessage>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketMessageCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $TicketMessageCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// @nodoc
mixin _$LegalSection {

 String get key;@JsonKey(name: 'title_ar') String get titleAr;@JsonKey(name: 'title_en') String get titleEn; String get body;
/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalSectionCopyWith<LegalSection> get copyWith => _$LegalSectionCopyWithImpl<LegalSection>(this as LegalSection, _$identity);

  /// Serializes this LegalSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalSection&&(identical(other.key, key) || other.key == key)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,titleAr,titleEn,body);

@override
String toString() {
  return 'LegalSection(key: $key, titleAr: $titleAr, titleEn: $titleEn, body: $body)';
}


}

/// @nodoc
abstract mixin class $LegalSectionCopyWith<$Res>  {
  factory $LegalSectionCopyWith(LegalSection value, $Res Function(LegalSection) _then) = _$LegalSectionCopyWithImpl;
@useResult
$Res call({
 String key,@JsonKey(name: 'title_ar') String titleAr,@JsonKey(name: 'title_en') String titleEn, String body
});




}
/// @nodoc
class _$LegalSectionCopyWithImpl<$Res>
    implements $LegalSectionCopyWith<$Res> {
  _$LegalSectionCopyWithImpl(this._self, this._then);

  final LegalSection _self;
  final $Res Function(LegalSection) _then;

/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? titleAr = null,Object? titleEn = null,Object? body = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LegalSection].
extension LegalSectionPatterns on LegalSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LegalSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LegalSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LegalSection value)  $default,){
final _that = this;
switch (_that) {
case _LegalSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LegalSection value)?  $default,){
final _that = this;
switch (_that) {
case _LegalSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key, @JsonKey(name: 'title_ar')  String titleAr, @JsonKey(name: 'title_en')  String titleEn,  String body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LegalSection() when $default != null:
return $default(_that.key,_that.titleAr,_that.titleEn,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key, @JsonKey(name: 'title_ar')  String titleAr, @JsonKey(name: 'title_en')  String titleEn,  String body)  $default,) {final _that = this;
switch (_that) {
case _LegalSection():
return $default(_that.key,_that.titleAr,_that.titleEn,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key, @JsonKey(name: 'title_ar')  String titleAr, @JsonKey(name: 'title_en')  String titleEn,  String body)?  $default,) {final _that = this;
switch (_that) {
case _LegalSection() when $default != null:
return $default(_that.key,_that.titleAr,_that.titleEn,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LegalSection extends LegalSection {
  const _LegalSection({this.key = '', @JsonKey(name: 'title_ar') this.titleAr = '', @JsonKey(name: 'title_en') this.titleEn = '', this.body = ''}): super._();
  factory _LegalSection.fromJson(Map<String, dynamic> json) => _$LegalSectionFromJson(json);

@override@JsonKey() final  String key;
@override@JsonKey(name: 'title_ar') final  String titleAr;
@override@JsonKey(name: 'title_en') final  String titleEn;
@override@JsonKey() final  String body;

/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalSectionCopyWith<_LegalSection> get copyWith => __$LegalSectionCopyWithImpl<_LegalSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegalSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalSection&&(identical(other.key, key) || other.key == key)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,titleAr,titleEn,body);

@override
String toString() {
  return 'LegalSection(key: $key, titleAr: $titleAr, titleEn: $titleEn, body: $body)';
}


}

/// @nodoc
abstract mixin class _$LegalSectionCopyWith<$Res> implements $LegalSectionCopyWith<$Res> {
  factory _$LegalSectionCopyWith(_LegalSection value, $Res Function(_LegalSection) _then) = __$LegalSectionCopyWithImpl;
@override @useResult
$Res call({
 String key,@JsonKey(name: 'title_ar') String titleAr,@JsonKey(name: 'title_en') String titleEn, String body
});




}
/// @nodoc
class __$LegalSectionCopyWithImpl<$Res>
    implements _$LegalSectionCopyWith<$Res> {
  __$LegalSectionCopyWithImpl(this._self, this._then);

  final _LegalSection _self;
  final $Res Function(_LegalSection) _then;

/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? titleAr = null,Object? titleEn = null,Object? body = null,}) {
  return _then(_LegalSection(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
