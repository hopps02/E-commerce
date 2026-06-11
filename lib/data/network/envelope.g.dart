// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Envelope<T> _$EnvelopeFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _Envelope<T>(
  data: fromJsonT(json['data']),
  meta: json['meta'] == null
      ? null
      : Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EnvelopeToJson<T>(
  _Envelope<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{'data': toJsonT(instance.data), 'meta': instance.meta};

_Meta _$MetaFromJson(Map<String, dynamic> json) => _Meta(
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['page_size'] as num?)?.toInt() ?? 20,
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MetaToJson(_Meta instance) => <String, dynamic>{
  'page': instance.page,
  'page_size': instance.pageSize,
  'total': instance.total,
};
