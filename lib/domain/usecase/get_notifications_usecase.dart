import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class NotificationsParams {
  final int page;
  final int pageSize;

  const NotificationsParams({required this.page, this.pageSize = 20});
}

class GetNotificationsUseCase
    implements Base<NotificationsParams, NotificationsPage> {
  final Repository _repository;

  GetNotificationsUseCase(this._repository);

  @override
  Future<Either<Failure, NotificationsPage>> execute(
    NotificationsParams params,
  ) => _repository.notifications(page: params.page, pageSize: params.pageSize);
}
