import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String dialCode;
  final String countryCode;
  final bool textActive;
  const AuthState({this.countryCode = "SA", this.dialCode = "+966", this.textActive = false});

  AuthState copyWith({String? dialCode, String? countryCode, bool? textActive}) {
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
}

final authController =
    NotifierProvider.autoDispose<AuthNotifier, AuthState>(AuthNotifier.new);
