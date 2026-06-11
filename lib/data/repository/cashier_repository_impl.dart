import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/cashier/cashier_models.dart';
import 'package:for_u/data/network/api/cashier_api.dart';
import 'package:for_u/data/network/error_handler/error_handler.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/cashier_repository.dart';

class CashierRepositoryImpl implements CashierRepository {
  final CashierApi _api;

  CashierRepositoryImpl(this._api);

  @override
  Future<Either<Failure, CashierProfile>> me() =>
      fastHandler(request: () async => (await _api.me()).data);

  @override
  Future<Either<Failure, CashierOrdersPage>> orders({
    required String queue,
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _api.orders(queue, page, pageSize);
      return (orders: envelope.data, meta: envelope.meta);
    },
  );

  @override
  Future<Either<Failure, CashierOrder>> orderDetail(int id) =>
      fastHandler(request: () async => (await _api.orderDetail(id)).data);

  @override
  Future<Either<Failure, CashierOrder>> markItemPrepared(
    int orderId,
    int itemId, {
    required bool prepared,
  }) => fastHandler(
    request: () async => (await _api.markItemPrepared(orderId, itemId, {
      'prepared': prepared,
    })).data,
  );

  @override
  Future<Either<Failure, CashierOrder>> markItemUnavailable(
    int orderId,
    int itemId, {
    String? reason,
  }) => fastHandler(
    request: () async => (await _api.markItemUnavailable(orderId, itemId, {
      'reason': reason,
    })).data,
  );

  @override
  Future<Either<Failure, CashierOrder>> confirmReady(int orderId) =>
      fastHandler(request: () async => (await _api.confirmReady(orderId)).data);

  @override
  Future<Either<Failure, CashierOrder>> reject(int orderId, {String? reason}) =>
      fastHandler(
        request: () async =>
            (await _api.reject(orderId, {'reason': reason})).data,
      );

  @override
  Future<Either<Failure, List<AvailableCaptain>>> availableCaptains(
    int orderId,
  ) => fastHandler(
    request: () async => (await _api.availableCaptains(orderId)).data,
  );

  @override
  Future<Either<Failure, CashierOrder>> assignCaptain(
    int orderId,
    int captainId,
  ) => fastHandler(
    request: () async =>
        (await _api.assignCaptain(orderId, {'captain_id': captainId})).data,
  );
}
