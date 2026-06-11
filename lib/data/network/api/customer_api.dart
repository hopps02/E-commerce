import 'package:dio/dio.dart';
import 'package:for_u/data/models/customer/customer_models.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:retrofit/retrofit.dart';

part 'customer_api.g.dart';

/// Customer endpoints (guard: mobile, /v1/mobile/*, owner-scoped server-side).
@RestApi()
abstract class CustomerApi {
  factory CustomerApi(Dio dio, {String? baseUrl}) = _CustomerApi;

  @GET('/mobile/profile')
  Future<Envelope<CustomerProfile>> profile();

  @PATCH('/mobile/profile')
  Future<Envelope<CustomerProfile>> updateProfile(
    @Body() Map<String, String?> body,
  );

  /// [statusGroup] is `current` or `previous`.
  @GET('/mobile/orders')
  Future<Envelope<List<CustomerOrder>>> orders(
    @Query('status_group') String statusGroup,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @GET('/mobile/orders/{id}')
  Future<Envelope<CustomerOrder>> orderDetail(@Path('id') int id);

  @POST('/mobile/orders/{id}/cancel')
  Future<Envelope<CustomerOrder>> cancelOrder(@Path('id') int id);

  @POST('/mobile/orders/{id}/rating')
  Future<Envelope<dynamic>> rateOrder(
    @Path('id') int id,
    @Body() RateOrderBody body,
  );

  @POST('/mobile/tickets')
  Future<Envelope<dynamic>> openTicket(@Body() OpenTicketBody body);

  @DELETE('/mobile/account')
  Future<Envelope<dynamic>> deleteAccount();
}
