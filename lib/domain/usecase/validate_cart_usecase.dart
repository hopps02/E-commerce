import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class ValidateCartUseCase
    implements Base<List<CartLine>, CartValidationResult> {
  final Repository _repository;

  ValidateCartUseCase(this._repository);

  @override
  Future<Either<Failure, CartValidationResult>> execute(List<CartLine> lines) =>
      _repository.validateCart(lines);
}
