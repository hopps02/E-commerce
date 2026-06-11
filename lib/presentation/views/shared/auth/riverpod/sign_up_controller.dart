import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/models/auth/auth_models.dart';

class AuthState extends Equatable {
  final String dialCode;
  final String countryCode;
  final bool textActive;
  const AuthState({
    this.countryCode = "SA",
    this.dialCode = "+966",
    this.textActive = false,
  });

  AuthState copyWith({
    String? dialCode,
    String? countryCode,
    bool? textActive,
  }) {
    return AuthState(
      dialCode: dialCode ?? this.dialCode,
      countryCode: countryCode ?? this.countryCode,
      textActive: textActive ?? this.textActive,
    );
  }

  @override
  List<Object?> get props => [dialCode, countryCode, textActive];
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  void onSelectionChange(String countryCode, String dialCode) {
    state = state.copyWith(countryCode: countryCode, dialCode: dialCode);
  }

  void onTextFieldChanged(bool textActive) {
    state = state.copyWith(textActive: textActive);
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
