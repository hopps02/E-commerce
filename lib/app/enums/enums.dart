enum SuccessViewType {
  order,
  auth;

  bool get isOrder => this == order;
  bool get isAuth => this == auth;
}
/// The four states an order can be in inside the cashier flow. Drives the
/// order-details screen's bottom action button and whether the products table
/// + captain row are editable / visible.
enum CashierOrderStatus {
  /// Cashier is checking off each product as it gets prepared. Button shows
  /// "تأكيد الجاهزية" and is disabled until every product is checked.
  preparing,

  /// Everything is prepared, cashier now needs to pick a delivery captain.
  /// Button shows "تعيين كابتن" and opens the assign-captain bottom sheet.
  readyForCaptain,

  /// Captain assigned and out for delivery. No action button; amber status
  /// pill + captain row are shown at the top.
  inDelivery,

  /// Order delivered to customer. No action button; green status pill +
  /// captain row are shown.
  delivered;

  bool get isPreparing => this == preparing;
  bool get isReadyForCaptain => this == readyForCaptain;
  bool get isInDelivery => this == inDelivery;
  bool get isDelivered => this == delivered;

  /// Products can only be ticked off while the cashier is preparing the order.
  bool get isProductsEditable => isPreparing;

  /// Captain row + status pill appear once the order leaves the cashier.
  bool get showsCaptainRow => isInDelivery || isDelivered;

  /// Bottom action button is hidden once the order has been handed off.
  bool get showsActionButton => isPreparing || isReadyForCaptain;
}