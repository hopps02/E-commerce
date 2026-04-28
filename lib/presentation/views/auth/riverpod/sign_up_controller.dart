// import 'package:cliniva/app/common/utils/state_render.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SignUpState {
//   final ReqState reqState;

//   const SignUpState({this.reqState = ReqState.idle});

//   SignUpState copyWith({ReqState? reqState}) {
//     return SignUpState(reqState: reqState ?? this.reqState);
//   }
// }

// class SignUpNotifier extends Notifier<SignUpState> {
//   @override
//   SignUpState build() => const SignUpState();
// }

// final signUpController =
//     NotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
//         SignUpNotifier.new);
