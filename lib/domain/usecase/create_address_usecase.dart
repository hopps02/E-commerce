import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class CreateAddressParams {
  final int cityId;
  final String displayAddress;
  final double lat;
  final double lng;
  final String label;
  final String? street;
  final String? buildingNumber;
  final String? floor;
  final String? apartment;
  final String? landmark;
  final String? deliveryInstructions;
  final bool isDefault;

  const CreateAddressParams({
    required this.cityId,
    required this.displayAddress,
    required this.lat,
    required this.lng,
    this.label = 'home',
    this.street,
    this.buildingNumber,
    this.floor,
    this.apartment,
    this.landmark,
    this.deliveryInstructions,
    this.isDefault = true,
  });
}

class CreateAddressUseCase
    implements Base<CreateAddressParams, DeliveryAddress> {
  final Repository _repository;

  CreateAddressUseCase(this._repository);

  @override
  Future<Either<Failure, DeliveryAddress>> execute(CreateAddressParams params) =>
      _repository.createAddress(
        cityId: params.cityId,
        displayAddress: params.displayAddress,
        lat: params.lat,
        lng: params.lng,
        label: params.label,
        street: params.street,
        buildingNumber: params.buildingNumber,
        floor: params.floor,
        apartment: params.apartment,
        landmark: params.landmark,
        deliveryInstructions: params.deliveryInstructions,
        isDefault: params.isDefault,
      );
}
