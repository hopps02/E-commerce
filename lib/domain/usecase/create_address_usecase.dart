import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class CreateAddressParams {
  final String displayAddress;
  final String label;
  final String? street;
  final String? buildingNumber;
  final String? floor;
  final String? apartment;
  final String? landmark;
  final String? deliveryInstructions;
  final bool isDefault;

  const CreateAddressParams({
    required this.displayAddress,
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
        displayAddress: params.displayAddress,
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
