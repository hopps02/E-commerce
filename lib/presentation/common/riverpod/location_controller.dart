import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/services/location_service.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class LocationState extends Equatable {
  final String? locationCity;
  final double? latitude;
  final double? longitude;

  const LocationState({this.locationCity, this.latitude, this.longitude});

  LocationState copyWith({
    String? locationCity,
    double? latitude,
    double? longitude,
  }) {
    return LocationState(
      locationCity: locationCity ?? this.locationCity,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [locationCity, latitude, longitude];
}

class LocationNotifier extends Notifier<LocationState> {
  @override
  LocationState build() {
    // Initialize location city from storage if available
    final storage = DI().storageService;

    Future.microtask(() async {
      final data = await storage.getLocationData();
      if (data.address != null) {
        state = state.copyWith(
          locationCity: data.address,
          latitude: data.latitude,
          longitude: data.longitude,
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
    );
    await DI().storageService.saveLocationData(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }
}

final locationController = NotifierProvider<LocationNotifier, LocationState>(
  LocationNotifier.new,
);
