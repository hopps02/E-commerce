import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/views/auth/view/widgets/auth_title.dart';
import 'package:jar/presentation/views/auth/view/widgets/phone_field.dart';
import 'package:jar/presentation/views/auth/view/widgets/sent_otp_button.dart';

class Content extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final FocusNode phoneNumberFocusNode;
  final VoidCallback onSendOtpCode;
  const Content({
    super.key,
    required this.phoneNumberController,
    required this.phoneNumberFocusNode,
    required this.onSendOtpCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorM.lightPurple,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisSize: .min,
        spacing: 10.h,
        children: [
          AuthTitle(),
          PhoneField(
            phoneNumberController: phoneNumberController,
            phoneNumberFocusNode: phoneNumberFocusNode,
          ).pluseAnimation(2),
          Container(height: 1.w, color: ColorM.white, width: double.infinity,),
          SentOtpButton(onSendOtpCode: onSendOtpCode).pluseAnimation(1)
        ],
      ),
    ).pluseAnimation(0, false);
  }
}
