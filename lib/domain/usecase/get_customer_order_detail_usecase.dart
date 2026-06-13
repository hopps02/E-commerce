import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/customer_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class GetCustomerOrderDetailUseCase implements Base<int, CustomerOrder> {
  final Repository _repository;

  GetCustomerOrderDetailUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerOrder>> execute(int id) =>
      _repository.customerOrderDetail(id);
}
