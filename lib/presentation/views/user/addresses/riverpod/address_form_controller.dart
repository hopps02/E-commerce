import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/utils/snackbar_helper.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/domain/usecase/create_address_usecase.dart';
import 'package:store/domain/usecase/update_address_usecase.dart';

class AddressFormState extends Equatable {
  /// Which of the three chips is picked: home, work or other.
  final String label;

  const AddressFormState({this.label = 'home'});

  AddressFormState copyWith({String? label}) =>
      AddressFormState(label: label ?? this.label);

  @override
  List<Object?> get props => [label];
}

/// Backs the add/edit address form. The address is entirely what the customer
/// types — there is no map, no coverage check and no city list behind it, so
/// all this holds is the label choice and the call that saves.
class AddressFormNotifier extends Notifier<AddressFormState> {
  @override
  AddressFormState build() => const AddressFormState();

  /// Pre-fills the form from the address being edited.
  void initFrom(DeliveryAddress? existing) {
    if (existing == null) return;
    state = state.copyWith(label: existing.label ?? 'home');
  }

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
    DI().loadingService.show();
    final saveResponse = existing == null
        ? await DI().createAddressUseCase.execute(
            CreateAddressParams(
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
