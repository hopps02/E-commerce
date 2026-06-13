import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class ValidateCartUseCase
    implements Base<List<CartLine>, CartValidationResult> {
  final Repository _repository;

  ValidateCartUseCase(this._repository);

  @override
  Future<Either<Failure, CartValidationResult>> execute(List<CartLine> lines) =>
      _repository.validateCart(lines);
}
