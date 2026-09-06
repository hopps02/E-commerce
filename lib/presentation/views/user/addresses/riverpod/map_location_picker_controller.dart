import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/services/location_service.dart';
import 'package:store/app/services/reverse_geocode_service.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/response/customer/delivery_zone_response.dart';
import 'package:store/data/response/customer/place_response.dart';
import 'package:store/domain/usecase/coverage_check_usecase.dart';
import 'package:store/domain/usecase/get_delivery_zones_usecase.dart';
import 'package:store/domain/usecase/places_autocomplete_usecase.dart';
import 'package:store/domain/usecase/places_details_usecase.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/addresses/model/map_location_picker_models.dart';

const _fallbackTarget = LatLng(30.0444, 31.2357);

enum MapCoverageStatus {
  idle,
  checking,
  serviceable,
  unavailableBranch,
  outside,
  networkError,
  noZones,
}

class MapLocationPickerState extends Equatable {
  final LatLng cameraTarget;
  final double zoom;
  final LatLng? pickedPoint;
  final List<MapDeliveryZone> zones;
  final CityCenter? city;
  final bool zonesLoading;
  final String zonesErrorMessage;
  final bool zonesFromCache;
  final bool permissionDenied;
  final bool permissionDeniedForever;
  final bool locating;
  final bool searching;
  final List<PlaceSuggestion> suggestions;
  final MapCoverageStatus coverageStatus;
  final String coverageErrorMessage;
  final CoverageResult? coverage;
  final ReverseGeocodeResult? reverseGeocode;

  const MapLocationPickerState({
    this.cameraTarget = _fallbackTarget,
    this.zoom = 12,
    this.pickedPoint,
    this.zones = const [],
    this.city,
    this.zonesLoading = false,
    this.zonesErrorMessage = '',
    this.zonesFromCache = false,
    this.permissionDenied = false,
    this.permissionDeniedForever = false,
    this.locating = false,
    this.searching = false,
    this.suggestions = const [],
    this.coverageStatus = MapCoverageStatus.idle,
    this.coverageErrorMessage = '',
    this.coverage,
    this.reverseGeocode,
  });

  bool get canConfirm =>
      coverageStatus == MapCoverageStatus.serviceable &&
      coverage?.cityId != null;

  bool get hasZoneFetchFailure =>
      zonesErrorMessage.trim().isNotEmpty && zones.isEmpty && !zonesLoading;

  MapLocationPickerState copyWith({
    LatLng? cameraTarget,
    double? zoom,
    LatLng? pickedPoint,
    List<MapDeliveryZone>? zones,
    CityCenter? city,
    bool? zonesLoading,
    String? zonesErrorMessage,
    bool? zonesFromCache,
    bool? permissionDenied,
    bool? permissionDeniedForever,
    bool? locating,
    bool? searching,
    List<PlaceSuggestion>? suggestions,
    MapCoverageStatus? coverageStatus,
    String? coverageErrorMessage,
    CoverageResult? coverage,
    ReverseGeocodeResult? reverseGeocode,
    bool clearCoverage = false,
    bool clearReverseGeocode = false,
  }) {
    return MapLocationPickerState(
      cameraTarget: cameraTarget ?? this.cameraTarget,
      zoom: zoom ?? this.zoom,
      pickedPoint: pickedPoint ?? this.pickedPoint,
      zones: zones ?? this.zones,
      city: city ?? this.city,
      zonesLoading: zonesLoading ?? this.zonesLoading,
      zonesErrorMessage: zonesErrorMessage ?? this.zonesErrorMessage,
      zonesFromCache: zonesFromCache ?? this.zonesFromCache,
      permissionDenied: permissionDenied ?? this.permissionDenied,
      permissionDeniedForever:
          permissionDeniedForever ?? this.permissionDeniedForever,
      locating: locating ?? this.locating,
      searching: searching ?? this.searching,
      suggestions: suggestions ?? this.suggestions,
      coverageStatus: coverageStatus ?? this.coverageStatus,
      coverageErrorMessage:
          coverageErrorMessage ?? this.coverageErrorMessage,
      coverage: clearCoverage ? null : coverage ?? this.coverage,
      reverseGeocode: clearReverseGeocode
          ? null
          : reverseGeocode ?? this.reverseGeocode,
    );
  }

  @override
  List<Object?> get props => [
    cameraTarget,
    zoom,
    pickedPoint,
    zones,
    city,
    zonesLoading,
    zonesErrorMessage,
    zonesFromCache,
    permissionDenied,
    permissionDeniedForever,
    locating,
    searching,
    suggestions,
    coverageStatus,
    coverageErrorMessage,
    coverage,
    reverseGeocode,
  ];
}

