import 'package:flutter_test/flutter_test.dart';
import 'package:for_u/app/utils/validator.dart';

void main() {
  group('FieldsValidator', () {
    test('onDone is called when every validator passes', () {
      final fields = FieldsValidator();
      EmptyFullNameValidator(fields).text = 'Ahmed';
      EmptyPhoneValidator(fields).text = '0100000000';

      var doneCalled = false;
      var invalidCalled = false;
      fields.validate((_, __) => invalidCalled = true, () => doneCalled = true);

      expect(doneCalled, isTrue);
      expect(invalidCalled, isFalse);
    });

    test('onInvalid fires on the first failing validator and stops', () {
      final fields = FieldsValidator();
      final name = EmptyFullNameValidator(fields)..text = '';
      EmptyPhoneValidator(fields).text = '';

      Validator? failed;
      var doneCalled = false;
      fields.validate((_, v) => failed = v, () => doneCalled = true);

      expect(failed, same(name));
      expect(doneCalled, isFalse);
    });

    test('addValidator registers a validator into the list', () {
      final fields = FieldsValidator();
      EmptyFullNameValidator(fields);
      EmptyPhoneValidator(fields);
      expect(fields.validators, hasLength(2));
    });
  });

  group('EmptyFullNameValidator', () {
    test('fails on null', () {
      final v = EmptyFullNameValidator(FieldsValidator());
      expect(v.validate(), isFalse);
    });

    test('fails on empty string', () {
      final v = EmptyFullNameValidator(FieldsValidator())..text = '';
      expect(v.validate(), isFalse);
    });

    test('passes on non-empty string', () {
      final v = EmptyFullNameValidator(FieldsValidator())..text = 'Ali';
      expect(v.validate(), isTrue);
    });
  });
}
