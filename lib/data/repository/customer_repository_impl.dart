import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/customer/customer_models.dart';
import 'package:for_u/data/network/api/customer_api.dart';
import 'package:for_u/data/network/error_handler/error_handler.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerApi _api;

  CustomerRepositoryImpl(this._api);

  @override
  Future<Either<Failure, CustomerProfile>> profile() =>
      fastHandler(request: () async => (await _api.profile()).data);

  @override
  Future<Either<Failure, CustomerProfile>> updateProfile({
    String? name,
    String? preferredLocale,
  }) => fastHandler(
    request: () async => (await _api.updateProfile({
      if (name != null) 'name': name,
      if (preferredLocale != null) 'preferred_locale': preferredLocale,
    })).data,
  );

  @override
  Future<Either<Failure, CustomerOrdersPage>> orders({
    required String statusGroup,
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _api.orders(statusGroup, page, pageSize);
      return (orders: envelope.data, meta: envelope.meta);
    },
  );

  @override
  Future<Either<Failure, CustomerOrder>> orderDetail(int id) =>
      fastHandler(request: () async => (await _api.orderDetail(id)).data);

  @override
  Future<Either<Failure, CustomerOrder>> cancelOrder(int id) =>
      fastHandler(request: () async => (await _api.cancelOrder(id)).data);

  @override
  Future<Either<Failure, Unit>> rateOrder(int id, RateOrderBody body) =>
      fastHandler(
        request: () async {
          await _api.rateOrder(id, body);
          return unit;
        },
      );

  @override
  Future<Either<Failure, Unit>> openTicket(OpenTicketBody body) => fastHandler(
    request: () async {
      await _api.openTicket(body);
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> deleteAccount() => fastHandler(
    request: () async {
      await _api.deleteAccount();
      return unit;
    },
  );
}
