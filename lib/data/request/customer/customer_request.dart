import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_request.freezed.dart';
part 'customer_request.g.dart';

/// POST /mobile/orders/{id}/rating body — all four axes are required.
@freezed
abstract class RateOrderBody with _$RateOrderBody {
  const factory RateOrderBody({
    @JsonKey(name: 'overall_stars') required int overallStars,
    @JsonKey(name: 'captain_stars') required int captainStars,
    @JsonKey(name: 'order_accuracy_stars') required int orderAccuracyStars,
    @JsonKey(name: 'delivery_speed_stars') required int deliverySpeedStars,
    String? comment,
  }) = _RateOrderBody;

  factory RateOrderBody.fromJson(Map<String, dynamic> json) =>
      _$RateOrderBodyFromJson(json);
}

/// POST /mobile/tickets body (support form).
@freezed
abstract class OpenTicketBody with _$OpenTicketBody {
  const factory OpenTicketBody({
    required String title,
    required String description,
    @Default('inquiry') String category,
    @Default('normal') String priority,
    @JsonKey(name: 'order_id') int? orderId,
  }) = _OpenTicketBody;

  factory OpenTicketBody.fromJson(Map<String, dynamic> json) =>
      _$OpenTicketBodyFromJson(json);
}

/// POST /mobile/tickets/{id}/reply body.
@freezed
abstract class ReplyTicketBody with _$ReplyTicketBody {
  const factory ReplyTicketBody({required String body}) = _ReplyTicketBody;

  factory ReplyTicketBody.fromJson(Map<String, dynamic> json) =>
      _$ReplyTicketBodyFromJson(json);
}
