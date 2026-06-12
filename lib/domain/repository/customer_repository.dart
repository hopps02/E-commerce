import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/customer/catalog_models.dart';
import 'package:for_u/data/models/customer/customer_models.dart';
import 'package:for_u/data/network/envelope.dart';
import 'package:for_u/data/network/error_handler/failure.dart';

/// A page of customer orders with its pagination block.
typedef CustomerOrdersPage = ({List<CustomerOrder> orders, Meta? meta});

/// A page of branch products with its pagination block.
typedef ProductsPage = ({List<BranchProduct> products, Meta? meta});

abstract class CustomerRepository {
  Future<Either<Failure, CustomerProfile>> profile();

  Future<Either<Failure, CustomerProfile>> updateProfile({
    String? name,
    String? preferredLocale,
  });

  Future<Either<Failure, ProductsPage>> products({
    required int branchId,
    int? categoryId,
    String? search,
    required int page,
    int pageSize,
  });

  Future<Either<Failure, BranchProduct>> productDetail(int id);

  Future<Either<Failure, List<ProductCategory>>> categories();

  Future<Either<Failure, List<DeliveryAddress>>> addresses();

  Future<Either<Failure, DeliveryAddress>> createAddress({
    required int cityId,
    required String displayAddress,
    required double lat,
    required double lng,
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

  Future<Either<Failure, CoverageResult>> coverageCheck({
    required double lat,
    required double lng,
  });

  Future<Either<Failure, CartValidationResult>> validateCart(
    List<CartLine> lines,
  );

  Future<Either<Failure, CheckoutQuote>> checkoutQuote({
    required int addressId,
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

  Future<Either<Failure, CustomerOrdersPage>> orders({
    required String statusGroup,
    required int page,
    int pageSize,
  });

  Future<Either<Failure, CustomerOrder>> orderDetail(int id);

  Future<Either<Failure, CustomerOrder>> cancelOrder(int id);

  Future<Either<Failure, Unit>> rateOrder(int id, RateOrderBody body);

  Future<Either<Failure, Unit>> openTicket(OpenTicketBody body);

  /// Server-side soft delete; the caller still clears the local session.
  Future<Either<Failure, Unit>> deleteAccount();
}
