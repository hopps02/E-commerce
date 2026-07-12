import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class UpdateAddressParams {
  final int id;
  final Map<String, dynamic> changes;

  const UpdateAddressParams({required this.id, required this.changes});
}

class UpdateAddressUseCase
    implements Base<UpdateAddressParams, DeliveryAddress> {
  final Repository _repository;

  UpdateAddressUseCase(this._repository);

  @override
  Future<Either<Failure, DeliveryAddress>> execute(UpdateAddressParams params) =>
      _repository.updateAddress(params.id, params.changes);
}
