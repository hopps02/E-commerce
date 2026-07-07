import 'package:for_u/data/response/customer/catalog_response.dart';

class MapLocationPickerArgs {
  final double? initialLat;
  final double? initialLng;
  final int? cityId;
  final bool useCurrentLocation;

  const MapLocationPickerArgs({
    this.initialLat,
    this.initialLng,
    this.cityId,
    this.useCurrentLocation = false,
  });

  factory MapLocationPickerArgs.fromAddress(
    DeliveryAddress address, {
    bool useCurrentLocation = false,
  }) => MapLocationPickerArgs(
    initialLat: address.lat,
    initialLng: address.lng,
    cityId: address.cityId,
    useCurrentLocation: useCurrentLocation,
  );
}

class MapLocationPickerResult {
  final double lat;
  final double lng;
  final int cityId;
  final int? deliveryZoneId;
  final String? deliveryZoneNameAr;
  final String? deliveryZoneNameEn;
  final int? deliveryFeeHalalas;
  final String? street;
  final String? buildingNumber;
  final String? area;
  final String? displayAddressSuggestion;

  const MapLocationPickerResult({
    required this.lat,
    required this.lng,
    required this.cityId,
    this.deliveryZoneId,
    this.deliveryZoneNameAr,
    this.deliveryZoneNameEn,
    this.deliveryFeeHalalas,
    this.street,
    this.buildingNumber,
    this.area,
    this.displayAddressSuggestion,
  });

  String zoneName(bool arabic) =>
      (arabic ? deliveryZoneNameAr : deliveryZoneNameEn) ??
      deliveryZoneNameAr ??
      deliveryZoneNameEn ??
      '';

  DeliveryAddress toSessionAddress() => DeliveryAddress(
    id: 0,
    label: 'other',
    displayAddress: _sessionDisplayAddress(),
    street: street,
    buildingNumber: buildingNumber,
    cityId: cityId,
    lat: lat,
    lng: lng,
  );

  String _sessionDisplayAddress() {
    for (final value in [
      displayAddressSuggestion,
      area,
      street,
      deliveryZoneNameEn,
      deliveryZoneNameAr,
    ]) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) return trimmed;
    }
    return '';
  }
}
