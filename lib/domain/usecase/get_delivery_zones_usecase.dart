import 'package:dartz/dartz.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/data/response/customer/delivery_zone_response.dart';
import 'package:for_u/domain/repository/repository.dart';
import 'package:for_u/domain/usecase/base.dart';

class GetDeliveryZonesParams {
  final int? cityId;
  final double? lat;
  final double? lng;

  const GetDeliveryZonesParams({this.cityId, this.lat, this.lng});
}

class GetDeliveryZonesUseCase
    implements Base<GetDeliveryZonesParams, DeliveryZonesResult> {
  final Repository _repository;

  GetDeliveryZonesUseCase(this._repository);

  @override
  Future<Either<Failure, DeliveryZonesResult>> execute(
    GetDeliveryZonesParams params,
  ) => _repository.deliveryZones(
    cityId: params.cityId,
    lat: params.lat,
    lng: params.lng,
  );
}
