import 'package:dio/dio.dart';
import 'package:for_u/data/models/captain/captain_models.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:retrofit/retrofit.dart';

part 'captain_api.g.dart';

/// Captain endpoints (guard: mobile, /v1/captain/*, ownership-scoped
/// server-side). `accept` is acknowledge-only — a captain cannot decline.
@RestApi()
abstract class CaptainApi {
  factory CaptainApi(Dio dio, {String? baseUrl}) = _CaptainApi;

  @GET('/captain/me')
  Future<Envelope<CaptainProfile>> me();

  @PATCH('/captain/availability')
  Future<Envelope<dynamic>> availability(@Body() Map<String, bool> body);

  /// [queue] is `upcoming`, `in_delivery` or `completed`.
  @GET('/captain/orders')
  Future<Envelope<List<CaptainOrder>>> orders(
    @Query('queue') String queue,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @GET('/captain/orders/{id}')
  Future<Envelope<CaptainOrder>> orderDetail(@Path('id') int id);

  @POST('/captain/orders/{id}/accept')
  Future<Envelope<CaptainOrder>> accept(@Path('id') int id);

  @POST('/captain/orders/{id}/start-delivery')
  Future<Envelope<CaptainOrder>> startDelivery(@Path('id') int id);

  @POST('/captain/orders/{id}/mark-delivered')
  Future<Envelope<CaptainOrder>> markDelivered(
    @Path('id') int id,
    @Body() Map<String, double?> body,
  );

  @POST('/captain/orders/{id}/mark-failed')
  Future<Envelope<CaptainOrder>> markFailed(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );
}
