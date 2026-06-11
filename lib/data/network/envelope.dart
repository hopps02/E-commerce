import 'package:freezed_annotation/freezed_annotation.dart';

part 'envelope.freezed.dart';
part 'envelope.g.dart';

/// The backend's canonical success envelope: `{data: ...}` for a single
/// resource and `{data: [...], meta: {...}}` for paginated lists.
///
/// Errors never reach this type — the backend signals them with a non-2xx
/// status and `{error: {code, message, details}}`, which Dio surfaces as a
/// DioException handled by the error handler.
@Freezed(genericArgumentFactories: true)
abstract class Envelope<T> with _$Envelope<T> {
  const factory Envelope({required T data, Meta? meta}) = _Envelope<T>;

  factory Envelope.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$EnvelopeFromJson(json, fromJsonT);
}

/// Pagination block accompanying list responses.
@freezed
abstract class Meta with _$Meta {
  const factory Meta({
    @Default(1) int page,
    @JsonKey(name: 'page_size') @Default(20) int pageSize,
    @Default(0) int total,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}
