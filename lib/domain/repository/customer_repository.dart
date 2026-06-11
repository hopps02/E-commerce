import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/customer/customer_models.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:for_u/data/network/error_handler/failure.dart';

/// A page of customer orders with its pagination block.
typedef CustomerOrdersPage = ({List<CustomerOrder> orders, Meta? meta});

abstract class CustomerRepository {
  Future<Either<Failure, CustomerProfile>> profile();

  Future<Either<Failure, CustomerProfile>> updateProfile({
    String? name,
    String? preferredLocale,
  });

  Future<Either<Failure, CustomerOrdersPage>> orders({
    required String statusGroup,
    required int page,
    int pageSize,
  });

  Future<Either<Failure, CustomerOrder>> orderDetail(int id);

  Future<Either<Failure, CustomerOrder>> cancelOrder(int id);

  Future<Either<Failure, Unit>> rateOrder(int id, RateOrderBody body);

  Future<Either<Failure, Unit>> openTicket(OpenTicketBody body);

  /// Server-side soft delete; the caller still clears the local session.
  Future<Either<Failure, Unit>> deleteAccount();
}