class MapLocationPickerNotifier extends Notifier<MapLocationPickerState> {
  static final Map<String, _ZonesCacheEntry> _zonesCache = {};

  Timer? _coverageDebounce;
  Timer? _searchDebounce;
  int _coverageRequestId = 0;
  int _searchRequestId = 0;
  int _placesSessionCounter = 0;
  String? _placesSessionToken;
  MapLocationPickerArgs _args = const MapLocationPickerArgs();

  @override
  MapLocationPickerState build() {
    ref.onDispose(() {
      _coverageDebounce?.cancel();
      _searchDebounce?.cancel();
    });
    return const MapLocationPickerState();
  }

  Future<void> load(MapLocationPickerArgs args) async {
    _args = args;
    _cancelSearchSession();
    state = const MapLocationPickerState(zonesLoading: true);

    final editPoint = _editPoint(args);
    // Only auto-fetch GPS when the caller explicitly opened the "use my
    // location" flow. Opening the picker normally must NOT jump to the user's
    // location — it centers on the city/default and waits for the user.
    final gpsPoint = args.useCurrentLocation ? await _fetchGpsPoint() : null;
    final target = editPoint ?? gpsPoint ?? _fallbackTarget;
    // No auto-error snackbar here: when GPS is unavailable (common on web) we
    // silently fall back to the city/default center and let the user place the
    // pin manually or tap "use my location". The manual path still reports.

    await _loadZones(
      _ZoneLoadRequest(
        cityId: args.cityId,
        lat: editPoint != null || gpsPoint != null ? target.latitude : null,
        lng: editPoint != null || gpsPoint != null ? target.longitude : null,
        target: target,
        useCityCenter: editPoint == null && gpsPoint == null,
      ),
    );
    onCameraIdle(state.cameraTarget);
  }

  Future<void> retryZones() async {
    final target = state.pickedPoint ?? state.cameraTarget;
    await _loadZones(
      _ZoneLoadRequest(
        cityId: _args.cityId,
        lat: target.latitude,
        lng: target.longitude,
        target: target,
        useCityCenter: false,
      ),
    );
  }

  Future<void> recenterToGps() async {
    state = state.copyWith(locating: true);
    final gpsPoint = await _fetchGpsPoint();
    state = state.copyWith(locating: false);
    if (gpsPoint == null) {
      DI().snackBarHelper.showMessage(
        Translation.location_fetch_failed.tr,
        ErrorMessage.snackBar,
      );
      return;
    }

    state = state.copyWith(cameraTarget: gpsPoint, zoom: 15);
    onCameraIdle(gpsPoint);
  }

