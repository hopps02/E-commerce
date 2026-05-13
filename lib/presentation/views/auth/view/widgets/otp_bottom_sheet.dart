import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/enums/enums.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/app/ui_components/otp_field.dart';
import 'package:jar/app/utils/after_layout.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/router/app_router.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/auth/riverpod/verify_otp_controller.dart';
import 'package:jar/presentation/views/auth/view/widgets/otp.dart';
import 'package:jar/presentation/views/auth/view/widgets/resend_otp.dart';
import 'package:jar/presentation/views/auth/view/widgets/otp_bottom_sheet_title.dart';
import 'package:jar/presentation/views/auth/view/widgets/verify_otp_button.dart';
import 'package:jar/presentation/views/auth_success/view/screens/auth_success_view.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:jar/app/ui_components/gradient_border_side.dart'
    as gradient_border;

class OtpBottomSheet extends ConsumerStatefulWidget {
  final String mobileNumber;
  const OtpBottomSheet({super.key, required this.mobileNumber});

  @override
  ConsumerState<OtpBottomSheet> createState() => _OtpBottomSheetState();

  static Future<void> show(
    BuildContext context, {
    required String mobileNumber,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => OtpBottomSheet(mobileNumber: mobileNumber),
    );
  }
}

class _OtpBottomSheetState extends ConsumerState<OtpBottomSheet>
    with AfterLayout {
  String _otp = '';

  void onOtp(String otp) {
    _otp = otp;
  }

  void onVerifyOtp() {
    if (_otp.length == 5) {
      context.pushReplacementNamed(
        Routes.authSuccess,
        arguments: const AuthSuccessArgs(successViewType: SuccessViewType.auth),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(verifyOtpController);
    return Container(
      padding:
          EdgeInsets.all(SizeM.pagePadding.dg) +
          EdgeInsets.only(
            bottom: context.bottomViewInsets + context.bottomSafeAreaPadding,
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

          Container(width: double.infinity, height: 1.h, color: ColorM.gray300),

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
    ref.read(verifyOtpController.notifier).startTimer();
  }
}
