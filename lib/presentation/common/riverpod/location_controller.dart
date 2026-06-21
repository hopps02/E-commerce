import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/services/location_service.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class LocationState extends Equatable {
  static const _unchanged = Object();

  final String? locationCity;
  final double? latitude;
  final double? longitude;
  final DeliveryAddress? selectedAddress;

  const LocationState({
    this.locationCity,
    this.latitude,
    this.longitude,
    this.selectedAddress,
  });

  int? get selectedAddressId => selectedAddress?.id;

  LocationState copyWith({
    String? locationCity,
    double? latitude,
    double? longitude,
    Object? selectedAddress = _unchanged,
  }) {
    return LocationState(
      locationCity: locationCity ?? this.locationCity,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      selectedAddress: identical(selectedAddress, _unchanged)
          ? this.selectedAddress
          : selectedAddress as DeliveryAddress?,
    );
  }

  @override
  List<Object?> get props => [
    locationCity,
    latitude,
    longitude,
    selectedAddress,
  ];
}

class LocationNotifier extends Notifier<LocationState> {
  static const _selectedAddressStorageKey = 'selected-delivery-address';

  @override
  LocationState build() {
    // Initialize location city from storage if available
    final storage = DI().storageService;

    Future.microtask(() async {
      final storedLocation = await storage.getLocationData();
      final savedAddress = _storedSelectedAddress();
      if (savedAddress != null) {
        state = state.copyWith(
          locationCity: savedAddress.displayAddress,
          latitude: savedAddress.lat,
          longitude: savedAddress.lng,
          selectedAddress: savedAddress,
        );
      } else if (storedLocation.address != null) {
        state = state.copyWith(
          locationCity: storedLocation.address,
          latitude: storedLocation.latitude,
          longitude: storedLocation.longitude,
        );
      } else {
        state = state.copyWith();
      }
    });

    return const LocationState();
  }

  Future<bool> handleLocationPermissionAndFetch() async {
    final position = await LocationService.instance.determinePosition();
    if (position == null) return false;

    final address = await getAddressFromLatLng(position);
    if (address != null) {
      await setLocationCity(
        address: address,
        latitude: position.latitude,
        longitude: position.longitude,
      );
      return true;
    }
    return false;
  }

  Future<String?> getAddressFromLatLng(Position latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      Placemark placemark = placemarks.length > 1
          ? placemarks[1]
          : placemarks.first;

      String cityName =
          placemark.locality ??
          placemark.subAdministrativeArea ??
          placemark.administrativeArea ??
          placemark.thoroughfare ??
          placemark.name ??
          Translation.unknown_location.tr;

      return cityName;
    } catch (e) {
      DI().snackBarHelper.showMessage(
        Translation.something_is_wrong.tr,
        ErrorMessage.snackBar,
      );
      return null;
    }
  }

  Future<void> setLocationCity({
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    state = state.copyWith(
      locationCity: address,
      latitude: latitude,
      longitude: longitude,
      selectedAddress: null,
    );
    await DI().storageService.saveLocationData(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
    await DI().storageService.deleteMap(_selectedAddressStorageKey);
  }

  Future<void> setSelectedAddress(DeliveryAddress address) async {
    state = LocationState(
      locationCity: address.displayAddress,
      latitude: address.lat,
      longitude: address.lng,
      selectedAddress: address,
    );
    if (address.lat != null && address.lng != null) {
      await DI().storageService.saveLocationData(
        latitude: address.lat!,
        longitude: address.lng!,
        address: address.displayAddress,
      );
    }
    await DI().storageService.setMap(
      _selectedAddressStorageKey,
      address.toJson(),
    );
  }

  DeliveryAddress? _storedSelectedAddress() {
    final json = DI().storageService.getMap(_selectedAddressStorageKey);
    if (json == null) return null;
    return DeliveryAddress.fromJson(json);
  }
}

final locationController = NotifierProvider<LocationNotifier, LocationState>(
  LocationNotifier.new,
);
