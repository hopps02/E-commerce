import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/app/validation/field_rules.dart';

void main() {
  // FocusNode.requestFocus reaches into the binding's focus manager.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Rules.required', () {
    test('fails on empty and whitespace-only input', () {
      final rule = Rules.required('required');
      expect(rule(''), 'required');
      expect(rule('   '), 'required');
    });

    test('passes on non-empty input', () {
      expect(Rules.required('required')('Ahmed'), isNull);
    });

    test('defaults to an empty (focus-only) message', () {
      expect(Rules.required()(''), '');
    });
  });

  group('Rules.minLength', () {
    test('fails below the threshold', () {
      expect(Rules.minLength(3, 'too short')('ab'), 'too short');
    });

    test('passes at or above the threshold', () {
      expect(Rules.minLength(3, 'too short')('abc'), isNull);
    });
  });

  group('Rules.all', () {
    test('returns the first failing rule message', () {
      final rule = Rules.all([
        Rules.required('required'),
        Rules.minLength(3, 'too short'),
      ]);
      expect(rule(''), 'required');
      expect(rule('ab'), 'too short');
      expect(rule('abc'), isNull);
    });
  });

  group('validateOnSubmit', () {
    test('returns the first invalid field message and focuses it', () {
      final nameNode = FocusNode();
      final messageNode = FocusNode();
      addTearDown(nameNode.dispose);
      addTearDown(messageNode.dispose);

      final error = validateOnSubmit([
        SubmitField(value: '', focusNode: nameNode, rule: Rules.required('n')),
        SubmitField(
          value: '',
          focusNode: messageNode,
          rule: Rules.required('m'),
        ),
      ]);

      expect(error, 'n');
    });

    test('returns null when every field passes', () {
      final node = FocusNode();
      addTearDown(node.dispose);

      final error = validateOnSubmit([
        SubmitField(value: 'Ahmed', focusNode: node, rule: Rules.required('n')),
      ]);

      expect(error, isNull);
    });
  });
}
