// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_zone_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapDeliveryZone _$MapDeliveryZoneFromJson(Map<String, dynamic> json) =>
    _MapDeliveryZone(
      id: (json['id'] as num).toInt(),
      cityId: (json['city_id'] as num).toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      deliveryFeeHalalas: (json['delivery_fee_halalas'] as num?)?.toInt(),
      polygon: json['polygon_geojson'] == null
          ? const <LatLng>[]
          : _polygonFromJson(json['polygon_geojson']),
    );

Map<String, dynamic> _$MapDeliveryZoneToJson(_MapDeliveryZone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city_id': instance.cityId,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'delivery_fee_halalas': instance.deliveryFeeHalalas,
    };

_CityCenter _$CityCenterFromJson(Map<String, dynamic> json) => _CityCenter(
  id: (json['id'] as num).toInt(),
  nameAr: json['name_ar'] as String?,
  nameEn: json['name_en'] as String?,
  centerLat: (json['center_lat'] as num?)?.toDouble(),
  centerLng: (json['center_lng'] as num?)?.toDouble(),
  defaultZoom: (json['default_zoom'] as num?)?.toInt() ?? 12,
);

Map<String, dynamic> _$CityCenterToJson(_CityCenter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'center_lat': instance.centerLat,
      'center_lng': instance.centerLng,
      'default_zoom': instance.defaultZoom,
    };

_DeliveryZonesResult _$DeliveryZonesResultFromJson(Map<String, dynamic> json) =>
    _DeliveryZonesResult(
      zones:
          (json['data'] as List<dynamic>?)
              ?.map((e) => MapDeliveryZone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MapDeliveryZone>[],
      city: _readCityCenter(json, 'city') == null
          ? null
          : CityCenter.fromJson(
              _readCityCenter(json, 'city') as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DeliveryZonesResultToJson(
  _DeliveryZonesResult instance,
) => <String, dynamic>{'data': instance.zones, 'city': instance.city};
