import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class GetUnreadNotificationsCountUseCase implements Base<void, int> {
  final Repository _repository;

  GetUnreadNotificationsCountUseCase(this._repository);

  @override
  Future<Either<Failure, int>> execute(void input) =>
      _repository.unreadNotificationsCount();
}
