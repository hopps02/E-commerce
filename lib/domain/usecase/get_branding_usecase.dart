import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/data/response/customer/branding_response.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

/// The store's identity: the colours, the font and the logo the app paints
/// itself with.
class GetBrandingUseCase implements Base<void, Branding> {
  final Repository _repository;

  GetBrandingUseCase(this._repository);

  @override
  Future<Either<Failure, Branding>> execute(void input) =>
      _repository.branding();
}
