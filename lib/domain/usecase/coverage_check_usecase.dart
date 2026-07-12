import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class CoverageCheckParams {
  final double lat;
  final double lng;
  final int? cityId;
  final int? districtId;

  const CoverageCheckParams({
    required this.lat,
    required this.lng,
    this.cityId,
    this.districtId,
  });
}

class CoverageCheckUseCase implements Base<CoverageCheckParams, CoverageResult> {
  final Repository _repository;

  CoverageCheckUseCase(this._repository);

  @override
  Future<Either<Failure, CoverageResult>> execute(CoverageCheckParams params) =>
      _repository.coverageCheck(
        lat: params.lat,
        lng: params.lng,
        cityId: params.cityId,
        districtId: params.districtId,
      );
}
