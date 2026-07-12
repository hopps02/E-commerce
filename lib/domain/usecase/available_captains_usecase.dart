import 'package:dartz/dartz.dart';
import 'package:store/data/response/cashier/cashier_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class AvailableCaptainsUseCase implements Base<int, List<AvailableCaptain>> {
  final Repository _repository;

  AvailableCaptainsUseCase(this._repository);

  @override
  Future<Either<Failure, List<AvailableCaptain>>> execute(int orderId) =>
      _repository.availableCaptains(orderId);
}
