import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/enums/enums.dart';

class CashierOrderProduct extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final int quantity;
  final double price;
  final bool isPrepared;

  const CashierOrderProduct({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    this.isPrepared = false,
  });

  CashierOrderProduct copyWith({bool? isPrepared}) {
    return CashierOrderProduct(
      id: id,
      name: name,
      imageUrl: imageUrl,
      quantity: quantity,
      price: price,
      isPrepared: isPrepared ?? this.isPrepared,
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, quantity, price, isPrepared];
}

class CashierOrderDetailsState extends Equatable {
  final CashierOrderStatus status;
  final List<CashierOrderProduct> products;
  final String? captainName;
  final String? captainAvatarUrl;
  final String location;
  final DateTime orderTime;

  const CashierOrderDetailsState({
    required this.status,
    required this.products,
    required this.location,
    required this.orderTime,
    this.captainName,
    this.captainAvatarUrl,
  });

  bool get allPrepared => products.every((p) => p.isPrepared);

  int get productsCount => products.fold(0, (sum, p) => sum + p.quantity);

  double get totalAmount =>
      products.fold(0, (sum, p) => sum + p.quantity * p.price);

  CashierOrderDetailsState copyWith({
    CashierOrderStatus? status,
    List<CashierOrderProduct>? products,
    String? captainName,
    String? captainAvatarUrl,
    String? location,
    DateTime? orderTime,
  }) {
    return CashierOrderDetailsState(
      status: status ?? this.status,
      products: products ?? this.products,
      captainName: captainName ?? this.captainName,
      captainAvatarUrl: captainAvatarUrl ?? this.captainAvatarUrl,
      location: location ?? this.location,
      orderTime: orderTime ?? this.orderTime,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        captainName,
        captainAvatarUrl,
        location,
        orderTime,
      ];
}

class CashierOrderDetailsNotifier extends Notifier<CashierOrderDetailsState> {
  @override
  CashierOrderDetailsState build() {
    return _stateFor(CashierOrderStatus.preparing);
  }

  void seed(CashierOrderStatus initialStatus) {
    state = _stateFor(initialStatus);
  }

  void togglePrepared(String productId) {
    if (!state.status.isProductsEditable) return;
    state = state.copyWith(
      products: [
        for (final p in state.products)
          if (p.id == productId) p.copyWith(isPrepared: !p.isPrepared) else p,
      ],
    );
  }

  void confirmReadiness() {
    if (!state.status.isPreparing || !state.allPrepared) return;
    state = state.copyWith(status: CashierOrderStatus.readyForCaptain);
  }

  void assignCaptain({required String name, required String avatarUrl}) {
    state = state.copyWith(
      captainName: name,
      captainAvatarUrl: avatarUrl,
      status: CashierOrderStatus.inDelivery,
    );
  }
}

final cashierOrderDetailsController = NotifierProvider.autoDispose<
    CashierOrderDetailsNotifier, CashierOrderDetailsState>(
  CashierOrderDetailsNotifier.new,
);

CashierOrderDetailsState _stateFor(CashierOrderStatus status) {
  final preparedByDefault = !status.isPreparing;
  final showsCaptain = status.showsCaptainRow;
  return CashierOrderDetailsState(
    status: status,
    location: 'مكة المكرمة، المملكة العربية السعودية',
    orderTime: DateTime(2026, 3, 18),
    captainName: showsCaptain ? 'عماد مجدي' : null,
    captainAvatarUrl: showsCaptain ? 'https://i.pravatar.cc/200?img=12' : null,
    products: [
      CashierOrderProduct(
        id: 'p1',
        name: 'جزر أصفر (Hills Farm) · جزر شانتينيه',
        imageUrl: 'https://picsum.photos/id/102/100/100',
        quantity: 21,
        price: 12,
        isPrepared: preparedByDefault,
      ),
      CashierOrderProduct(
        id: 'p2',
        name: 'جزر أصفر (Hills Farm) · جزر شانتينيه',
        imageUrl: 'https://picsum.photos/id/103/100/100',
        quantity: 21,
        price: 12,
        isPrepared: preparedByDefault,
      ),
      CashierOrderProduct(
        id: 'p3',
        name: 'جزر أصفر (Hills Farm) · جزر شانتينيه',
        imageUrl: 'https://picsum.photos/id/104/100/100',
        quantity: 21,
        price: 12,
        isPrepared: preparedByDefault,
      ),
    ],
  );
}
