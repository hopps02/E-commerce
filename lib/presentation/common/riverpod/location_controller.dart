import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/services/location_service.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/domain/usecase/coverage_check_usecase.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

enum ServingBranchStatus {
  noAddress,
  hasAddress,
  resolving,
  serviceable,
  noStoreInZone,
  outsideZone,
}

class LocationState extends Equatable {
  static const _unchanged = Object();

  final String? locationCity;
  final double? latitude;
  final double? longitude;
  final DeliveryAddress? selectedAddress;
  final int? servingBranchId;
  final bool servingBranchServiceable;
  final ServingBranchStatus servingBranchStatus;
  final String servingBranchErrorMessage;

  const LocationState({
    this.locationCity,
    this.latitude,
    this.longitude,
    this.selectedAddress,
    this.servingBranchId,
    this.servingBranchServiceable = false,
    this.servingBranchStatus = ServingBranchStatus.noAddress,
    this.servingBranchErrorMessage = '',
  });

  int? get selectedAddressId => selectedAddress?.id;

  bool get canBrowseCatalog =>
      servingBranchStatus == ServingBranchStatus.serviceable &&
      servingBranchId != null;

  String get browseUnavailableMessage {
    if (servingBranchErrorMessage.trim().isNotEmpty) {
      return servingBranchErrorMessage;
    }
    return switch (servingBranchStatus) {
      ServingBranchStatus.noStoreInZone => Translation.home_no_store_title.tr,
      ServingBranchStatus.outsideZone =>
        Translation.error_outside_delivery_zone.tr,
      ServingBranchStatus.resolving => Translation.map_checking_coverage.tr,
      _ => Translation.home_choose_location_title.tr,
    };
  }

  LocationState copyWith({
    String? locationCity,
    double? latitude,
    double? longitude,
    Object? selectedAddress = _unchanged,
    Object? servingBranchId = _unchanged,
    bool? servingBranchServiceable,
    ServingBranchStatus? servingBranchStatus,
    String? servingBranchErrorMessage,
  }) {
    return LocationState(
      locationCity: locationCity ?? this.locationCity,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      selectedAddress: identical(selectedAddress, _unchanged)
          ? this.selectedAddress
          : selectedAddress as DeliveryAddress?,
      servingBranchId: identical(servingBranchId, _unchanged)
          ? this.servingBranchId
          : servingBranchId as int?,
      servingBranchServiceable:
          servingBranchServiceable ?? this.servingBranchServiceable,
      servingBranchStatus: servingBranchStatus ?? this.servingBranchStatus,
      servingBranchErrorMessage:
          servingBranchErrorMessage ?? this.servingBranchErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    locationCity,
    latitude,
    longitude,
    selectedAddress,
    servingBranchId,
    servingBranchServiceable,
    servingBranchStatus,
    servingBranchErrorMessage,
  ];
}

class LocationNotifier extends Notifier<LocationState> {
  static const _selectedAddressStorageKey = 'selected-delivery-address';
  int _coverageRequestId = 0;

  @override
  LocationState build() {
    // Initialize location city from storage if available
    final storage = DI().storageService;

    Future.microtask(() async {
      final storedLocation = await storage.getLocationData();
      final savedAddress = _storedSelectedAddress();
      if (savedAddress != null) {
        _setActiveAddress(savedAddress);
        await _resolveServingBranchFor(savedAddress);
      } else if (storedLocation.address != null) {
        state = LocationState(
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
    _coverageRequestId++;
    state = LocationState(
      locationCity: address,
      latitude: latitude,
      longitude: longitude,
    );
    await DI().storageService.saveLocationData(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
    await DI().storageService.deleteMap(_selectedAddressStorageKey);
  }

  Future<void> setSelectedAddress(DeliveryAddress address) async {
    _setActiveAddress(address);
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
    await _resolveServingBranchFor(address);
  }

  Future<void> resolveSelectedAddressBranch() async {
    final address = state.selectedAddress;
    if (address == null) {
      _coverageRequestId++;
      state = state.copyWith(
        servingBranchId: null,
        servingBranchServiceable: false,
        servingBranchStatus: ServingBranchStatus.noAddress,
        servingBranchErrorMessage: '',
      );
      return;
    }
    await _resolveServingBranchFor(address);
  }

  void _setActiveAddress(DeliveryAddress address) {
    state = LocationState(
      locationCity: address.displayAddress,
      latitude: address.lat,
      longitude: address.lng,
      selectedAddress: address,
      servingBranchStatus: ServingBranchStatus.hasAddress,
    );
  }

  Future<void> _resolveServingBranchFor(DeliveryAddress address) async {
    final lat = address.lat;
    final lng = address.lng;
    if (lat == null || lng == null) {
      state = state.copyWith(
        servingBranchId: null,
        servingBranchServiceable: false,
        servingBranchStatus: ServingBranchStatus.hasAddress,
        servingBranchErrorMessage: '',
      );
      return;
    }

    final requestId = ++_coverageRequestId;
    state = state.copyWith(
      servingBranchId: null,
      servingBranchServiceable: false,
      servingBranchStatus: ServingBranchStatus.resolving,
      servingBranchErrorMessage: '',
    );

    final coverage = await DI().coverageCheckUseCase.execute(
      CoverageCheckParams(lat: lat, lng: lng, cityId: address.cityId),
    );
    if (requestId != _coverageRequestId) return;

    coverage.fold(_applyServingBranchFailure, _applyServingBranchCoverage);
  }

  void _applyServingBranchCoverage(CoverageResult coverage) {
    final branchId = coverage.branchId ?? coverage.servingBranch?.id;
    if (coverage.isServiceable && branchId != null) {
      state = state.copyWith(
        servingBranchId: branchId,
        servingBranchServiceable: true,
        servingBranchStatus: ServingBranchStatus.serviceable,
        servingBranchErrorMessage: '',
      );
      return;
    }

    state = state.copyWith(
      servingBranchId: null,
      servingBranchServiceable: false,
      servingBranchStatus: coverage.inActiveZone
          ? ServingBranchStatus.noStoreInZone
          : ServingBranchStatus.outsideZone,
      servingBranchErrorMessage: '',
    );
  }

  void _applyServingBranchFailure(Failure failure) {
    final outsideZone =
        failure is ServerError && failure.code == 'outside_delivery_zone';
    state = state.copyWith(
      servingBranchId: null,
      servingBranchServiceable: false,
      servingBranchStatus: outsideZone
          ? ServingBranchStatus.outsideZone
          : ServingBranchStatus.hasAddress,
      servingBranchErrorMessage: outsideZone ? '' : failure.displayMessage,
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
