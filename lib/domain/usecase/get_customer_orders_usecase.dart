import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class CustomerOrdersParams {
  final String statusGroup;
  final int page;
  final int pageSize;

  const CustomerOrdersParams({
    required this.statusGroup,
    required this.page,
    this.pageSize = 20,
  });
}

class GetCustomerOrdersUseCase
    implements Base<CustomerOrdersParams, CustomerOrdersPage> {
  final Repository _repository;

  GetCustomerOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerOrdersPage>> execute(
    CustomerOrdersParams params,
  ) => _repository.customerOrders(
    statusGroup: params.statusGroup,
    page: params.page,
    pageSize: params.pageSize,
  );
}
