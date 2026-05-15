import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/shared/auth/riverpod/verify_otp_controller.dart';

class ResendOtp extends ConsumerWidget {
  final int seconds;
  final bool canResend;
  const ResendOtp({super.key, required this.seconds, required this.canResend});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(verifyOtpController.notifier);
    return Row(
      mainAxisAlignment: .center,
      children: [
        RichText(
          textScaler: context.textScaler,
          text: TextSpan(
            style: context.bodyMedium.copyWith(
              color: ColorM.gray600,
              fontSize: 15.sp,
            ),
            children: [
              TextSpan(text: Translation.resend_code_question.tr),
              TextSpan(
                text: canResend
                    ? ' ${Translation.resend_code_action.tr} '
                    : ' ${Translation.seconds.trNamed({'count': seconds.toString()})} ',
                style: TextStyle(color: ColorM.primary500),
                recognizer: canResend
                    ? (TapGestureRecognizer()
                        ..onTap = () {
                          notifier.resendOtp();
                        })
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
