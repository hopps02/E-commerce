import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_response.freezed.dart';
part 'support_response.g.dart';

/// One message in a support ticket thread. The backend already strips internal
/// staff notes for non-admin audiences, so [isInternalNote] is always false here.
@freezed
abstract class TicketMessage with _$TicketMessage {
  const TicketMessage._();

  const factory TicketMessage({
    required int id,
    @JsonKey(name: 'sender_type') @Default('') String senderType,
    @Default('') String body,
    @JsonKey(name: 'is_internal_note') @Default(false) bool isInternalNote,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _TicketMessage;

  factory TicketMessage.fromJson(Map<String, dynamic> json) =>
      _$TicketMessageFromJson(json);

  /// True when this message was written by the ticket's own author (the
  /// customer/cashier/captain who opened it) rather than the support side —
  /// used to align the chat bubble.
  bool get isFromOpener =>
      senderType == 'Customer' ||
      senderType == 'Cashier' ||
      senderType == 'Captain';
}

/// A support ticket. List rows omit [messages]; the detail + reply payloads
/// carry the full thread (the first message mirrors [description]).
@freezed
abstract class Ticket with _$Ticket {
  const Ticket._();

  const factory Ticket({
    required int id,
    @JsonKey(name: 'ticket_number') @Default('') String ticketNumber,
    String? category,
    String? priority,
    @Default('open') String status,
    @Default('') String title,
    @Default('') String description,
    @JsonKey(name: 'merchant_id') int? merchantId,
    @JsonKey(name: 'merchant_name_ar') String? merchantNameAr,
    @JsonKey(name: 'merchant_name_en') String? merchantNameEn,
    @JsonKey(name: 'opener_name') String? openerName,
    @JsonKey(name: 'branch_id') int? branchId,
    @JsonKey(name: 'order_id') int? orderId,
    List<TicketMessage>? messages,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  bool get isClosed => status == 'closed';

  List<TicketMessage> get thread => messages ?? const [];

  String merchantName(bool arabic) =>
      (arabic ? merchantNameAr : merchantNameEn) ??
      merchantNameAr ??
      merchantNameEn ??
      '';
}

/// One legal/policy section from GET /mobile/legal-policies. [body] may be empty
/// (v1 placeholder) — the screen shows an honest empty state in that case.
@freezed
abstract class LegalSection with _$LegalSection {
  const LegalSection._();

  const factory LegalSection({
    @Default('') String key,
    @JsonKey(name: 'title_ar') @Default('') String titleAr,
    @JsonKey(name: 'title_en') @Default('') String titleEn,
    @Default('') String body,
  }) = _LegalSection;

  factory LegalSection.fromJson(Map<String, dynamic> json) =>
      _$LegalSectionFromJson(json);

  String title(bool arabic) => (arabic ? titleAr : titleEn).trim();

  bool get hasBody => body.trim().isNotEmpty;
}
