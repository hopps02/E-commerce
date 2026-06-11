import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/captain/captain_models.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:for_u/data/network/error_handler/failure.dart';

/// A page of captain orders with its pagination block.
typedef CaptainOrdersPage = ({List<CaptainOrder> orders, Meta? meta});

abstract class CaptainRepository {
  Future<Either<Failure, CaptainProfile>> me();

  Future<Either<Failure, Unit>> setAvailability(bool isAvailable);

  Future<Either<Failure, CaptainOrdersPage>> orders({
    required String queue,
    required int page,
    int pageSize,
  });

  Future<Either<Failure, CaptainOrder>> orderDetail(int id);

  Future<Either<Failure, CaptainOrder>> accept(int orderId);

  Future<Either<Failure, CaptainOrder>> startDelivery(int orderId);

  Future<Either<Failure, CaptainOrder>> markDelivered(
    int orderId, {
    double? lat,
    double? lng,
  });

  Future<Either<Failure, CaptainOrder>> markFailed(
    int orderId, {
    required String reason,
    String? note,
    double? lat,
    double? lng,
  });
}
