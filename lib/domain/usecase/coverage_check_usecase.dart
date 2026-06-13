import 'package:dartz/dartz.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class CoverageCheckParams {
  final double lat;
  final double lng;

  const CoverageCheckParams({required this.lat, required this.lng});
}

class CoverageCheckUseCase implements Base<CoverageCheckParams, CoverageResult> {
  final Repository _repository;

  CoverageCheckUseCase(this._repository);

  @override
  Future<Either<Failure, CoverageResult>> execute(CoverageCheckParams params) =>
      _repository.coverageCheck(lat: params.lat, lng: params.lng);
}
