import 'package:for_u/app/utils/fast_function.dart';
import 'package:for_u/app/validation/phone_number_validator.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

abstract class ValidatorMediator {
  void addValidator(Validator validator);

  void validate(
    void Function(String msg, Validator validator) onInvalid,
    void Function() onDone,
  );
}

abstract class Validator {
  String? _text;
  String get errorMessage;
  String? get text => _text;
  set text(String value) => _text = value;
  final ValidatorMediator validatorMediator;

  Validator(this.validatorMediator);

  bool validate();

  @override
  String toString() => runtimeType.toString();
}

class FieldsValidator implements ValidatorMediator {
  final List<Validator> validators = [];

  @override
  void addValidator(Validator validator) => validators.add(validator);

  @override
  void validate(
    void Function(String msg, Validator validator) onInvalid, [
    void Function()? onDone,
  ]) {
    for (var validator in validators) {
      if (!validator.validate()) {
        onInvalid(validator.errorMessage, validator);
        return;
      }
    }
    onDone?.call();
  }
}

// Check if the full name is empty
class EmptyFullNameValidator extends Validator {
  EmptyFullNameValidator(super.validatorMediator) {
    validatorMediator.addValidator(this);
  }

  @override
  String get errorMessage => "";

  @override
  bool validate() => text != null && text!.isNotEmpty;
}

// Check if the phone number is empty
class EmptyPhoneValidator extends Validator {
  EmptyPhoneValidator(super.validatorMediator) {
    validatorMediator.addValidator(this);
  }

  @override
  String get errorMessage => "";

  @override
  bool validate() => text != null && text!.isNotEmpty;
}

// Check if the phone number is invalid
class InvalidPhoneValidator extends Validator {
  InvalidPhoneValidator(super.validatorMediator) {
    validatorMediator.addValidator(this);
  }

  @override
  String get errorMessage => Translation.error_invalid_number.tr;

  String countryCode = "";

  @override
  bool validate() {
    return CountryUtils.validateFullPhoneNumber(countryCode, text!).isValid;
  }
}
