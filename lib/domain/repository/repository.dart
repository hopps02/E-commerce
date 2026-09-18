import 'package:dartz/dartz.dart';
import 'package:store/data/request/auth/auth_request.dart';
import 'package:store/data/request/customer/customer_request.dart';
import 'package:store/data/response/auth/auth_response.dart';

import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/data/response/customer/customer_response.dart';
import 'package:store/data/response/customer/support_response.dart';
import 'package:store/data/response/notification_response.dart';
import 'package:store/data/network/envelope.dart';
import 'package:store/data/network/error_handler/failure.dart';


/// A page of customer orders with its pagination block.
typedef CustomerOrdersPage = ({List<CustomerOrder> orders, Meta? meta});

/// A page of branch products with its pagination block.
typedef ProductsPage = ({List<BranchProduct> products, Meta? meta});

/// A page of support tickets with its pagination block.
typedef TicketsPage = ({List<Ticket> items, Meta? meta});

/// A page of in-app notifications with its pagination block.
typedef NotificationsPage = ({List<MobileNotification> items, Meta? meta});

/// The single application repository. Backed by the auth, captain, cashier and
/// customer APIs; every feature reaches it through a dedicated use case rather
/// than calling it directly.
abstract class Repository {
  // ---- Auth ----
  Future<Either<Failure, OtpRequested>> requestOtp(String phone);

  Future<Either<Failure, AuthSession>> verifyOtp(String phone, String code);

  Future<Either<Failure, GuestSession>> guestLogin();

  Future<Either<Failure, MeData>> me();

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> registerDevice(RegisterDeviceBody body);

  Future<Either<Failure, Unit>> unregisterDevice(String token);

  // ---- Notifications ----
  Future<Either<Failure, NotificationsPage>> notifications({
    required int page,
    int pageSize,
  });

  Future<Either<Failure, int>> unreadNotificationsCount();

  Future<Either<Failure, MobileNotification>> markNotificationRead(int id);

  Future<Either<Failure, int>> markAllNotificationsRead();



  // ---- Customer ----
  Future<Either<Failure, CustomerProfile>> profile();

  Future<Either<Failure, CustomerProfile>> updateProfile({
    String? name,
    String? preferredLocale,
  });

  Future<Either<Failure, ProductsPage>> products({
    int? branchId,
    int? categoryId,
    String? search,
    required int page,
    int pageSize,
  });

  Future<Either<Failure, BranchProduct>> productDetail(int id);

  Future<Either<Failure, List<ProductCategory>>> categories();

  Future<Either<Failure, List<HomeBanner>>> banners();

  Future<Either<Failure, List<BranchProduct>>> favorites();

  Future<Either<Failure, Unit>> addFavorite(int branchItemId);

  Future<Either<Failure, Unit>> removeFavorite(int branchItemId);

  Future<Either<Failure, List<DeliveryAddress>>> addresses();

  Future<Either<Failure, DeliveryAddress>> createAddress({
    required String displayAddress,
    String label,
    String? street,
    String? buildingNumber,
    String? floor,
    String? apartment,
    String? landmark,
    String? deliveryInstructions,
    bool isDefault,
  });

  /// Partial update; pass `isDefault: true` to make it the default (the
  /// backend un-defaults the rest — it never silently un-defaults).
  Future<Either<Failure, DeliveryAddress>> updateAddress(
    int id,
    Map<String, dynamic> changes,
  );

  Future<Either<Failure, Unit>> deleteAddress(int id);

  Future<Either<Failure, CartValidationResult>> validateCart(
    List<CartLine> lines,
  );

  Future<Either<Failure, CheckoutQuote>> checkoutQuote({
    int? addressId,
    required List<CartLine> lines,
  });

  /// COD order creation. The idempotency key makes a double tap return the
  /// same order instead of placing two.
  Future<Either<Failure, CustomerOrder>> createOrder({
    required String idempotencyKey,
    required int addressId,
    required List<CartLine> lines,
    String? notes,
  });

  Future<Either<Failure, CustomerOrdersPage>> customerOrders({
    required String statusGroup,
    required int page,
    int pageSize,
  });

  Future<Either<Failure, CustomerOrder>> customerOrderDetail(int id);

  Future<Either<Failure, CustomerOrder>> cancelOrder(int id);

  Future<Either<Failure, Unit>> rateOrder(int id, RateOrderBody body);

  Future<Either<Failure, TicketsPage>> tickets({
    required int page,
    int pageSize,
  });

  Future<Either<Failure, Ticket>> ticket(int id);

  Future<Either<Failure, Ticket>> openTicket(OpenTicketBody body);

  Future<Either<Failure, Ticket>> replyTicket(int id, String body);



  Future<Either<Failure, List<LegalSection>>> legalPolicies();

  /// Server-side soft delete; the caller still clears the local session.
  Future<Either<Failure, Unit>> deleteAccount();
}
