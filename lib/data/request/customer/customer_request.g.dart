// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RateOrderBody _$RateOrderBodyFromJson(Map<String, dynamic> json) =>
    _RateOrderBody(
      overallStars: (json['overall_stars'] as num).toInt(),
      captainStars: (json['captain_stars'] as num).toInt(),
      orderAccuracyStars: (json['order_accuracy_stars'] as num).toInt(),
      deliverySpeedStars: (json['delivery_speed_stars'] as num).toInt(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$RateOrderBodyToJson(_RateOrderBody instance) =>
    <String, dynamic>{
      'overall_stars': instance.overallStars,
      'captain_stars': instance.captainStars,
      'order_accuracy_stars': instance.orderAccuracyStars,
      'delivery_speed_stars': instance.deliverySpeedStars,
      'comment': instance.comment,
    };

_OpenTicketBody _$OpenTicketBodyFromJson(Map<String, dynamic> json) =>
    _OpenTicketBody(
      title: json['title'] as String,
      description: json['description'] as String,
      orderId: (json['order_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OpenTicketBodyToJson(_OpenTicketBody instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'order_id': instance.orderId,
    };
