import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/data/response/customer/support_response.dart';

void main() {
  group('Ticket.fromJson', () {
    test('parses a detail payload with its message thread', () {
      final ticket = Ticket.fromJson(const {
        'id': 3,
        'ticket_number': 'TKT-00000003',
        'category': 'inquiry',
        'priority': 'normal',
        'status': 'open',
        'title': 'بخصوص طلبي',
        'description': 'الطلب وصل ناقص',
        'merchant_id': 1,
        'merchant_name_ar': 'متجر جار',
        'merchant_name_en': 'Jar Store',
        'branch_id': 1,
        'order_id': 13,
        'messages': [
          {
            'id': 3,
            'sender_type': 'Customer',
            'body': 'الطلب وصل ناقص',
            'is_internal_note': false,
            'created_at': '2026-06-15T06:06:30+03:00',
          },
          {
            'id': 4,
            'sender_type': 'AdminUser',
            'body': 'تم استلام شكواك',
            'is_internal_note': false,
            'created_at': '2026-06-15T06:10:00+03:00',
          },
        ],
        'created_at': '2026-06-15T06:06:30+03:00',
        'updated_at': '2026-06-15T06:10:00+03:00',
      });

      expect(ticket.id, 3);
      expect(ticket.ticketNumber, 'TKT-00000003');
      expect(ticket.status, 'open');
      expect(ticket.isClosed, isFalse);
      expect(ticket.orderId, 13);
      expect(ticket.merchantName(true), 'متجر جار');
      expect(ticket.merchantName(false), 'Jar Store');
      expect(ticket.thread, hasLength(2));
      // The opener's own message vs the support reply.
      expect(ticket.thread.first.isFromOpener, isTrue);
      expect(ticket.thread.last.isFromOpener, isFalse);
    });

    test('a list row omits messages (thread is empty, not null-crashing)', () {
      final ticket = Ticket.fromJson(const {
        'id': 5,
        'ticket_number': 'TKT-00000005',
        'status': 'closed',
        'title': 'سؤال',
        'description': 'استفسار عام',
        'order_id': null,
      });

      expect(ticket.thread, isEmpty);
      expect(ticket.isClosed, isTrue);
      expect(ticket.orderId, isNull);
    });
  });

  group('TicketMessage.fromJson', () {
    test('maps the sender to opener vs support', () {
      TicketMessage from(String sender) => TicketMessage.fromJson({
        'id': 1,
        'sender_type': sender,
        'body': 'x',
        'is_internal_note': false,
        'created_at': '2026-06-15T06:06:30+03:00',
      });

      expect(from('Customer').isFromOpener, isTrue);
      expect(from('Cashier').isFromOpener, isTrue);
      expect(from('Captain').isFromOpener, isTrue);
      expect(from('AdminUser').isFromOpener, isFalse);
      expect(from('MerchantUser').isFromOpener, isFalse);
    });
  });

  group('LegalSection.fromJson', () {
    test('parses titles per locale and detects an empty body', () {
      final section = LegalSection.fromJson(const {
        'key': 'terms',
        'title_ar': 'الشروط والأحكام',
        'title_en': 'Terms & Conditions',
        'body': '',
      });

      expect(section.key, 'terms');
      expect(section.title(true), 'الشروط والأحكام');
      expect(section.title(false), 'Terms & Conditions');
      // Empty backend body → honest empty state.
      expect(section.hasBody, isFalse);
    });

    test('reports a non-empty body', () {
      final section = LegalSection.fromJson(const {
        'key': 'privacy',
        'title_ar': 'الخصوصية',
        'title_en': 'Privacy',
        'body': 'Real policy text.',
      });
      expect(section.hasBody, isTrue);
    });
  });
}
