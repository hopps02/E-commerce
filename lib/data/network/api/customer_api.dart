import 'package:dio/dio.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/request/customer/customer_request.dart';
import 'package:store/data/response/customer/customer_response.dart';
import 'package:store/data/response/customer/support_response.dart';
import 'package:store/data/response/notification_response.dart';
import 'package:store/data/network/envelope.dart';
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

  @GET('/mobile/products')
  Future<Envelope<List<BranchProduct>>> products(
    @Query('branch_id') int? branchId,
    @Query('category_id') int? categoryId,
    @Query('search') String? search,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @GET('/mobile/products/{id}')
  Future<Envelope<BranchProduct>> productDetail(@Path('id') int id);

  @GET('/mobile/categories')
  Future<Envelope<List<ProductCategory>>> categories();

  @GET('/mobile/banners')
  Future<Envelope<List<HomeBanner>>> banners();

  @GET('/mobile/favorites')
  Future<Envelope<List<BranchProduct>>> favorites();

  @POST('/mobile/favorites/{id}')
  Future<Envelope<dynamic>> addFavorite(@Path('id') int id);

  @DELETE('/mobile/favorites/{id}')
  Future<Envelope<dynamic>> removeFavorite(@Path('id') int id);

  @GET('/mobile/notifications')
  Future<Envelope<List<MobileNotification>>> notifications(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @GET('/mobile/notifications/unread-count')
  Future<Envelope<UnreadNotificationsCount>> unreadNotificationsCount();

  @POST('/mobile/notifications/{id}/read')
  Future<Envelope<MobileNotification>> markNotificationRead(@Path('id') int id);

  @POST('/mobile/notifications/read-all')
  Future<Envelope<MarkedNotificationsCount>> markAllNotificationsRead();

  @GET('/mobile/addresses')
  Future<Envelope<List<DeliveryAddress>>> addresses();

  @POST('/mobile/addresses')
  Future<Envelope<DeliveryAddress>> createAddress(
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/mobile/addresses/{id}')
  Future<Envelope<DeliveryAddress>> updateAddress(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  /// 204 with no body — the return type must not try to parse an envelope.
  @DELETE('/mobile/addresses/{id}')
  Future<void> deleteAddress(@Path('id') int id);

  @POST('/mobile/cart/validate')
  Future<Envelope<CartValidationResult>> validateCart(
    @Body() Map<String, dynamic> body,
  );

  @POST('/mobile/checkout/quote')
  Future<Envelope<CheckoutQuote>> checkoutQuote(
    @Body() Map<String, dynamic> body,
  );

  /// COD-only order creation; the key dedupes accidental double submits.
  @POST('/mobile/orders')
  Future<Envelope<CustomerOrder>> createOrder(
    @Header('Idempotency-Key') String idempotencyKey,
    @Body() Map<String, dynamic> body,
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

  @GET('/mobile/tickets')
  Future<Envelope<List<Ticket>>> tickets(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @GET('/mobile/tickets/{id}')
  Future<Envelope<Ticket>> ticket(@Path('id') int id);

  @POST('/mobile/tickets')
  Future<Envelope<Ticket>> openTicket(@Body() OpenTicketBody body);

  @POST('/mobile/tickets/{id}/reply')
  Future<Envelope<Ticket>> replyTicket(
    @Path('id') int id,
    @Body() ReplyTicketBody body,
  );

  @GET('/mobile/legal-policies')
  Future<Envelope<List<LegalSection>>> legalPolicies();

  @DELETE('/mobile/account')
  Future<Envelope<dynamic>> deleteAccount();
}
