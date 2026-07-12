import 'package:dartz/dartz.dart';
import 'package:store/data/response/customer/customer_response.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class UpdateProfileParams {
  final String? name;
  final String? preferredLocale;

  const UpdateProfileParams({this.name, this.preferredLocale});
}

class UpdateProfileUseCase
    implements Base<UpdateProfileParams, CustomerProfile> {
  final Repository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerProfile>> execute(UpdateProfileParams params) =>
      _repository.updateProfile(
        name: params.name,
        preferredLocale: params.preferredLocale,
      );
}
