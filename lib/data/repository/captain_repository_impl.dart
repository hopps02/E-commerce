import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/captain/captain_models.dart';
import 'package:for_u/data/network/api/captain_api.dart';
import 'package:for_u/data/network/error_handler/error_handler.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/captain_repository.dart';

class CaptainRepositoryImpl implements CaptainRepository {
  final CaptainApi _api;

  CaptainRepositoryImpl(this._api);

  @override
  Future<Either<Failure, CaptainProfile>> me() =>
      fastHandler(request: () async => (await _api.me()).data);

  @override
  Future<Either<Failure, Unit>> setAvailability(bool isAvailable) =>
      fastHandler(
        request: () async {
          await _api.availability({'is_available': isAvailable});
          return unit;
        },
      );

  @override
  Future<Either<Failure, CaptainOrdersPage>> orders({
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
  Future<Either<Failure, CaptainOrder>> orderDetail(int id) =>
      fastHandler(request: () async => (await _api.orderDetail(id)).data);

  @override
  Future<Either<Failure, CaptainOrder>> accept(int orderId) =>
      fastHandler(request: () async => (await _api.accept(orderId)).data);

  @override
  Future<Either<Failure, CaptainOrder>> startDelivery(int orderId) =>
      fastHandler(
        request: () async => (await _api.startDelivery(orderId)).data,
      );

  @override
  Future<Either<Failure, CaptainOrder>> markDelivered(
    int orderId, {
    double? lat,
    double? lng,
  }) => fastHandler(
    request: () async =>
        (await _api.markDelivered(orderId, {'lat': lat, 'lng': lng})).data,
  );

  @override
  Future<Either<Failure, CaptainOrder>> markFailed(
    int orderId, {
    required String reason,
    String? note,
    double? lat,
    double? lng,
  }) => fastHandler(
    request: () async => (await _api.markFailed(orderId, {
      'reason': reason,
      'note': note,
      'lat': lat,
      'lng': lng,
    })).data,
  );
}
