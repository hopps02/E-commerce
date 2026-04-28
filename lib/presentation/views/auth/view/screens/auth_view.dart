
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/di/dependency_injection.dart';
import 'package:jar/app/utils/snackbar_helper.dart';
import 'package:jar/app/utils/validator.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/views/a_common/general_padding.dart';
import 'package:jar/presentation/views/auth/riverpod/sign_up_controller.dart';
import 'package:jar/presentation/views/auth/view/widgets/content.dart';
import 'package:jar/presentation/views/auth/view/widgets/logo.dart';
import 'package:jar/presentation/views/auth/view/widgets/otp_bottom_sheet.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FieldsValidator validatorMediator = FieldsValidator();
  late EmptyPhoneValidator emptyPhoneValidator;
  late InvalidPhoneValidator invalidPhoneValidator;

  void onSendOtpCode(String dialCode) {
    emptyPhoneValidator.text = phoneNumberController.text;
    invalidPhoneValidator.text = phoneNumberController.text;
    invalidPhoneValidator.countryCode = dialCode;
    validatorMediator.validate(
      (msg, validator) {
        if (validator is EmptyPhoneValidator) {
          phoneNumberFocusNode.requestFocus();
        } else if (validator is InvalidPhoneValidator) {
          DI().snackBarHelper.showMessage(
            validator.errorMessage,
            ErrorMessage.snackBar,
          );
        }
      },
      () {
        DI().loadingService.show();
        Future.delayed(Duration(seconds: 3), () {
          DI().loadingService.hide();
          OtpBottomSheet.show(
            context,
            mobileNumber: phoneNumberController.text,
          );
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    emptyPhoneValidator = EmptyPhoneValidator(validatorMediator);
    invalidPhoneValidator = InvalidPhoneValidator(validatorMediator);
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
