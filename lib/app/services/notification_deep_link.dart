import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/views/captain/order_details/view/screens/captain_order_details_view.dart';
import 'package:store/presentation/views/cashier/order_details/view/screens/cashier_order_details_view.dart';
import 'package:store/presentation/views/user/order_details/view/screens/order_details_view.dart';
import 'package:store/presentation/views/user/support/view/screens/ticket_detail_view.dart';

/// Turns a tapped in-app notification into navigation.
///
/// The backend stamps every notification with its `type` (e.g. `order.delivered`)
/// alongside the target id (`order_id` / `ticket_id`). We route on the type
/// because the type already implies the audience — a captain only ever sees
/// `delivery.*`, a branch the `*_for_branch` events, and a customer the rest — so
/// the screen follows from the type without a separate role lookup.
class NotificationDeepLink {
  NotificationDeepLink._();

  static void open({
    required String type,
    required Map<String, dynamic> payload,
  }) {
    final target = _resolve({'type': type, ...payload});
    if (target == null) return;
    appRouter.pushNamed(target.routeName, extra: target.extra);
  }

  static _DeepLinkTarget? _resolve(Map<String, dynamic> data) {
    final type = (data['type'] ?? '').toString();
    if (type.isEmpty) return null;

    final orderId = int.tryParse((data['order_id'] ?? '').toString());
    final ticketId = int.tryParse((data['ticket_id'] ?? '').toString());

    // Captain — new assignment / hand-off to another captain.
    if (type.startsWith('delivery.')) {
      if (orderId == null) return null;
      return _DeepLinkTarget(
        Routes.captainOrderDetails.name,
        CaptainOrderDetailsArgs(orderId: orderId),
      );
    }

    // Cashier — branch-facing order events.
    if (type == 'order.new_for_branch' || type == 'order.failed_for_branch') {
      if (orderId == null) return null;
      return _DeepLinkTarget(
        Routes.cashierOrderDetails.name,
        CashierOrderDetailsArgs(orderId: orderId),
      );
    }

    // Customer — every other order event opens the order details screen;
    // `order.delivered` additionally pops the rating sheet so the prompt to
    // "tap to rate" lands the customer straight on the rating.
    if (type.startsWith('order.')) {
      if (orderId == null) return null;
      return _DeepLinkTarget(
        Routes.orderDetails.name,
        OrderDetailsArgs(
          orderId: orderId,
          openRating: type == 'order.delivered',
        ),
      );
    }

    // Customer — support ticket updates.
    if (type.startsWith('support.')) {
      if (ticketId == null) return null;
      return _DeepLinkTarget(
        Routes.ticketDetail.name,
        TicketDetailArgs(id: ticketId),
      );
    }

    // billing.* / catalog.* / inventory.* / cashhandover.* / account.* have no
    // dedicated mobile screen — tapping simply brings the app to the front.
    return null;
  }
}

class _DeepLinkTarget {
  final String routeName;
  final Object extra;

  const _DeepLinkTarget(this.routeName, this.extra);
}
