import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/response/customer/place_response.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class PlacesDetailsParams {
  final String placeId;
  final String session;

  const PlacesDetailsParams({required this.placeId, required this.session});
}

class PlacesDetailsUseCase
    implements Base<PlacesDetailsParams, PlaceLocation> {
  final Repository _repository;

  PlacesDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, PlaceLocation>> execute(PlacesDetailsParams params) =>
      _repository.placeDetails(
        placeId: params.placeId,
        session: params.session,
      );
}
