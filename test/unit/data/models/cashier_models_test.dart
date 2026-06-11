import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/data/models/cashier/cashier_models.dart';

void main() {
  group('cashierStatusFromState', () {
    test('maps every backend state onto the four UI stages', () {
      expect(cashierStatusFromState('placed'), CashierOrderStatus.preparing);
      expect(cashierStatusFromState('preparing'), CashierOrderStatus.preparing);
      expect(
        cashierStatusFromState('ready_for_pickup'),
        CashierOrderStatus.readyForCaptain,
      );
      expect(
        cashierStatusFromState('captain_assigned'),
        CashierOrderStatus.inDelivery,
      );
      expect(
        cashierStatusFromState('received_by_captain'),
        CashierOrderStatus.inDelivery,
      );
      expect(
        cashierStatusFromState('out_for_delivery'),
        CashierOrderStatus.inDelivery,
      );
      expect(cashierStatusFromState('delivered'), CashierOrderStatus.delivered);
    });

    test('states outside the cashier queues map to null, not a wrong card', () {
      expect(cashierStatusFromState('rejected_by_merchant'), isNull);
      expect(cashierStatusFromState('cancelled_by_customer'), isNull);
      expect(cashierStatusFromState('failed_delivery'), isNull);
      expect(cashierStatusFromState('some_future_state'), isNull);
    });
  });

  group('CashierOrder.fromJson', () {
    final json = {
      'id': 5,
      'order_number': 'GOC-00000005',
      'state': 'preparing',
      'captain_id': null,
      'captain': null,
      'items_count': 2,
      'customer': {
        'address': {'display_address': 'شارع 14، تبوك'},
      },
      'totals': {
        'subtotal_halalas': 2000,
        'delivery_fee_halalas': 1500,
        'discount_halalas': 0,
        'total_halalas': 3500,
      },
      'items': [
        {
          'id': 9,
          'name_ar': 'تفاح',
          'name_en': 'Apple',
          'image_url': 'https://cdn.4u.test/apple.png',
          'quantity': 2,
          'unit_price_halalas': 1000,
          'discount_halalas': 0,
          'total_halalas': 2000,
          'prepared': false,
          'prepared_at': null,
          'removed': false,
          'removed_reason': null,
        },
        {
          'id': 10,
          'name_ar': 'موز',
          'name_en': 'Banana',
          'image_url': null,
          'quantity': 1,
          'unit_price_halalas': 500,
          'discount_halalas': 0,
          'total_halalas': 500,
          'prepared': false,
          'prepared_at': null,
          'removed': true,
          'removed_reason': 'out of stock',
        },
      ],
      'created_at': '2026-06-11T06:25:00+03:00',
    };

    test('parses the full queue/detail payload', () {
      final order = CashierOrder.fromJson(json);

      expect(order.orderNumber, 'GOC-00000005');
      expect(order.uiStatus, CashierOrderStatus.preparing);
      expect(order.addressLine, 'شارع 14، تبوك');
      expect(order.totals.totalHalalas, 3500);
      expect(order.itemsCount, 2);
      expect(order.createdAt, isNotNull);
    });

    test('activeItems excludes cashier-removed lines', () {
      final order = CashierOrder.fromJson(json);

      expect(order.items, hasLength(2));
      expect(order.activeItems, hasLength(1));
      expect(order.activeItems.single.nameAr, 'تفاح');
    });

    test('item display name follows the app language with fallbacks', () {
      final order = CashierOrder.fromJson(json);
      final item = order.activeItems.single;

      expect(item.name(true), 'تفاح');
      expect(item.name(false), 'Apple');
    });

    test('missing address snapshot degrades to an empty line', () {
      final without = Map<String, dynamic>.from(json)..['customer'] = null;
      expect(CashierOrder.fromJson(without).addressLine, '');
    });
  });

  group('AvailableCaptain.fromJson', () {
    test('parses the assignment sheet entry', () {
      final captain = AvailableCaptain.fromJson(const {
        'id': 3,
        'name': 'ناصر احمد',
        'phone': '+966550001000',
        'is_available': true,
        'completed_today': 2,
      });

      expect(captain.name, 'ناصر احمد');
      expect(captain.completedToday, 2);
    });
  });
}
