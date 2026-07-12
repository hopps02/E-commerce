import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store/presentation/views/user/support/riverpod/create_ticket_controller.dart';

void main() {
  group('CreateTicketNotifier.selectOrder', () {
    late ProviderContainer container;
    late CreateTicketNotifier notifier;

    setUp(() {
      container = ProviderContainer();
      addTearDown(container.dispose);
      notifier = container.read(createTicketController.notifier);
    });

    CreateTicketState state() => container.read(createTicketController);

    test('starts as a general ticket (no linked order)', () {
      expect(state().hasLinkedOrder, isFalse);
      expect(state().linkedOrderId, isNull);
    });

    test('links an order, then clears back to a general ticket', () {
      notifier.selectOrder(13, 'GOC-000013');
      expect(state().hasLinkedOrder, isTrue);
      expect(state().linkedOrderId, 13);
      expect(state().linkedOrderNumber, 'GOC-000013');

      notifier.selectOrder(null, '');
      expect(state().hasLinkedOrder, isFalse);
      expect(state().linkedOrderId, isNull);
      expect(state().linkedOrderNumber, '');
    });
  });
}
