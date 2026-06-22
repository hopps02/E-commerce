import 'package:dio/dio.dart';
import 'package:for_u/data/request/customer/customer_request.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:retrofit/retrofit.dart';

part 'cashier_api.g.dart';

/// Cashier endpoints (guard: mobile, /v1/cashier/*, branch-scoped server-side).
@RestApi()
abstract class CashierApi {
  factory CashierApi(Dio dio, {String? baseUrl}) = _CashierApi;

  @GET('/cashier/me')
  Future<Envelope<CashierProfile>> me();

  /// [queue] is `preparation` or `on_the_way` (the latter includes delivered,
  /// newest first).
  @GET('/cashier/orders')
  Future<Envelope<List<CashierOrder>>> orders(
    @Query('queue') String queue,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @GET('/cashier/orders/{id}')
  Future<Envelope<CashierOrder>> orderDetail(@Path('id') int id);

  @PATCH('/cashier/orders/{id}/items/{itemId}/prepared')
  Future<Envelope<CashierOrder>> markItemPrepared(
    @Path('id') int id,
    @Path('itemId') int itemId,
    @Body() Map<String, bool> body,
  );

  @POST('/cashier/orders/{id}/items/{itemId}/unavailable')
  Future<Envelope<CashierOrder>> markItemUnavailable(
    @Path('id') int id,
    @Path('itemId') int itemId,
    @Body() Map<String, String?> body,
  );

  @POST('/cashier/orders/{id}/confirm-ready')
  Future<Envelope<CashierOrder>> confirmReady(@Path('id') int id);

  @POST('/cashier/orders/{id}/reject')
  Future<Envelope<CashierOrder>> reject(
    @Path('id') int id,
    @Body() Map<String, String?> body,
  );

  @GET('/cashier/orders/{id}/available-captains')
  Future<Envelope<List<AvailableCaptain>>> availableCaptains(
    @Path('id') int id,
  );

  @POST('/cashier/orders/{id}/assign-captain')
  Future<Envelope<CashierOrder>> assignCaptain(
    @Path('id') int id,
    @Body() Map<String, int> body,
  );

  @POST('/cashier/orders/{id}/reassign-captain')
  Future<Envelope<CashierOrder>> reassignCaptain(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @POST('/cashier/tickets')
  Future<Envelope<Ticket>> openTicket(@Body() OpenTicketBody body);
}
