import 'package:dio/dio.dart';
import 'package:for_u/data/models/customer/catalog_models.dart';
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

  @GET('/mobile/products')
  Future<Envelope<List<BranchProduct>>> products(
    @Query('branch_id') int branchId,
    @Query('category_id') int? categoryId,
    @Query('search') String? search,
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @GET('/mobile/products/{id}')
  Future<Envelope<BranchProduct>> productDetail(@Path('id') int id);

  @GET('/mobile/categories')
  Future<Envelope<List<ProductCategory>>> categories();

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

  @POST('/mobile/location/coverage-check')
  Future<Envelope<CoverageResult>> coverageCheck(
    @Body() Map<String, dynamic> body,
  );

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

  @POST('/mobile/tickets')
  Future<Envelope<dynamic>> openTicket(@Body() OpenTicketBody body);

  @DELETE('/mobile/account')
  Future<Envelope<dynamic>> deleteAccount();
}
