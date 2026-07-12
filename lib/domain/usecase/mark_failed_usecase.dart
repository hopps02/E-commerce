import 'package:dartz/dartz.dart';
import 'package:store/data/response/captain/captain_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class MarkFailedParams {
  final int orderId;
  final String reason;
  final String? note;
  final double? lat;
  final double? lng;

  const MarkFailedParams({
    required this.orderId,
    required this.reason,
    this.note,
    this.lat,
    this.lng,
  });
}

class MarkFailedUseCase implements Base<MarkFailedParams, CaptainOrder> {
  final Repository _repository;

  MarkFailedUseCase(this._repository);

  @override
  Future<Either<Failure, CaptainOrder>> execute(MarkFailedParams params) =>
      _repository.markFailed(
        params.orderId,
        reason: params.reason,
        note: params.note,
        lat: params.lat,
        lng: params.lng,
      );
}
