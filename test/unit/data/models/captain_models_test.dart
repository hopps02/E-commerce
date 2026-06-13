import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/data/response/captain/captain_response.dart';

void main() {
  group('captainStatusFromState', () {
    test('maps the captain lifecycle onto the five UI stages', () {
      expect(
        captainStatusFromState('captain_assigned'),
        CaptainOrderStatus.upcoming,
      );
      expect(
        captainStatusFromState('received_by_captain'),
        CaptainOrderStatus.received,
      );
      expect(
        captainStatusFromState('out_for_delivery'),
        CaptainOrderStatus.inDelivery,
      );
      expect(captainStatusFromState('delivered'), CaptainOrderStatus.delivered);
      expect(
        captainStatusFromState('failed_delivery'),
        CaptainOrderStatus.cancelled,
      );
    });

    test('states a captain never sees map to null', () {
      expect(captainStatusFromState('placed'), isNull);
      expect(captainStatusFromState('preparing'), isNull);
      expect(captainStatusFromState('rejected_by_merchant'), isNull);
    });
  });

  group('CaptainOrder.fromJson', () {
    final json = {
      'id': 7,
      'order_number': 'JAR-000386',
      'state': 'captain_assigned',
      'customer': {'name': 'سعيد', 'phone': '+966514010001'},
      'dropoff': {'display_address': 'حي العليا، الرياض'},
      'payment_method': 'cash',
      'total_halalas': 8550,
      'cash_to_collect_halalas': 8550,
      'failure_reason': null,
      'items': [
        {
          'id': 1,
          'name_ar': 'تفاح',
          'name_en': 'Apple',
          'quantity': 3,
          'unit_price_halalas': 1200,
          'removed': false,
        },
        {
          'id': 2,
          'name_ar': 'موز',
          'name_en': 'Banana',
          'quantity': 1,
          'unit_price_halalas': 500,
          'removed': true,
        },
      ],
      'created_at': '2026-06-11T06:25:00+03:00',
    };

    test('parses the captain payload (COD cash to collect)', () {
      final order = CaptainOrder.fromJson(json);

      expect(order.uiStatus, CaptainOrderStatus.upcoming);
      expect(order.customer?.phone, '+966514010001');
      expect(order.addressLine, 'حي العليا، الرياض');
      expect(order.totalHalalas, 8550);
      expect(order.cashToCollectHalalas, 8550);
    });

    test('activeItems excludes removed lines', () {
      final order = CaptainOrder.fromJson(json);
      expect(order.activeItems, hasLength(1));
      expect(order.activeItems.single.unitPriceHalalas, 1200);
    });
  });
}
