import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/responsive/responsive_extensions.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/auth_title.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/phone_field.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/sent_otp_button.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

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
      constraints: context.bySize<BoxConstraints?>(
        mobile: null,
        tablet: BoxConstraints(maxWidth: 350.w),
        desktop: BoxConstraints(maxWidth: 350.w),
        largeDesktop: BoxConstraints(maxWidth: 350.w),
      ),
      padding: EdgeInsets.all(SpaceM.s3.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorM.lightPrimary,
        borderRadius: BorderRadius.circular(RadiusM.lg.r),
      ),
      child: Column(
        mainAxisSize: .min,
        spacing: SpaceM.s3,
        children: [
          AuthTitle().premiumAppear(index: 1),
          PhoneField(
            phoneNumberController: phoneNumberController,
            phoneNumberFocusNode: phoneNumberFocusNode,
          ).premiumAppear(index: 2),
          Container(
            height: 1,
            color: ColorM.white,
            width: double.infinity,
          ).premiumAppear(index: 3),
          SentOtpButton(onSendOtpCode: onSendOtpCode).premiumAppear(index: 4),
        ],
      ),
    ).containerSlideUp(delay: 50);
  }
}
