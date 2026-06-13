import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/response/customer/customer_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class CreateOrderParams {
  final String idempotencyKey;
  final int addressId;
  final List<CartLine> lines;
  final String? notes;

  const CreateOrderParams({
    required this.idempotencyKey,
    required this.addressId,
    required this.lines,
    this.notes,
  });
}

class CreateOrderUseCase implements Base<CreateOrderParams, CustomerOrder> {
  final Repository _repository;

  CreateOrderUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerOrder>> execute(CreateOrderParams params) =>
      _repository.createOrder(
        idempotencyKey: params.idempotencyKey,
        addressId: params.addressId,
        lines: params.lines,
        notes: params.notes,
      );
}
