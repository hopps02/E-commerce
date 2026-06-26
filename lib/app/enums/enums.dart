enum SuccessViewType {
  order,
  auth;

  bool get isOrder => this == order;
  bool get isAuth => this == auth;
}

/// The cashier-visible stages an order can be in. Drives the
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
  delivered,

  /// Captain could not complete delivery. Read-only danger status.
  failedDelivery,

  /// Order was cancelled. Read-only danger status.
  cancelled,

  /// Merchant rejected the order. Read-only danger status.
  rejectedByMerchant;

  bool get isPreparing => this == preparing;
  bool get isReadyForCaptain => this == readyForCaptain;
  bool get isInDelivery => this == inDelivery;
  bool get isDelivered => this == delivered;
  bool get isFailedDelivery => this == failedDelivery;
  bool get isCancelled => this == cancelled;
  bool get isRejectedByMerchant => this == rejectedByMerchant;
  bool get isException =>
      isFailedDelivery || isCancelled || isRejectedByMerchant;

  /// Products can only be ticked off while the cashier is preparing the order.
  bool get isProductsEditable => isPreparing;

  /// Captain row appears once the order is assigned to a captain.
  bool get showsCaptainRow => isInDelivery || isDelivered || isFailedDelivery;

  /// Status pill appears once the order leaves the active preparation states.
  bool get showsStatusBadge => isInDelivery || isDelivered || isException;

  /// Bottom action button is hidden once the order has been handed off.
  bool get showsActionButton => isPreparing || isReadyForCaptain;

  /// The captain can be replaced while the order is assigned but not yet
  /// delivered (captain_assigned / received_by_captain / out_for_delivery).
  bool get canReassignCaptain => isInDelivery;
}

/// Why a cashier replaces the captain on a live order. Values mirror the
/// backend ReassignReason; the localized labels live in the change-captain UI.
enum ReassignReason {
  captainUnavailable('captain_unavailable'),
  captainSick('captain_sick'),
  captainBrokeDown('captain_broke_down'),
  customerRequest('customer_request'),
  other('other');

  final String value;
  const ReassignReason(this.value);

  bool get isOther => this == other;
}

/// States for the captain order-details screen. Drives which footer buttons
/// are visible, whether the status pill on the customer card shows up, and
/// whether the cancellation-reason box is rendered.
enum CaptainOrderStatus {
  /// Just-arrived order. Footer: single "قبول واستلام الطلب" CTA.
  upcoming,

  /// Captain accepted but hasn't started delivery. Footer: green "بدء التوصيل"
  /// + red-tinted "تعذر التوصيل".
  received,

  /// Out for delivery. Status pill on customer card. Footer: green
  /// "تأكيد تسليم الطلب" + red-tinted "تعذر التوصيل".
  inDelivery,

  /// Delivered to customer. Read-only. Green pill on customer card.
  delivered,

  /// Failed delivery. Read-only. Red pill + failure-reason box at bottom.
  failed,

  /// Cancelled order. Read-only. Red pill.
  cancelled;

  bool get isUpcoming => this == upcoming;
  bool get isReceived => this == received;
  bool get isInDelivery => this == inDelivery;
  bool get isDelivered => this == delivered;
  bool get isFailed => this == failed;
  bool get isCancelled => this == cancelled;

  bool get isReadOnly => isDelivered || isFailed || isCancelled;
  bool get showsStatusPill => isInDelivery || isReadOnly;
}

enum CaptainDeliveryOutcomeKind {
  success,
  failure;

  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}
