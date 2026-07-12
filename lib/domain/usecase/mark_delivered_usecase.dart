import 'package:dartz/dartz.dart';
import 'package:store/data/response/captain/captain_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class MarkDeliveredParams {
  final int orderId;
  final double? lat;
  final double? lng;

  const MarkDeliveredParams({required this.orderId, this.lat, this.lng});
}

class MarkDeliveredUseCase implements Base<MarkDeliveredParams, CaptainOrder> {
  final Repository _repository;

  MarkDeliveredUseCase(this._repository);

  @override
  Future<Either<Failure, CaptainOrder>> execute(MarkDeliveredParams params) =>
      _repository.markDelivered(
        params.orderId,
        lat: params.lat,
        lng: params.lng,
      );
}
