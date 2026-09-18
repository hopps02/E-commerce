import 'package:flutter_test/flutter_test.dart';
import 'package:store/data/request/customer/customer_request.dart';
import 'package:store/data/response/customer/customer_response.dart';

void main() {
  group('orderTimelineStep', () {
    test('maps the lifecycle onto the 3-step card timeline', () {
      expect(orderTimelineStep('placed'), 1);
      expect(orderTimelineStep('preparing'), 1);
      expect(orderTimelineStep('ready_for_pickup'), 1);
      expect(orderTimelineStep('out_for_delivery'), 2);
      expect(orderTimelineStep('delivered'), 3);
    });

    test('terminal failures show the step they stopped at', () {
      expect(orderTimelineStep('failed_delivery'), 2);
      expect(orderTimelineStep('cancelled_by_customer'), 1);
      expect(orderTimelineStep('rejected_by_merchant'), 1);
    });
  });

  group('orderIsCancellable', () {
    test('mirrors the backend cancel guard (placed only)', () {
      expect(orderIsCancellable('placed'), isTrue);
      expect(orderIsCancellable('preparing'), isFalse);
      expect(orderIsCancellable('ready_for_pickup'), isFalse);
      expect(orderIsCancellable('out_for_delivery'), isFalse);
      expect(orderIsCancellable('delivered'), isFalse);
    });
  });

  group('CustomerOrder.fromJson', () {
    test('parses a LIST row (flat total + items preview)', () {
      final order = CustomerOrder.fromJson(const {
        'id': 5,
        'order_number': 'JAR-000385',
        'state': 'preparing',
        'items_count': 2,
        'items': [
          {
            'id': 1,
            'name_ar': 'خبز',
            'name_en': 'Bread',
            'image_url': 'https://cdn.4u.test/bread.png',
            'removed': false,
          },
          {'id': 2, 'name_ar': 'موز', 'name_en': 'Banana', 'removed': true},
        ],
        'total_halalas': 3500,
        'created_at': '2026-06-10T06:06:00+03:00',
      });

      expect(order.displayTotalHalalas, 3500);
      expect(order.timelineStep, 1);
      expect(order.activeItems, hasLength(1));
      expect(
        order.activeItems.single.imageUrl,
        'https://cdn.4u.test/bread.png',
      );
      // List rows omit can_rate — eligibility is a detail-only field.
      expect(order.canRate, isFalse);
    });

    test('parses a DETAIL payload (nested totals + address)', () {
      final order = CustomerOrder.fromJson(const {
        'id': 6,
        'order_number': 'JAR-000386',
        'state': 'delivered',
        'address': {'display_address': 'حي العليا، الرياض'},
        'totals': {
          'subtotal_halalas': 7050,
          'delivery_fee_halalas': 1500,
          'discount_halalas': 0,
          'vat_halalas': 0,
          'total_halalas': 8550,
        },
        'items': [
          {
            'id': 9,
            'branch_item_id': 3,
            'name_ar': 'كيك',
            'name_en': 'Cake',
            'quantity': 3,
            'unit_price_halalas': 1200,
            'total_halalas': 3600,
            'removed': false,
          },
        ],
        'can_rate': true,
        'created_at': '2026-06-10T06:06:00+03:00',
      });

      expect(order.displayTotalHalalas, 8550);
      expect(order.timelineStep, 3);
      expect(order.isDelivered, isTrue);
      expect(order.canRate, isTrue);
      expect(order.addressLine, 'حي العليا، الرياض');
      expect(order.activeItems.single.unitPriceHalalas, 1200);
    });
  });

  group('RateOrderBody', () {
    test('serializes the three required axes with backend names', () {
      const body = RateOrderBody(
        overallStars: 5,
        orderAccuracyStars: 5,
        deliverySpeedStars: 3,
        comment: 'ممتاز',
      );

      expect(body.toJson(), {
        'overall_stars': 5,
        'order_accuracy_stars': 5,
        'delivery_speed_stars': 3,
        'comment': 'ممتاز',
      });
    });
  });
}
