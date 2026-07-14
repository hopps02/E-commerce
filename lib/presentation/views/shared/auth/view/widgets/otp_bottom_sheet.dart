import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/enums/enums.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/forms/otp_field.dart';
import 'package:store/app/utils/mixins/after_layout.dart';
import 'package:store/data/response/auth/auth_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/shared/auth/riverpod/verify_otp_controller.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/otp.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/resend_otp.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/otp_bottom_sheet_title.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/verify_otp_button.dart';
import 'package:store/presentation/views/shared/auth_success/view/screens/auth_success_view.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart'
    as gradient_border;

class OtpBottomSheet extends ConsumerStatefulWidget {
  final String mobileNumber;
  final OtpRequested otpRequested;
  const OtpBottomSheet({
    super.key,
    required this.mobileNumber,
    required this.otpRequested,
  });

  @override
  ConsumerState<OtpBottomSheet> createState() => _OtpBottomSheetState();

  static Future<void> show(
    BuildContext context, {
    required String mobileNumber,
    required OtpRequested otpRequested,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => OtpBottomSheet(
        mobileNumber: mobileNumber,
        otpRequested: otpRequested,
      ),
    );
  }
}

class _OtpBottomSheetState extends ConsumerState<OtpBottomSheet>
    with AfterLayout {
  String _otp = '';

  void onOtp(String otp) {
    _otp = otp;
  }

  Future<void> onVerifyOtp() async {
    if (_otp.length != otpCodeLength) return;

    final session = await ref.read(verifyOtpController.notifier).verify(_otp);
    if (session == null || !mounted) return;

    if (session.isNew) {
      // Brand-new signup → the welcome screen (it then routes by role).
      context.pushReplacementNamed(
        Routes.authSuccess,
        arguments: const AuthSuccessArgs(successViewType: SuccessViewType.auth),
      );
    } else {
      // Returning user → straight to their home, no welcome screen.
      context.goNamed(session.role?.homeRoute ?? Routes.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(verifyOtpController);
    return Container(
      padding:
          EdgeInsets.all(SizeM.pagePadding.dg) +
          EdgeInsets.only(
            bottom:
                context.bottomViewInsetsMedia + context.bottomSafeAreaPadding,
          ),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OtpBottomSheetTitle(widget: widget),

          16.verticalSpace,

          Otp(onOtp: onOtp),

          16.verticalSpace,

          Container(width: double.infinity, height: 1, color: ColorM.gray300),

          16.verticalSpace,

          ResendOtp(seconds: state.seconds, canResend: state.canResend),

          16.verticalSpace,

          VerifyOtpButton(onTap: onVerifyOtp),
        ],
      ),
    );
  }

  @override
  Future<void> afterLayout(BuildContext context) async {
    ref
        .read(verifyOtpController.notifier)
        .start(widget.mobileNumber, widget.otpRequested.resendAfterSeconds);
  }
}
