import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/utils/logger/app_logger.dart';
import 'package:for_u/app/validation/validate_phone_field.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/views/shared/auth/riverpod/sign_up_controller.dart';
import 'package:for_u/presentation/views/shared/auth/view/widgets/content.dart';
import 'package:for_u/presentation/views/shared/auth/view/widgets/logo.dart';
import 'package:for_u/presentation/views/shared/auth/view/widgets/otp_bottom_sheet.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode phoneNumberFocusNode = FocusNode();

  Future<void> onSendOtpCode(String dialCode) async {
    final phone = await validatePhoneField(
      dialCode: dialCode,
      number: phoneNumberController.text,
      focusNode: phoneNumberFocusNode,
    );
    if (phone != null) await _sendOtp(phone);
  }

  Future<void> _sendOtp(String phone) async {
    final otp = await ref.read(authController.notifier).requestOtp(phone);
    if (otp != null && mounted) {
      OtpBottomSheet.show(context, mobileNumber: phone, otpRequested: otp);
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authController);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorM.primary200, ColorM.gray50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.center,
          child: GeneralPadding(
            child: Column(
              children: [
                119.verticalSpace,
                Logo(),
                76.verticalSpace,
                Content(
                  phoneNumberController: phoneNumberController,
                  phoneNumberFocusNode: phoneNumberFocusNode,
                  onSendOtpCode: () => onSendOtpCode(authState.dialCode),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
