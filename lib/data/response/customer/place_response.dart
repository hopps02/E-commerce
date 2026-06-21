import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_response.freezed.dart';
part 'place_response.g.dart';

@freezed
abstract class PlaceSuggestion with _$PlaceSuggestion {
  const factory PlaceSuggestion({
    @JsonKey(name: 'place_id') required String placeId,
    @JsonKey(name: 'primary_text') required String primaryText,
    @JsonKey(name: 'secondary_text') String? secondaryText,
    required String description,
  }) = _PlaceSuggestion;

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) =>
      _$PlaceSuggestionFromJson(json);
}

@freezed
abstract class PlaceLocation with _$PlaceLocation {
  const factory PlaceLocation({
    required double lat,
    required double lng,
    String? name,
    String? address,
  }) = _PlaceLocation;

  factory PlaceLocation.fromJson(Map<String, dynamic> json) =>
      _$PlaceLocationFromJson(json);
}

@freezed
abstract class PlacesAutocompleteResult with _$PlacesAutocompleteResult {
  const factory PlacesAutocompleteResult({
    @JsonKey(name: 'data')
    @Default(<PlaceSuggestion>[])
    List<PlaceSuggestion> suggestions,
  }) = _PlacesAutocompleteResult;

  factory PlacesAutocompleteResult.fromJson(Map<String, dynamic> json) =>
      _$PlacesAutocompleteResultFromJson(json);
}

@freezed
abstract class PlaceDetailsResult with _$PlaceDetailsResult {
  const factory PlaceDetailsResult({
    @JsonKey(name: 'data') required PlaceLocation location,
  }) = _PlaceDetailsResult;

  factory PlaceDetailsResult.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsResultFromJson(json);
}
