// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthInitRequest _$AuthInitRequestFromJson(Map<String, dynamic> json) =>
    _AuthInitRequest(
      email: json['email'] as String,
      birthDate: const DateTimeConverter().fromJson(
        json['birth_date'] as String,
      ),
    );

Map<String, dynamic> _$AuthInitRequestToJson(_AuthInitRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'birth_date': const DateTimeConverter().toJson(instance.birthDate),
    };
