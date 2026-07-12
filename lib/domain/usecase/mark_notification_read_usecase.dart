import 'package:dartz/dartz.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/data/response/notification_response.dart';
import 'package:store/domain/repository/repository.dart';
import 'package:store/domain/usecase/base.dart';

class MarkNotificationReadUseCase implements Base<int, MobileNotification> {
  final Repository _repository;

  MarkNotificationReadUseCase(this._repository);

  @override
  Future<Either<Failure, MobileNotification>> execute(int id) =>
      _repository.markNotificationRead(id);
}
