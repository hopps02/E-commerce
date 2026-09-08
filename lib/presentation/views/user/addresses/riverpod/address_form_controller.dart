import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/domain/usecase/create_address_usecase.dart';
import 'package:store/domain/usecase/update_address_usecase.dart';
import 'package:store/presentation/res/translations_manager.dart';

class AddressFormState extends Equatable {
  /// The city this address belongs to, chosen from [cities].
  final int? cityId;

  /// Cities the store serves, loaded once when the form opens.
  final List<ServiceCity> cities;
  final bool loadingCities;

  final String label;

  const AddressFormState({
    this.cityId,
    this.cities = const [],
    this.loadingCities = false,
    this.label = 'home',
  });

  bool get hasCity => cityId != null;

  AddressFormState copyWith({
    int? cityId,
    List<ServiceCity>? cities,
    bool? loadingCities,
    String? label,
  }) {
    return AddressFormState(
      cityId: cityId ?? this.cityId,
      cities: cities ?? this.cities,
      loadingCities: loadingCities ?? this.loadingCities,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [cityId, cities, loadingCities, label];
}

/// Backs the add/edit address form: the city choice, the label choice, and
/// persistence. The address itself is what the customer types — there is no
/// map and no coverage check behind it.
class AddressFormNotifier extends Notifier<AddressFormState> {
  @override
  AddressFormState build() => const AddressFormState();

  /// Pre-fills the form from the address being edited.
  void initFrom(DeliveryAddress? existing) {
    if (existing == null) return;
    state = state.copyWith(
      cityId: existing.cityId,
      label: existing.label ?? 'home',
    );
  }

  Future<void> loadCities() async {
    if (state.cities.isNotEmpty || state.loadingCities) return;
    state = state.copyWith(loadingCities: true);

    final result = await DI().getCitiesUseCase.execute(null);

    result.fold(
      (failure) {
        state = state.copyWith(loadingCities: false);
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
      },
      (cities) {
        state = state.copyWith(
          cities: cities,
          loadingCities: false,
          // One city to choose from is not a choice — pick it.
          cityId: state.cityId ?? (cities.length == 1 ? cities.first.id : null),
        );
      },
    );
  }

  void selectCity(int cityId) => state = state.copyWith(cityId: cityId);

  void selectLabel(String label) => state = state.copyWith(label: label);

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
    if (!state.hasCity) {
      DI().snackBarHelper.showMessage(
        Translation.address_city_missing.tr,
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
