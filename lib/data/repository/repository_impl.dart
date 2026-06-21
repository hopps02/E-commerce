import 'package:dartz/dartz.dart';
import 'package:for_u/data/request/auth/auth_request.dart';
import 'package:for_u/data/request/customer/customer_request.dart';
import 'package:for_u/data/response/auth/auth_response.dart';
import 'package:for_u/data/response/captain/captain_response.dart';
import 'package:for_u/data/response/cashier/cashier_response.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/data/response/customer/customer_response.dart';
import 'package:for_u/data/response/customer/delivery_zone_response.dart';
import 'package:for_u/data/response/customer/place_response.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/data/network/api/auth_api.dart';
import 'package:for_u/data/network/api/captain_api.dart';
import 'package:for_u/data/network/api/cashier_api.dart';
import 'package:for_u/data/network/api/customer_api.dart';
import 'package:for_u/data/network/error_handler/error_handler.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final AuthApi _authApi;
  final CaptainApi _captainApi;
  final CashierApi _cashierApi;
  final CustomerApi _customerApi;

  RepositoryImpl(
    this._authApi,
    this._captainApi,
    this._cashierApi,
    this._customerApi,
  );

  /// Validate/quote/create all send the same wire lines.
  static List<Map<String, int>> _wireLines(List<CartLine> lines) => lines
      .map((l) => {'branch_item_id': l.branchItemId, 'quantity': l.quantity})
      .toList();

  // ---- Auth ----
  @override
  Future<Either<Failure, OtpRequested>> requestOtp(String phone) => fastHandler(
    request: () async =>
        (await _authApi.requestOtp(RequestOtpBody(phone: phone))).data,
  );

  @override
  Future<Either<Failure, AuthSession>> verifyOtp(String phone, String code) =>
      fastHandler(
        request: () async => (await _authApi.verifyOtp(
          VerifyOtpBody(phone: phone, code: code),
        )).data,
      );

  @override
  Future<Either<Failure, MeData>> me() =>
      fastHandler(request: () async => (await _authApi.me()).data);

  @override
  Future<Either<Failure, Unit>> logout() => fastHandler(
    request: () async {
      await _authApi.logout();
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> registerDevice(RegisterDeviceBody body) =>
      fastHandler(
        request: () async {
          await _authApi.registerDevice(body);
          return unit;
        },
      );

  @override
  Future<Either<Failure, Unit>> unregisterDevice(String token) => fastHandler(
    request: () async {
      await _authApi.unregisterDevice({'token': token});
      return unit;
    },
  );

  // ---- Captain ----
  @override
  Future<Either<Failure, CaptainProfile>> captainMe() =>
      fastHandler(request: () async => (await _captainApi.me()).data);

  @override
  Future<Either<Failure, Unit>> setAvailability(bool isAvailable) =>
      fastHandler(
        request: () async {
          await _captainApi.availability({'is_available': isAvailable});
          return unit;
        },
      );

  @override
  Future<Either<Failure, CaptainOrdersPage>> captainOrders({
    required String queue,
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _captainApi.orders(queue, page, pageSize);
      return (orders: envelope.data, meta: envelope.meta);
    },
  );

  @override
  Future<Either<Failure, CaptainOrder>> captainOrderDetail(int id) =>
      fastHandler(request: () async => (await _captainApi.orderDetail(id)).data);

  @override
  Future<Either<Failure, CaptainOrder>> acceptOrder(int orderId) =>
      fastHandler(request: () async => (await _captainApi.accept(orderId)).data);

  @override
  Future<Either<Failure, CaptainOrder>> startDelivery(int orderId) =>
      fastHandler(
        request: () async => (await _captainApi.startDelivery(orderId)).data,
      );

  @override
  Future<Either<Failure, CaptainOrder>> markDelivered(
    int orderId, {
    double? lat,
    double? lng,
  }) => fastHandler(
    request: () async =>
        (await _captainApi.markDelivered(orderId, {'lat': lat, 'lng': lng})).data,
  );

  @override
  Future<Either<Failure, CaptainOrder>> markFailed(
    int orderId, {
    required String reason,
    String? note,
    double? lat,
    double? lng,
  }) => fastHandler(
    request: () async => (await _captainApi.markFailed(orderId, {
      'reason': reason,
      'note': note,
      'lat': lat,
      'lng': lng,
    })).data,
  );

  // ---- Cashier ----
  @override
  Future<Either<Failure, CashierProfile>> cashierMe() =>
      fastHandler(request: () async => (await _cashierApi.me()).data);

  @override
  Future<Either<Failure, CashierOrdersPage>> cashierOrders({
    required String queue,
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _cashierApi.orders(queue, page, pageSize);
      return (orders: envelope.data, meta: envelope.meta);
    },
  );

  @override
  Future<Either<Failure, CashierOrder>> cashierOrderDetail(int id) =>
      fastHandler(request: () async => (await _cashierApi.orderDetail(id)).data);

  @override
  Future<Either<Failure, CashierOrder>> markItemPrepared(
    int orderId,
    int itemId, {
    required bool prepared,
  }) => fastHandler(
    request: () async => (await _cashierApi.markItemPrepared(orderId, itemId, {
      'prepared': prepared,
    })).data,
  );

  @override
  Future<Either<Failure, CashierOrder>> markItemUnavailable(
    int orderId,
    int itemId, {
    String? reason,
  }) => fastHandler(
    request: () async => (await _cashierApi.markItemUnavailable(orderId, itemId, {
      'reason': reason,
    })).data,
  );

  @override
  Future<Either<Failure, CashierOrder>> confirmReady(int orderId) => fastHandler(
    request: () async => (await _cashierApi.confirmReady(orderId)).data,
  );

  @override
  Future<Either<Failure, CashierOrder>> rejectOrder(
    int orderId, {
    String? reason,
  }) => fastHandler(
    request: () async =>
        (await _cashierApi.reject(orderId, {'reason': reason})).data,
  );

  @override
  Future<Either<Failure, List<AvailableCaptain>>> availableCaptains(
    int orderId,
  ) => fastHandler(
    request: () async => (await _cashierApi.availableCaptains(orderId)).data,
  );

  @override
  Future<Either<Failure, CashierOrder>> assignCaptain(
    int orderId,
    int captainId,
  ) => fastHandler(
    request: () async =>
        (await _cashierApi.assignCaptain(orderId, {'captain_id': captainId})).data,
  );

  // ---- Customer ----
  @override
  Future<Either<Failure, CustomerProfile>> profile() =>
      fastHandler(request: () async => (await _customerApi.profile()).data);

  @override
  Future<Either<Failure, CustomerProfile>> updateProfile({
    String? name,
    String? preferredLocale,
  }) => fastHandler(
    request: () async => (await _customerApi.updateProfile({
      if (name != null) 'name': name,
      if (preferredLocale != null) 'preferred_locale': preferredLocale,
    })).data,
  );

  @override
  Future<Either<Failure, ProductsPage>> products({
    required int branchId,
    int? categoryId,
    String? search,
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _customerApi.products(
        branchId,
        categoryId,
        (search ?? '').trim().isEmpty ? null : search!.trim(),
        page,
        pageSize,
      );
      return (products: envelope.data, meta: envelope.meta);
    },
  );

  @override
  Future<Either<Failure, BranchProduct>> productDetail(int id) =>
      fastHandler(request: () async => (await _customerApi.productDetail(id)).data);

  @override
  Future<Either<Failure, List<ProductCategory>>> categories() =>
      fastHandler(request: () async => (await _customerApi.categories()).data);

  @override
  Future<Either<Failure, List<BranchProduct>>> favorites() =>
      fastHandler(request: () async => (await _customerApi.favorites()).data);

  @override
  Future<Either<Failure, Unit>> addFavorite(int branchItemId) => fastHandler(
    request: () async {
      await _customerApi.addFavorite(branchItemId);
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> removeFavorite(int branchItemId) => fastHandler(
    request: () async {
      await _customerApi.removeFavorite(branchItemId);
      return unit;
    },
  );

  @override
  Future<Either<Failure, List<DeliveryAddress>>> addresses() =>
      fastHandler(request: () async => (await _customerApi.addresses()).data);

  @override
  Future<Either<Failure, DeliveryAddress>> createAddress({
    required int cityId,
    required String displayAddress,
    required double lat,
    required double lng,
    String label = 'home',
    String? street,
    String? buildingNumber,
    String? floor,
    String? apartment,
    String? landmark,
    String? deliveryInstructions,
    bool isDefault = true,
  }) {
    final trimmedStreet = street?.trim();
    final trimmedBuilding = buildingNumber?.trim();
    final trimmedFloor = floor?.trim();
    final trimmedApartment = apartment?.trim();
    final trimmedLandmark = landmark?.trim();
    final trimmedInstructions = deliveryInstructions?.trim();

    return fastHandler(
      request: () async => (await _customerApi.createAddress({
        'city_id': cityId,
        'display_address': displayAddress.trim(),
        'lat': lat,
        'lng': lng,
        'label': label,
        if (trimmedStreet != null && trimmedStreet.isNotEmpty)
          'street': trimmedStreet,
        if (trimmedBuilding != null && trimmedBuilding.isNotEmpty)
          'building_number': trimmedBuilding,
        if (trimmedFloor != null && trimmedFloor.isNotEmpty)
          'floor': trimmedFloor,
        if (trimmedApartment != null && trimmedApartment.isNotEmpty)
          'apartment': trimmedApartment,
        if (trimmedLandmark != null && trimmedLandmark.isNotEmpty)
          'landmark': trimmedLandmark,
        if (trimmedInstructions != null && trimmedInstructions.isNotEmpty)
          'delivery_instructions': trimmedInstructions,
        'is_default': isDefault,
      })).data,
    );
  }

  @override
  Future<Either<Failure, DeliveryAddress>> updateAddress(
    int id,
    Map<String, dynamic> changes,
  ) => fastHandler(
    request: () async => (await _customerApi.updateAddress(id, changes)).data,
  );

  @override
  Future<Either<Failure, Unit>> deleteAddress(int id) => fastHandler(
    request: () async {
      await _customerApi.deleteAddress(id);
      return unit;
    },
  );

  @override
  Future<Either<Failure, CoverageResult>> coverageCheck({
    required double lat,
    required double lng,
    int? cityId,
    int? districtId,
  }) => fastHandler(
    request: () async => (await _customerApi.coverageCheck({
      'lat': lat,
      'lng': lng,
      if (cityId != null) 'city_id': cityId,
      if (districtId != null) 'district_id': districtId,
    })).data,
  );

  @override
  Future<Either<Failure, DeliveryZonesResult>> deliveryZones({
    int? cityId,
    double? lat,
    double? lng,
  }) => fastHandler(
    request: () async => _customerApi.deliveryZones(cityId, lat, lng),
  );

  @override
  Future<Either<Failure, List<PlaceSuggestion>>> placesAutocomplete({
    required String query,
    required String session,
  }) => fastHandler(
    request: () async =>
        (await _customerApi.placesAutocomplete(query.trim(), session))
            .suggestions,
  );

  @override
  Future<Either<Failure, PlaceLocation>> placeDetails({
    required String placeId,
    required String session,
  }) => fastHandler(
    request: () async =>
        (await _customerApi.placeDetails(placeId, session)).location,
  );

  @override
  Future<Either<Failure, CartValidationResult>> validateCart(
    List<CartLine> lines,
  ) => fastHandler(
    request: () async =>
        (await _customerApi.validateCart({'items': _wireLines(lines)})).data,
  );

  @override
  Future<Either<Failure, CheckoutQuote>> checkoutQuote({
    required int addressId,
    required List<CartLine> lines,
  }) => fastHandler(
    request: () async => (await _customerApi.checkoutQuote({
      'address_id': addressId,
      'items': _wireLines(lines),
    })).data,
  );

  @override
  Future<Either<Failure, CustomerOrder>> createOrder({
    required String idempotencyKey,
    required int addressId,
    required List<CartLine> lines,
    String? notes,
  }) => fastHandler(
    request: () async => (await _customerApi.createOrder(idempotencyKey, {
      'address_id': addressId,
      'items': _wireLines(lines),
      if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
    })).data,
  );

  @override
  Future<Either<Failure, CustomerOrdersPage>> customerOrders({
    required String statusGroup,
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _customerApi.orders(statusGroup, page, pageSize);
      return (orders: envelope.data, meta: envelope.meta);
    },
  );

  @override
  Future<Either<Failure, CustomerOrder>> customerOrderDetail(int id) =>
      fastHandler(request: () async => (await _customerApi.orderDetail(id)).data);

  @override
  Future<Either<Failure, CustomerOrder>> cancelOrder(int id) =>
      fastHandler(request: () async => (await _customerApi.cancelOrder(id)).data);

  @override
  Future<Either<Failure, Unit>> rateOrder(int id, RateOrderBody body) =>
      fastHandler(
        request: () async {
          await _customerApi.rateOrder(id, body);
          return unit;
        },
      );

  @override
  Future<Either<Failure, TicketsPage>> tickets({
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _customerApi.tickets(page, pageSize);
      return (items: envelope.data, meta: envelope.meta);
    },
  );

  @override
  Future<Either<Failure, Ticket>> ticket(int id) =>
      fastHandler(request: () async => (await _customerApi.ticket(id)).data);

  @override
  Future<Either<Failure, Ticket>> openTicket(OpenTicketBody body) =>
      fastHandler(request: () async => (await _customerApi.openTicket(body)).data);

  @override
  Future<Either<Failure, Ticket>> replyTicket(int id, String body) =>
      fastHandler(
        request: () async =>
            (await _customerApi.replyTicket(id, ReplyTicketBody(body: body))).data,
      );

  @override
  Future<Either<Failure, Ticket>> openCashierTicket(OpenTicketBody body) =>
      fastHandler(request: () async => (await _cashierApi.openTicket(body)).data);

  @override
  Future<Either<Failure, Ticket>> openCaptainTicket(OpenTicketBody body) =>
      fastHandler(request: () async => (await _captainApi.openTicket(body)).data);

  @override
  Future<Either<Failure, List<LegalSection>>> legalPolicies() => fastHandler(
    request: () async => (await _customerApi.legalPolicies()).data,
  );

  @override
  Future<Either<Failure, Unit>> deleteAccount() => fastHandler(
    request: () async {
      await _customerApi.deleteAccount();
      return unit;
    },
  );
}
