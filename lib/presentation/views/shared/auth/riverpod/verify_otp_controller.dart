import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/failure_display_extension.dart';
import 'package:for_u/app/utils/snackbar_helper.dart';
import 'package:for_u/data/models/auth/auth_models.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class VerifyOtpState extends Equatable {
  final int seconds;
  final bool canResend;
  const VerifyOtpState({this.seconds = 60, this.canResend = false});

  VerifyOtpState copyWith({int? seconds, bool? canResend}) {
    return VerifyOtpState(
      seconds: seconds ?? this.seconds,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object?> get props => [seconds, canResend];
}

class VerifyOtpNotifier extends Notifier<VerifyOtpState> {
  Timer? _timer;
  String _phone = '';

  @override
  VerifyOtpState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    return const VerifyOtpState();
  }

  /// Binds the sheet to the phone being verified and starts the resend
  /// countdown from the backend's cooldown, not a hardcoded one.
  void start(String phone, int resendAfterSeconds) {
    _phone = phone;
    _startTimer(resendAfterSeconds);
  }

  /// Verifies [code] and establishes the session. Returns the session on
  /// success; shows the failure (wrong code, expired, suspended account…)
  /// and returns null otherwise.
  Future<AuthSession?> verify(String code) async {
    DI().loadingService.show();
    final result = await DI().verifyOtpUseCase.execute((
      phone: _phone,
      code: code,
    ));
    DI().loadingService.hide();

    return result.fold(
      (failure) {
        DI().snackBarHelper.showMessage(
          failure.displayMessage,
          ErrorMessage.snackBar,
        );
        return null;
      },
      (session) async {
        final established = await DI().sessionService.establish(session);
        if (!established) {
          DI().snackBarHelper.showMessage(
            session.blocked
                ? Translation.error_account_suspended.tr
                : Translation.error_generic.tr,
            ErrorMessage.snackBar,
          );
          return null;
        }
        return session;
      },
    );
  }

  /// Requests a fresh code for the bound phone and restarts the countdown.
  Future<void> resendOtp() async {
    final result = await DI().requestOtpUseCase.execute(_phone);
    result.fold(
      (failure) => DI().snackBarHelper.showMessage(
        failure.displayMessage,
        ErrorMessage.snackBar,
      ),
      (otp) => _startTimer(otp.resendAfterSeconds),
    );
  }

  void _startTimer(int seconds) {
    _timer?.cancel();
    state = state.copyWith(seconds: seconds, canResend: false);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.seconds > 0) {
        state = state.copyWith(seconds: state.seconds - 1);
      } else {
        _timer?.cancel();
        state = state.copyWith(canResend: true);
      }
    });
  }
}

final verifyOtpController =
    NotifierProvider.autoDispose<VerifyOtpNotifier, VerifyOtpState>(
      VerifyOtpNotifier.new,
    );
