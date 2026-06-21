// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceSuggestion _$PlaceSuggestionFromJson(Map<String, dynamic> json) =>
    _PlaceSuggestion(
      placeId: json['place_id'] as String,
      primaryText: json['primary_text'] as String,
      secondaryText: json['secondary_text'] as String?,
      description: json['description'] as String,
    );

Map<String, dynamic> _$PlaceSuggestionToJson(_PlaceSuggestion instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'primary_text': instance.primaryText,
      'secondary_text': instance.secondaryText,
      'description': instance.description,
    };

_PlaceLocation _$PlaceLocationFromJson(Map<String, dynamic> json) =>
    _PlaceLocation(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      name: json['name'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PlaceLocationToJson(_PlaceLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'address': instance.address,
    };

_PlacesAutocompleteResult _$PlacesAutocompleteResultFromJson(
  Map<String, dynamic> json,
) => _PlacesAutocompleteResult(
  suggestions:
      (json['data'] as List<dynamic>?)
          ?.map((e) => PlaceSuggestion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PlaceSuggestion>[],
);

Map<String, dynamic> _$PlacesAutocompleteResultToJson(
  _PlacesAutocompleteResult instance,
) => <String, dynamic>{'data': instance.suggestions};

_PlaceDetailsResult _$PlaceDetailsResultFromJson(Map<String, dynamic> json) =>
    _PlaceDetailsResult(
      location: PlaceLocation.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceDetailsResultToJson(_PlaceDetailsResult instance) =>
    <String, dynamic>{'data': instance.location};
