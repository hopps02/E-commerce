import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetAddressesUseCase implements Base<void, List<DeliveryAddress>> {
  final Repository _repository;

  GetAddressesUseCase(this._repository);

  @override
  Future<Either<Failure, List<DeliveryAddress>>> execute(void input) =>
      _repository.addresses();
}