  void onSearchChanged(String query) {
    final trimmedQuery = query.trim();
    _searchDebounce?.cancel();
    final requestId = ++_searchRequestId;

    if (trimmedQuery.length < 2) {
      _resetPlacesSession();
      state = state.copyWith(suggestions: const [], searching: false);
      return;
    }

    final session = _ensurePlacesSession();
    state = state.copyWith(searching: true);
    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      final response = await DI().placesAutocompleteUseCase.execute(
        PlacesAutocompleteParams(query: trimmedQuery, session: session),
      );
      if (requestId != _searchRequestId) return;

      response.fold(
        (_) => _applyAutocompleteFailure(),
        _applyAutocompleteSuccess,
      );
    });
  }

  Future<void> selectSuggestion(PlaceSuggestion suggestion) async {
    _searchDebounce?.cancel();
    final session = _ensurePlacesSession();
    final requestId = ++_searchRequestId;
    state = state.copyWith(suggestions: const [], searching: true);

    final response = await DI().placesDetailsUseCase.execute(
      PlacesDetailsParams(placeId: suggestion.placeId, session: session),
    );
    if (requestId != _searchRequestId) return;

    response.fold(
      (_) => _applyPlaceDetailsFailure(),
      _applyPlaceDetailsSuccess,
    );
  }

  void clearSearch() {
    _cancelSearchSession();
    state = state.copyWith(suggestions: const [], searching: false);
  }

  void _cancelSearchSession() {
    _searchDebounce?.cancel();
    _resetPlacesSession();
    _searchRequestId++;
  }

  void onCameraIdle(LatLng center) {
    state = state.copyWith(pickedPoint: center);
    _coverageDebounce?.cancel();
    _coverageDebounce = Timer(
      const Duration(milliseconds: 400),
      () => _checkCoverage(center),
    );
  }

  Future<void> retryCoverage() async {
    final point = state.pickedPoint ?? state.cameraTarget;
    await _checkCoverage(point);
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  void _showSearchNoResults() {
    DI().snackBarHelper.showMessage(
      Translation.map_search_no_results.tr,
      ErrorMessage.snackBar,
    );
  }

  void _applyAutocompleteFailure() {
    state = state.copyWith(suggestions: const [], searching: false);
  }

  void _applyAutocompleteSuccess(List<PlaceSuggestion> suggestions) {
    state = state.copyWith(suggestions: suggestions, searching: false);
  }

  void _applyPlaceDetailsFailure() {
    _showSearchNoResults();
    state = state.copyWith(suggestions: const [], searching: false);
  }

  void _applyPlaceDetailsSuccess(PlaceLocation location) {
    final point = LatLng(location.lat, location.lng);
    _resetPlacesSession();
    state = state.copyWith(
      cameraTarget: point,
      zoom: 16,
      suggestions: const [],
      searching: false,
    );
    onCameraIdle(point);
  }

  String _ensurePlacesSession() =>
      _placesSessionToken ??= _generatePlacesSession();

  String _generatePlacesSession() {
    _placesSessionCounter += 1;
    return '${DateTime.now().microsecondsSinceEpoch}-$_placesSessionCounter';
  }

  void _resetPlacesSession() {
    _placesSessionToken = null;
  }

  MapLocationPickerResult? confirmResult() {
    final point = state.pickedPoint ?? state.cameraTarget;
    final coverage = state.coverage;
    final cityId = coverage?.cityId;
    if (!state.canConfirm || cityId == null) return null;

    return MapLocationPickerResult(
      lat: point.latitude,
      lng: point.longitude,
      cityId: cityId,
      deliveryZoneId: coverage?.deliveryZoneId,
      deliveryZoneNameAr: coverage?.deliveryZoneNameAr,
      deliveryZoneNameEn: coverage?.deliveryZoneNameEn,
      deliveryFeeHalalas: coverage?.deliveryFeeHalalas,
      street: state.reverseGeocode?.street,
      buildingNumber: state.reverseGeocode?.buildingNumber,
      area: state.reverseGeocode?.area,
      displayAddressSuggestion: state.reverseGeocode?.displayAddress,
    );
  }

  LatLng? _editPoint(MapLocationPickerArgs args) {
    if (args.initialLat == null || args.initialLng == null) return null;
    return LatLng(args.initialLat!, args.initialLng!);
  }

  Future<LatLng?> _fetchGpsPoint() async {
    // Fetch the raw GPS position directly. We deliberately avoid
    // handleLocationPermissionAndFetch()'s reverse-geocoding step: the
    // `geocoding` package has no web implementation, so on web it throws and
    // the whole fetch would report failure even when the browser granted the
    // position. The picker only needs coordinates here — it reverse-geocodes
    // itself later via ReverseGeocodeService.
    final position = await LocationService.instance
        .determinePosition()
        .timeout(const Duration(seconds: 12), onTimeout: () => null);

    final permission = await Geolocator.checkPermission();
    state = state.copyWith(
      permissionDenied: permission == LocationPermission.denied,
      permissionDeniedForever: permission == LocationPermission.deniedForever,
    );

    if (position == null) return null;
    return LatLng(position.latitude, position.longitude);
  }

  Future<void> _loadZones(_ZoneLoadRequest zoneRequest) async {
    final requestKey = _cacheKey(zoneRequest.cityId);
    state = state.copyWith(
      zonesLoading: true,
      zonesErrorMessage: '',
      zonesFromCache: false,
      cameraTarget: zoneRequest.target,
    );

    final response = await DI().getDeliveryZonesUseCase.execute(
      GetDeliveryZonesParams(
        cityId: zoneRequest.cityId,
        lat: zoneRequest.cityId == null ? zoneRequest.lat : null,
        lng: zoneRequest.cityId == null ? zoneRequest.lng : null,
      ),
    );

    response.fold(
      (failure) => _useCachedZones(requestKey, failure),
      (zonesResult) => _applyZonesResult(
        requestKey,
        zonesResult,
        zoneRequest.target,
        zoneRequest.useCityCenter,
      ),
    );
  }

  void _applyZonesResult(
    String requestKey,
    DeliveryZonesResult zonesResult,
    LatLng requestedTarget,
    bool useCityCenter,
  ) {
    final city = zonesResult.city;
    final target = useCityCenter
        ? _cityTarget(city) ?? requestedTarget
        : requestedTarget;
    final zoom = city?.defaultZoom.toDouble() ?? state.zoom;
    final cacheEntry = _ZonesCacheEntry(zonesResult, DateTime.now());
    _zonesCache[requestKey] = cacheEntry;
    if (city != null) _zonesCache[_cacheKey(city.id)] = cacheEntry;

    state = state.copyWith(
      zones: zonesResult.zones,
      city: city,
      zonesLoading: false,
      zonesErrorMessage: '',
      zonesFromCache: false,
      cameraTarget: target,
      zoom: zoom,
      coverageStatus: zonesResult.zones.isEmpty
          ? MapCoverageStatus.noZones
          : state.coverageStatus,
    );
  }

  void _useCachedZones(String requestKey, Failure failure) {
    final cached = _freshCache(requestKey);
    if (cached != null) {
      state = state.copyWith(
        zones: cached.zonesResult.zones,
        city: cached.zonesResult.city,
        zonesLoading: false,
        zonesErrorMessage: failure.displayMessage,
        zonesFromCache: true,
      );
      return;
    }

    state = state.copyWith(
      zonesLoading: false,
      zonesErrorMessage: failure.displayMessage,
      coverageStatus: MapCoverageStatus.networkError,
      coverageErrorMessage: failure.displayMessage,
      clearCoverage: true,
      clearReverseGeocode: true,
    );
  }

  _ZonesCacheEntry? _freshCache(String key) {
    final cached = _zonesCache[key];
    if (cached == null) return null;
    return cached.isFresh ? cached : null;
  }

  Future<void> _checkCoverage(LatLng point) async {
    // If the zones list itself failed to load, keep the retry affordance
    // instead of firing a coverage check that would also fail.
    if (state.hasZoneFetchFailure) return;

    // NB: we deliberately do NOT short-circuit to "no zones" when the local
    // zone list is empty. The backend coverage check is the per-point source
    // of truth, so it must run wherever the user pans — even into a city we
    // didn't preload zones for. An empty zone list only means we won't draw
    // polygons; it must not block coverage.
    final requestId = ++_coverageRequestId;
    state = state.copyWith(
      coverageStatus: MapCoverageStatus.checking,
      coverageErrorMessage: '',
      clearCoverage: true,
      clearReverseGeocode: true,
    );

    final response = await DI().coverageCheckUseCase.execute(
      CoverageCheckParams(lat: point.latitude, lng: point.longitude),
    );
    if (requestId != _coverageRequestId) return;

    await response.fold(
      (failure) async => _applyCoverageFailure(failure),
      (coverage) async => _applyCoverageSuccess(requestId, point, coverage),
    );
  }

  Future<void> _applyCoverageSuccess(
    int requestId,
    LatLng point,
    CoverageResult coverage,
  ) async {
    final status = coverage.isServiceable
        ? MapCoverageStatus.serviceable
        : coverage.inActiveZone
        ? MapCoverageStatus.unavailableBranch
        : MapCoverageStatus.outside;

    state = state.copyWith(
      coverageStatus: status,
      coverage: coverage,
      coverageErrorMessage: '',
    );

    if (!coverage.isServiceable) return;

    final geocode = await ReverseGeocodeService.instance.reverseGeocode(
      lat: point.latitude,
      lng: point.longitude,
    );
    if (requestId != _coverageRequestId || geocode == null) return;
    state = state.copyWith(reverseGeocode: geocode);
  }

  Future<void> _applyCoverageFailure(Failure failure) async {
    if (_isOutsideCoverageFailure(failure)) {
      state = state.copyWith(
        coverageStatus: MapCoverageStatus.outside,
        coverageErrorMessage: Translation.error_outside_delivery_zone.tr,
        clearCoverage: true,
        clearReverseGeocode: true,
      );
      return;
    }

    state = state.copyWith(
      coverageStatus: MapCoverageStatus.networkError,
      coverageErrorMessage: failure.displayMessage,
      clearCoverage: true,
      clearReverseGeocode: true,
    );
  }

  bool _isOutsideCoverageFailure(Failure failure) {
    if (failure is! ServerError) return false;
    return switch (failure.code) {
      'outside_delivery_zone' ||
      'coverage_city_mismatch' ||
      'district_city_mismatch' => true,
      _ => false,
    };
  }

  LatLng? _cityTarget(CityCenter? city) {
    if (city?.centerLat == null || city?.centerLng == null) return null;
    return LatLng(city!.centerLat!, city.centerLng!);
  }

  String _cacheKey(int? cityId) => cityId == null ? 'default' : 'city:$cityId';
}

class _ZonesCacheEntry {
  final DeliveryZonesResult zonesResult;
  final DateTime storedAt;

  const _ZonesCacheEntry(this.zonesResult, this.storedAt);

  bool get isFresh =>
      DateTime.now().difference(storedAt) < const Duration(minutes: 5);
}

class _ZoneLoadRequest {
  final int? cityId;
  final double? lat;
  final double? lng;
  final LatLng target;
  final bool useCityCenter;

  const _ZoneLoadRequest({
    required this.cityId,
    required this.lat,
    required this.lng,
    required this.target,
    required this.useCityCenter,
  });
}

final mapLocationPickerController =
    NotifierProvider.autoDispose<
      MapLocationPickerNotifier,
      MapLocationPickerState
    >(MapLocationPickerNotifier.new);
