import 'package:dartz/dartz.dart';
import 'package:for_u/data/models/customer/catalog_models.dart';
import 'package:for_u/data/models/customer/customer_models.dart';
import 'package:for_u/data/network/api/customer_api.dart';
import 'package:for_u/data/network/error_handler/error_handler.dart';
import 'package:for_u/data/network/error_handler/failure.dart';
import 'package:for_u/domain/repository/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerApi _api;

  CustomerRepositoryImpl(this._api);

  /// Validate/quote/create all send the same wire lines.
  static List<Map<String, int>> _wireLines(List<CartLine> lines) => lines
      .map((l) => {'branch_item_id': l.branchItemId, 'quantity': l.quantity})
      .toList();

  @override
  Future<Either<Failure, CustomerProfile>> profile() =>
      fastHandler(request: () async => (await _api.profile()).data);

  @override
  Future<Either<Failure, ProductsPage>> products({
    required int branchId,
    int? categoryId,
    String? search,
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _api.products(
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
      fastHandler(request: () async => (await _api.productDetail(id)).data);

  @override
  Future<Either<Failure, List<ProductCategory>>> categories() =>
      fastHandler(request: () async => (await _api.categories()).data);

  @override
  Future<Either<Failure, List<BranchProduct>>> favorites() =>
      fastHandler(request: () async => (await _api.favorites()).data);

  @override
  Future<Either<Failure, Unit>> addFavorite(int branchItemId) => fastHandler(
    request: () async {
      await _api.addFavorite(branchItemId);
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> removeFavorite(int branchItemId) =>
      fastHandler(
        request: () async {
          await _api.removeFavorite(branchItemId);
          return unit;
        },
      );

  @override
  Future<Either<Failure, List<DeliveryAddress>>> addresses() =>
      fastHandler(request: () async => (await _api.addresses()).data);

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
  }) => fastHandler(
    request: () async => (await _api.createAddress({
      'city_id': cityId,
      'display_address': displayAddress,
      'lat': lat,
      'lng': lng,
      'label': label,
      if (street != null && street.isNotEmpty) 'street': street,
      if (buildingNumber != null && buildingNumber.isNotEmpty)
        'building_number': buildingNumber,
      if (floor != null && floor.isNotEmpty) 'floor': floor,
      if (apartment != null && apartment.isNotEmpty) 'apartment': apartment,
      if (landmark != null && landmark.isNotEmpty) 'landmark': landmark,
      if (deliveryInstructions != null && deliveryInstructions.isNotEmpty)
        'delivery_instructions': deliveryInstructions,
      'is_default': isDefault,
    })).data,
  );

  @override
  Future<Either<Failure, DeliveryAddress>> updateAddress(
    int id,
    Map<String, dynamic> changes,
  ) => fastHandler(
    request: () async => (await _api.updateAddress(id, changes)).data,
  );

  @override
  Future<Either<Failure, Unit>> deleteAddress(int id) => fastHandler(
    request: () async {
      await _api.deleteAddress(id);
      return unit;
    },
  );

  @override
  Future<Either<Failure, CoverageResult>> coverageCheck({
    required double lat,
    required double lng,
  }) => fastHandler(
    request: () async =>
        (await _api.coverageCheck({'lat': lat, 'lng': lng})).data,
  );

  @override
  Future<Either<Failure, CartValidationResult>> validateCart(
    List<CartLine> lines,
  ) => fastHandler(
    request: () async =>
        (await _api.validateCart({'items': _wireLines(lines)})).data,
  );

  @override
  Future<Either<Failure, CheckoutQuote>> checkoutQuote({
    required int addressId,
    required List<CartLine> lines,
  }) => fastHandler(
    request: () async => (await _api.checkoutQuote({
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
    request: () async => (await _api.createOrder(idempotencyKey, {
      'address_id': addressId,
      'items': _wireLines(lines),
      if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
    })).data,
  );

  @override
  Future<Either<Failure, CustomerProfile>> updateProfile({
    String? name,
    String? preferredLocale,
  }) => fastHandler(
    request: () async => (await _api.updateProfile({
      if (name != null) 'name': name,
      if (preferredLocale != null) 'preferred_locale': preferredLocale,
    })).data,
  );

  @override
  Future<Either<Failure, CustomerOrdersPage>> orders({
    required String statusGroup,
    required int page,
    int pageSize = 20,
  }) => fastHandler(
    request: () async {
      final envelope = await _api.orders(statusGroup, page, pageSize);
      return (orders: envelope.data, meta: envelope.meta);
    },
  );

  @override
  Future<Either<Failure, CustomerOrder>> orderDetail(int id) =>
      fastHandler(request: () async => (await _api.orderDetail(id)).data);

  @override
  Future<Either<Failure, CustomerOrder>> cancelOrder(int id) =>
      fastHandler(request: () async => (await _api.cancelOrder(id)).data);

  @override
  Future<Either<Failure, Unit>> rateOrder(int id, RateOrderBody body) =>
      fastHandler(
        request: () async {
          await _api.rateOrder(id, body);
          return unit;
        },
      );

  @override
  Future<Either<Failure, Unit>> openTicket(OpenTicketBody body) => fastHandler(
    request: () async {
      await _api.openTicket(body);
      return unit;
    },
  );

  @override
  Future<Either<Failure, Unit>> deleteAccount() => fastHandler(
    request: () async {
      await _api.deleteAccount();
      return unit;
    },
  );
}
