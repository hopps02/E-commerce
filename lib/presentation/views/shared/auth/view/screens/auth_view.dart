import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/extensions/navigation_extension.dart';
import 'package:store/app/validation/validate_phone_field.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/views/shared/auth/riverpod/sign_up_controller.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/content.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/logo.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/otp_bottom_sheet.dart';

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

  /// Closing the login screen returns to guest browsing. Re-establish a guest
  /// session first so the home never lands on a dead session and bounces back
  /// here — that produced an auth↔home loop when the old session was gone.
  Future<void> _returnToBrowsing() async {
    await enterAsGuest();
    if (mounted) context.goNamed(Routes.home);
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
          // Reached on demand from a guest gate — let the user return to
          // browsing without signing in.
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: IconButton(
                  onPressed: _returnToBrowsing,
                  icon: Icon(
                    Icons.close_rounded,
                    color: ColorM.primary700,
                    size: 28.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
