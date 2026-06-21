import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/response/customer/place_response.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class PlacesAutocompleteParams {
  final String query;
  final String session;

  const PlacesAutocompleteParams({required this.query, required this.session});
}

class PlacesAutocompleteUseCase
    implements Base<PlacesAutocompleteParams, List<PlaceSuggestion>> {
  final Repository _repository;

  PlacesAutocompleteUseCase(this._repository);

  @override
  Future<Either<Failure, List<PlaceSuggestion>>> execute(
    PlacesAutocompleteParams params,
  ) => _repository.placesAutocomplete(
    query: params.query,
    session: params.session,
  );
}
