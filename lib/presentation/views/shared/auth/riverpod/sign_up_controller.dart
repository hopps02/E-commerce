import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/app/validation/phone_validation.dart';
import 'package:for_u/data/response/auth/auth_response.dart';

class AuthState extends Equatable {
  final String dialCode;
  final String countryCode;
  final bool textActive;

  /// True once the entered number is valid for [dialCode] — drives the field
  /// checkmark and enables the send-code button.
  final bool phoneValid;

  /// The normalized E.164 number when [phoneValid]; null otherwise.
  final String? validatedPhone;

  const AuthState({
    this.countryCode = "SA",
    this.dialCode = "+966",
    this.textActive = false,
    this.phoneValid = false,
    this.validatedPhone,
  });

  AuthState copyWith({
    String? dialCode,
    String? countryCode,
    bool? textActive,
    bool? phoneValid,
    String? validatedPhone,
    bool clearValidated = false,
  }) {
    return AuthState(
      dialCode: dialCode ?? this.dialCode,
      countryCode: countryCode ?? this.countryCode,
      textActive: textActive ?? this.textActive,
      phoneValid: phoneValid ?? this.phoneValid,
      validatedPhone: clearValidated
          ? null
          : (validatedPhone ?? this.validatedPhone),
    );
  }

  @override
  List<Object?> get props => [
    dialCode,
    countryCode,
    textActive,
    phoneValid,
    validatedPhone,
  ];
}

class AuthNotifier extends Notifier<AuthState> {
  /// The latest raw input — lets a country-code switch re-validate and lets a
  /// stale async validation result be discarded.
  String _lastInput = '';

  @override
  AuthState build() => const AuthState();

  void onSelectionChange(String countryCode, String dialCode) {
    state = state.copyWith(countryCode: countryCode, dialCode: dialCode);
    if (_lastInput.isNotEmpty) onPhoneChanged(_lastInput);
  }

  /// Validates the number live as the user types: shows/hides the field
  /// checkmark and the send button's enabled state without waiting for submit.
  Future<void> onPhoneChanged(String value) async {
    final trimmed = value.trim();
    _lastInput = trimmed;

    if (trimmed.isEmpty) {
      state = state.copyWith(
        textActive: false,
        phoneValid: false,
        clearValidated: true,
      );
      return;
    }

    state = state.copyWith(textActive: true);

    final result = await validatePhoneNumber(
      dialCode: state.dialCode,
      number: trimmed,
    );
    // A newer keystroke superseded this validation — drop the stale result.
    if (trimmed != _lastInput) return;

    if (result is ValidPhone) {
      state = state.copyWith(phoneValid: true, validatedPhone: result.e164);
    } else {
      state = state.copyWith(phoneValid: false, clearValidated: true);
    }
  }

  /// Asks the backend to send a login code to [phone] (E.164).
  /// Returns the OTP metadata on success; shows the failure and returns null
  /// otherwise — the caller only opens the OTP sheet on a non-null result.
  Future<OtpRequested?> requestOtp(String phone) async {
    DI().loadingService.show();
    final result = await DI().requestOtpUseCase.execute(phone);
    DI().loadingService.hide();

    return result.fold((failure) {
      DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      );
      return null;
    }, (otp) => otp);
  }
}

final authController = NotifierProvider.autoDispose<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
