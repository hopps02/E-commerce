import 'package:dartz/dartz.dart';
import 'package:store/data/request/auth/auth_request.dart';
import 'package:store/data/request/customer/customer_request.dart';
import 'package:store/data/response/auth/auth_response.dart';

import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/response/customer/customer_response.dart';
import 'package:store/data/response/customer/support_response.dart';
import 'package:store/data/response/notification_response.dart';
import 'package:store/data/network/api/auth_api.dart';

import 'package:store/data/network/api/customer_api.dart';
import 'package:store/data/network/error_handler/error_handler.dart';
import 'package:store/data/network/error_handler/failure.dart';
import 'package:store/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final AuthApi _authApi;

  final CustomerApi _customerApi;

  RepositoryImpl(
    this._authApi,

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
  Future<Either<Failure, GuestSession>> guestLogin() =>
      fastHandler(request: () async => (await _authApi.guestLogin()).data);

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

  // ---- Notifications ----
  @override
  Future<Either<Failure, NotificationsPage>> notifications({
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _customerApi.notifications(page, pageSize);
      return (items: envelope.data, meta: envelope.meta);
    },
  );

  @override
  Future<Either<Failure, int>> unreadNotificationsCount() => fastHandler(
    request: () async =>
        (await _customerApi.unreadNotificationsCount()).data.unread,
  );

  @override
  Future<Either<Failure, MobileNotification>> markNotificationRead(int id) =>
      fastHandler(
        request: () async => (await _customerApi.markNotificationRead(id)).data,
      );

  @override
  Future<Either<Failure, int>> markAllNotificationsRead() => fastHandler(
    request: () async =>
        (await _customerApi.markAllNotificationsRead()).data.marked,
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
      'name': ?name,
      'preferred_locale': ?preferredLocale,
    })).data,
  );

  @override
  Future<Either<Failure, ProductsPage>> products({
    int? branchId,
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
  Future<Either<Failure, BranchProduct>> productDetail(int id) => fastHandler(
    request: () async => (await _customerApi.productDetail(id)).data,
  );

  @override
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
    required String displayAddress,
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
        'display_address': displayAddress.trim(),
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
  Future<Either<Failure, CartValidationResult>> validateCart(
    List<CartLine> lines,
  ) => fastHandler(
    request: () async =>
        (await _customerApi.validateCart({'items': _wireLines(lines)})).data,
  );

  @override
  Future<Either<Failure, CheckoutQuote>> checkoutQuote({
    int? addressId,
    required List<CartLine> lines,
  }) => fastHandler(
    request: () async => (await _customerApi.checkoutQuote({
      'address_id': ?addressId,
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
      fastHandler(
        request: () async => (await _customerApi.orderDetail(id)).data,
      );

  @override
  Future<Either<Failure, CustomerOrder>> cancelOrder(int id) => fastHandler(
    request: () async => (await _customerApi.cancelOrder(id)).data,
  );

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
      fastHandler(
        request: () async => (await _customerApi.openTicket(body)).data,
      );

  @override
  Future<Either<Failure, Ticket>> replyTicket(int id, String body) =>
      fastHandler(
        request: () async => (await _customerApi.replyTicket(
          id,
          ReplyTicketBody(body: body),
        )).data,
      );



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
