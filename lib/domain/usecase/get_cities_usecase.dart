import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetCitiesUseCase implements Base<void, List<ServiceCity>> {
  final Repository _repository;

  GetCitiesUseCase(this._repository);

  @override
  Future<Either<Failure, List<ServiceCity>>> execute(void input) =>
      _repository.cities();
}
