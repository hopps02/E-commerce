import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/data/response/customer/catalog_response.dart';

/// Which saved address the order goes to.
///
/// There is no coverage map and no GPS: the customer writes an address and the
/// store delivers there for one flat fee. Nothing here gates browsing — the
/// catalogue is open to everyone, address or not.
class LocationState extends Equatable {
  static const _unchanged = Object();

  final DeliveryAddress? selectedAddress;

  const LocationState({this.selectedAddress});

  int? get selectedAddressId => selectedAddress?.id;

  /// The line under "توصيل إلى" in the home app bar.
  String? get locationCity => selectedAddress?.displayAddress;

  LocationState copyWith({Object? selectedAddress = _unchanged}) {
    return LocationState(
      selectedAddress: identical(selectedAddress, _unchanged)
          ? this.selectedAddress
          : selectedAddress as DeliveryAddress?,
    );
  }

  @override
  List<Object?> get props => [selectedAddress];
}

class LocationNotifier extends Notifier<LocationState> {
  static const _selectedAddressStorageKey = 'selected-delivery-address';

  @override
  LocationState build() {
    Future.microtask(() {
      final saved = _storedSelectedAddress();
      if (saved != null) state = LocationState(selectedAddress: saved);
    });

    return const LocationState();
  }

  Future<void> setSelectedAddress(DeliveryAddress address) async {
    state = LocationState(selectedAddress: address);
    await DI().storageService.setMap(
      _selectedAddressStorageKey,
      address.toJson(),
    );
  }

  Future<void> clearSelectedAddress() async {
    state = const LocationState();
    await DI().storageService.deleteMap(_selectedAddressStorageKey);
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
