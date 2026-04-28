import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

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

  @override
  VerifyOtpState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    return const VerifyOtpState();
  }

  void startTimer() {
    _timer?.cancel();
    state = state.copyWith(seconds: 60, canResend: false);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.seconds > 0) {
        state = state.copyWith(seconds: state.seconds - 1);
      } else {
        _timer?.cancel();
        state = state.copyWith(canResend: true);
      }
    });
  }

  void resendOtp(){
    startTimer();
  }

}

final verifyOtpController =
    NotifierProvider.autoDispose<VerifyOtpNotifier, VerifyOtpState>(
      VerifyOtpNotifier.new,
    );
