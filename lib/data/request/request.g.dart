// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthInitRequest _$AuthInitRequestFromJson(Map<String, dynamic> json) =>
    _AuthInitRequest(
      email: json['email'] as String,
      birthDate: const DateTimeConverter().fromJson(
        json['birthDate'] as String,
      ),
    );

Map<String, dynamic> _$AuthInitRequestToJson(_AuthInitRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'birthDate': const DateTimeConverter().toJson(instance.birthDate),
    };
