import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/models/customer/catalog_models.dart';
import 'package:for_u/presentation/common/riverpod/location_controller.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class AddressFormState extends Equatable {
  /// The coverage-verified point this address will be saved with.
  final double? lat;
  final double? lng;
  final int? cityId;

  /// Geocoded name shown next to "use my location".
  final String locationLabel;
  final String label;

  const AddressFormState({
    this.lat,
    this.lng,
    this.cityId,
    this.locationLabel = '',
    this.label = 'home',
  });

  bool get hasLocation => lat != null && lng != null && cityId != null;

  AddressFormState copyWith({
    double? lat,
    double? lng,
    int? cityId,
    String? locationLabel,
    String? label,
  }) {
    return AddressFormState(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      cityId: cityId ?? this.cityId,
      locationLabel: locationLabel ?? this.locationLabel,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [lat, lng, cityId, locationLabel, label];
}

/// Backs the add/edit address form: holds the coverage-verified location and
/// the label choice, and persists through the repository.
class AddressFormNotifier extends Notifier<AddressFormState> {
  @override
  AddressFormState build() => const AddressFormState();

  /// Pre-fills the form from the address being edited.
  void initFrom(DeliveryAddress? existing) {
    if (existing == null) return;
    state = AddressFormState(
      lat: existing.lat,
      lng: existing.lng,
      cityId: existing.cityId,
      locationLabel: existing.displayAddress,
      label: existing.label ?? 'home',
    );
  }

  void selectLabel(String label) => state = state.copyWith(label: label);

  /// Walks the existing location feature (permission -> GPS -> geocode), then
  /// verifies coverage so the saved address is always serviceable-aware.
  /// GPS has no natural deadline (a simulator without a simulated location
  /// waits forever), so the fetch is hard-capped — never an endless overlay.
  Future<void> useMyLocation() async {
    DI().loadingService.show();
    final location = ref.read(locationController.notifier);
    final fetched = await location
        .handleLocationPermissionAndFetch()
        .timeout(const Duration(seconds: 12), onTimeout: () => false);
    final picked = ref.read(locationController);
    if (!fetched || picked.latitude == null || picked.longitude == null) {
      DI().loadingService.hide();
      DI().snackBarHelper.showMessage(
        Translation.location_fetch_failed.tr,
        ErrorMessage.snackBar,
      );
      return;
    }

    final coverage = await DI().customerRepository.coverageCheck(
      lat: picked.latitude!,
      lng: picked.longitude!,
    );
    DI().loadingService.hide();

    coverage.fold(
      (failure) => DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      ),
      (c) {
        if (!c.isServiceable || c.cityId == null) {
          DI().snackBarHelper.showMessage(
            Translation.error_outside_delivery_zone.tr,
            ErrorMessage.snackBar,
          );
          return;
        }
        state = state.copyWith(
          lat: picked.latitude,
          lng: picked.longitude,
          cityId: c.cityId,
          locationLabel: picked.locationCity ?? '',
        );
      },
    );
  }

  /// Saves the form. Returns true when persisted.
  Future<bool> save({
    DeliveryAddress? existing,
    required String displayAddress,
    String? street,
    String? buildingNumber,
    String? floor,
    String? apartment,
    String? landmark,
    String? deliveryInstructions,
  }) async {
    if (!state.hasLocation) {
      DI().snackBarHelper.showMessage(
        Translation.address_location_missing.tr,
        ErrorMessage.snackBar,
      );
      return false;
    }

    DI().loadingService.show();
    final repo = DI().customerRepository;
    final result = existing == null
        ? await repo.createAddress(
            cityId: state.cityId!,
            displayAddress: displayAddress,
            lat: state.lat!,
            lng: state.lng!,
            label: state.label,
            street: street,
            buildingNumber: buildingNumber,
            floor: floor,
            apartment: apartment,
            landmark: landmark,
            deliveryInstructions: deliveryInstructions,
            isDefault: false,
          )
        : await repo.updateAddress(existing.id, {
            'city_id': state.cityId,
            'display_address': displayAddress,
            'lat': state.lat,
            'lng': state.lng,
            'label': state.label,
            'street': street ?? '',
            'building_number': buildingNumber ?? '',
            'floor': floor ?? '',
            'apartment': apartment ?? '',
            'landmark': landmark ?? '',
            'delivery_instructions': deliveryInstructions ?? '',
          });
    DI().loadingService.hide();

    return result.fold((failure) {
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
      return false;
    }, (_) => true);
  }
}

final addressFormController =
    NotifierProvider.autoDispose<AddressFormNotifier, AddressFormState>(
      AddressFormNotifier.new,
    );
