import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'delivery_zone_response.freezed.dart';
part 'delivery_zone_response.g.dart';

@freezed
abstract class MapDeliveryZone with _$MapDeliveryZone {
  const MapDeliveryZone._();

  const factory MapDeliveryZone({
    required int id,
    @JsonKey(name: 'city_id') required int cityId,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'delivery_fee_halalas') int? deliveryFeeHalalas,
    @JsonKey(
      name: 'polygon_geojson',
      fromJson: _polygonFromJson,
      includeToJson: false,
    )
    @Default(<LatLng>[])
    List<LatLng> polygon,
  }) = _MapDeliveryZone;

  factory MapDeliveryZone.fromJson(Map<String, dynamic> json) =>
      _$MapDeliveryZoneFromJson(json);

  String name(bool arabic) =>
      (arabic ? nameAr : nameEn) ?? nameAr ?? nameEn ?? '';
}

@freezed
abstract class CityCenter with _$CityCenter {
  const CityCenter._();

  const factory CityCenter({
    required int id,
    @JsonKey(name: 'name_ar') String? nameAr,
    @JsonKey(name: 'name_en') String? nameEn,
    @JsonKey(name: 'center_lat') double? centerLat,
    @JsonKey(name: 'center_lng') double? centerLng,
    @JsonKey(name: 'default_zoom') @Default(12) int defaultZoom,
  }) = _CityCenter;

  factory CityCenter.fromJson(Map<String, dynamic> json) =>
      _$CityCenterFromJson(json);

  String name(bool arabic) =>
      (arabic ? nameAr : nameEn) ?? nameAr ?? nameEn ?? '';
}

@freezed
abstract class DeliveryZonesResult with _$DeliveryZonesResult {
  const factory DeliveryZonesResult({
    @JsonKey(name: 'data')
    @Default(<MapDeliveryZone>[])
    List<MapDeliveryZone> zones,
    @JsonKey(readValue: _readCityCenter) CityCenter? city,
  }) = _DeliveryZonesResult;

  factory DeliveryZonesResult.fromJson(Map<String, dynamic> json) =>
      _$DeliveryZonesResultFromJson(json);
}

Object? _readCityCenter(Map<dynamic, dynamic> json, String key) {
  final meta = json['meta'];
  if (meta is Map<dynamic, dynamic>) return meta['city'];
  return null;
}

List<LatLng> _polygonFromJson(Object? polygonGeojson) {
  if (polygonGeojson is! Map<dynamic, dynamic>) return const [];

  final coordinates = polygonGeojson['coordinates'];
  if (coordinates is! List || coordinates.isEmpty) return const [];

  final exteriorRing = coordinates.first;
  if (exteriorRing is! List) return const [];

  return exteriorRing
      .map(_latLngFromGeoJsonPosition)
      .whereType<LatLng>()
      .toList(growable: false);
}

LatLng? _latLngFromGeoJsonPosition(Object? position) {
  if (position is! List || position.length < 2) return null;

  final lng = _asDouble(position[0]);
  final lat = _asDouble(position[1]);
  if (lat == null || lng == null) return null;

  return LatLng(lat, lng);
}

double? _asDouble(Object? coordinate) {
  if (coordinate is num) return coordinate.toDouble();
  if (coordinate is String) return double.tryParse(coordinate);
  return null;
}
