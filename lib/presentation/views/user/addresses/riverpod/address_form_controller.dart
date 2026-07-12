import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/domain/usecase/create_address_usecase.dart';
import 'package:store/domain/usecase/update_address_usecase.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/addresses/model/map_location_picker_models.dart';

class AddressFormState extends Equatable {
  /// The coverage-verified point this address will be saved with.
  final double? lat;
  final double? lng;
  final int? cityId;
  final int? deliveryZoneId;
  final String? deliveryZoneNameAr;
  final String? deliveryZoneNameEn;
  final int? deliveryFeeHalalas;
  final String? area;
  final bool coverageVerified;

  /// Geocoded name shown next to the map picker.
  final String locationLabel;
  final String label;

  const AddressFormState({
    this.lat,
    this.lng,
    this.cityId,
    this.deliveryZoneId,
    this.deliveryZoneNameAr,
    this.deliveryZoneNameEn,
    this.deliveryFeeHalalas,
    this.area,
    this.coverageVerified = false,
    this.locationLabel = '',
    this.label = 'home',
  });

  bool get hasLocation =>
      coverageVerified && lat != null && lng != null && cityId != null;

  String zoneName(bool arabic) =>
      (arabic ? deliveryZoneNameAr : deliveryZoneNameEn) ??
      deliveryZoneNameAr ??
      deliveryZoneNameEn ??
      '';

  AddressFormState copyWith({
    double? lat,
    double? lng,
    int? cityId,
    int? deliveryZoneId,
    String? deliveryZoneNameAr,
    String? deliveryZoneNameEn,
    int? deliveryFeeHalalas,
    String? area,
    bool? coverageVerified,
    String? locationLabel,
    String? label,
  }) {
    return AddressFormState(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      cityId: cityId ?? this.cityId,
      deliveryZoneId: deliveryZoneId ?? this.deliveryZoneId,
      deliveryZoneNameAr: deliveryZoneNameAr ?? this.deliveryZoneNameAr,
      deliveryZoneNameEn: deliveryZoneNameEn ?? this.deliveryZoneNameEn,
      deliveryFeeHalalas: deliveryFeeHalalas ?? this.deliveryFeeHalalas,
      area: area ?? this.area,
      coverageVerified: coverageVerified ?? this.coverageVerified,
      locationLabel: locationLabel ?? this.locationLabel,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [
    lat,
    lng,
    cityId,
    deliveryZoneId,
    deliveryZoneNameAr,
    deliveryZoneNameEn,
    deliveryFeeHalalas,
    area,
    coverageVerified,
    locationLabel,
    label,
  ];
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
      coverageVerified: false,
    );
  }

  void selectLabel(String label) => state = state.copyWith(label: label);

  void applyMapResult(MapLocationPickerResult mapResult) {
    state = AddressFormState(
      lat: mapResult.lat,
      lng: mapResult.lng,
      cityId: mapResult.cityId,
      deliveryZoneId: mapResult.deliveryZoneId,
      deliveryZoneNameAr: mapResult.deliveryZoneNameAr,
      deliveryZoneNameEn: mapResult.deliveryZoneNameEn,
      deliveryFeeHalalas: mapResult.deliveryFeeHalalas,
      area: mapResult.area,
      coverageVerified: true,
      locationLabel:
          mapResult.displayAddressSuggestion ??
          mapResult.area ??
          Translation.map_inside_delivery_zone.tr,
      label: state.label,
    );
  }

  /// Saves the form. Returns the persisted address when successful.
  Future<DeliveryAddress?> save({
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
      return null;
    }

    DI().loadingService.show();
    final saveResponse = existing == null
        ? await DI().createAddressUseCase.execute(
            CreateAddressParams(
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
            ),
          )
        : await DI().updateAddressUseCase.execute(
            UpdateAddressParams(
              id: existing.id,
              changes: {
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
              },
            ),
          );
    DI().loadingService.hide();

    return saveResponse.fold((failure) {
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
      return null;
    }, (address) => address);
  }
}

final addressFormController =
    NotifierProvider.autoDispose<AddressFormNotifier, AddressFormState>(
      AddressFormNotifier.new,
    );
