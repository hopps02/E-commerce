import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

/// The live home-screen ads, in the order the panel arranged them.
class GetBannersUseCase implements Base<void, List<HomeBanner>> {
  final Repository _repository;

  GetBannersUseCase(this._repository);

  @override
  Future<Either<Failure, List<HomeBanner>>> execute(void input) =>
      _repository.banners();
}
