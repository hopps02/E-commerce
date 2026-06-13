import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/domain/usecase/update_address_usecase.dart';

class AddressesState extends Equatable {
  final ReqState reqState;
  final String errorMessage;
  final List<DeliveryAddress> addresses;

  const AddressesState({
    this.reqState = ReqState.loading,
    this.errorMessage = '',
    this.addresses = const [],
  });

  AddressesState copyWith({
    ReqState? reqState,
    String? errorMessage,
    List<DeliveryAddress>? addresses,
  }) {
    return AddressesState(
      reqState: reqState ?? this.reqState,
      errorMessage: errorMessage ?? this.errorMessage,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  List<Object?> get props => [reqState, errorMessage, addresses];
}

/// The customer's saved addresses: list, set-default and delete. The backend
/// keeps the default invariant (first address is default; defaulting one
/// un-defaults the rest; deleting reassigns server-side).
class AddressesNotifier extends Notifier<AddressesState> {
  @override
  AddressesState build() => const AddressesState();

  Future<void> load() async {
    state = const AddressesState();
    final result = await DI().getAddressesUseCase.execute(null);
    result.fold(
      (failure) => state = state.copyWith(
        reqState: ReqState.error,
        errorMessage: failure.displayMessage,
      ),
      (addresses) => state = state.copyWith(
        reqState: addresses.isEmpty ? ReqState.empty : ReqState.success,
        addresses: addresses,
      ),
    );
  }

  Future<void> setDefault(int id) async {
    DI().loadingService.show();
    final result = await DI().updateAddressUseCase.execute(
      UpdateAddressParams(id: id, changes: {'is_default': true}),
    );
    DI().loadingService.hide();

    await result.fold(
      (failure) async => DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      ),
      (_) => load(),
    );
  }

  Future<void> delete(int id) async {
    DI().loadingService.show();
    final result = await DI().deleteAddressUseCase.execute(id);
    DI().loadingService.hide();

    await result.fold(
      (failure) async => DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      ),
      (_) => load(),
    );
  }
}

final addressesController =
    NotifierProvider.autoDispose<AddressesNotifier, AddressesState>(
      AddressesNotifier.new,
    );
