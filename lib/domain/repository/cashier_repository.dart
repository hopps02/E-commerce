import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/cashier/cashier_models.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:for_u/data/network/error_handler/failure.dart';

/// A page of orders with its pagination block.
typedef CashierOrdersPage = ({List<CashierOrder> orders, Meta? meta});

abstract class CashierRepository {
  Future<Either<Failure, CashierProfile>> me();

  Future<Either<Failure, CashierOrdersPage>> orders({
    required String queue,
    required int page,
    int pageSize,
  });

  Future<Either<Failure, CashierOrder>> orderDetail(int id);

  Future<Either<Failure, CashierOrder>> markItemPrepared(
    int orderId,
    int itemId, {
    required bool prepared,
  });

  Future<Either<Failure, CashierOrder>> markItemUnavailable(
    int orderId,
    int itemId, {
    String? reason,
  });

  Future<Either<Failure, CashierOrder>> confirmReady(int orderId);

  Future<Either<Failure, CashierOrder>> reject(int orderId, {String? reason});

  Future<Either<Failure, List<AvailableCaptain>>> availableCaptains(
    int orderId,
  );

  Future<Either<Failure, CashierOrder>> assignCaptain(
    int orderId,
    int captainId,
  );
}
