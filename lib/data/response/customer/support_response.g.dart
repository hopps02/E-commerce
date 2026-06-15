// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TicketMessage _$TicketMessageFromJson(Map<String, dynamic> json) =>
    _TicketMessage(
      id: (json['id'] as num?)?.toInt() ?? 0,
      senderType: json['sender_type'] as String? ?? '',
      body: json['body'] as String? ?? '',
      isInternalNote: json['is_internal_note'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TicketMessageToJson(_TicketMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_type': instance.senderType,
      'body': instance.body,
      'is_internal_note': instance.isInternalNote,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_Ticket _$TicketFromJson(Map<String, dynamic> json) => _Ticket(
  id: (json['id'] as num).toInt(),
  ticketNumber: json['ticket_number'] as String? ?? '',
  category: json['category'] as String?,
  priority: json['priority'] as String?,
  status: json['status'] as String? ?? 'open',
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  merchantId: (json['merchant_id'] as num?)?.toInt(),
  merchantNameAr: json['merchant_name_ar'] as String?,
  merchantNameEn: json['merchant_name_en'] as String?,
  openerName: json['opener_name'] as String?,
  branchId: (json['branch_id'] as num?)?.toInt(),
  orderId: (json['order_id'] as num?)?.toInt(),
  lastMessage: json['last_message'] == null
      ? null
      : TicketMessage.fromJson(json['last_message'] as Map<String, dynamic>),
  messages: (json['messages'] as List<dynamic>?)
      ?.map((e) => TicketMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TicketToJson(_Ticket instance) => <String, dynamic>{
  'id': instance.id,
  'ticket_number': instance.ticketNumber,
  'category': instance.category,
  'priority': instance.priority,
  'status': instance.status,
  'title': instance.title,
  'description': instance.description,
  'merchant_id': instance.merchantId,
  'merchant_name_ar': instance.merchantNameAr,
  'merchant_name_en': instance.merchantNameEn,
  'opener_name': instance.openerName,
  'branch_id': instance.branchId,
  'order_id': instance.orderId,
  'last_message': instance.lastMessage,
  'messages': instance.messages,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

_LegalSection _$LegalSectionFromJson(Map<String, dynamic> json) =>
    _LegalSection(
      key: json['key'] as String? ?? '',
      titleAr: json['title_ar'] as String? ?? '',
      titleEn: json['title_en'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );

Map<String, dynamic> _$LegalSectionToJson(_LegalSection instance) =>
    <String, dynamic>{
      'key': instance.key,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'body': instance.body,
    };
