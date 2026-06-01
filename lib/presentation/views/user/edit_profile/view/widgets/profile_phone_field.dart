import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/country_code_button.dart';
import 'package:for_u/app/ui_kit/forms/simple_form.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:nice_text_form/nice_text_form.dart';

class ProfilePhoneField extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final String initialCountryCode;
  final String initialDialCode;

  const ProfilePhoneField({
    super.key,
    required this.phoneNumberController,
    required this.initialCountryCode,
    required this.initialDialCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          Translation.mobile_number.tr,
          style: context.bodyMedium.copyWith(fontWeight: FontWeightM.medium),
        ),
        SimpleForm(
          hintText: Translation.your_mobile_number.tr,
          keyboardType: TextInputType.phone,
          controller: phoneNumberController,
          readOnly: true,
          backgroundColor: ColorM.gray50,
          prefixWidget: IgnorePointer(
            ignoring: true,
            child: Row(
              spacing: 5.w,
              mainAxisSize: MainAxisSize.min,
              children: [
                FastCountryCodeButton(
                  controller: CountryCodePickerController(
                    initialSelection: initialCountryCode,
                    locale: context.locale,
                  ),
                  onSelectionChange: (cCode) {},
                ),
                Container(width: 1.w, height: 32.w, color: ColorM.gray300),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    7.horizontalSpace,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Translation.mobile_number.tr,
                          style: context.bodyMedium.copyWith(
                            fontSize: 8.sp,
                            color: ColorM.gray600,
                          ),
                        ),
                        Text(
                          initialDialCode,
                          textDirection: TextDirection.ltr,
                          style: context.bodyMedium.copyWith(
                            color: ColorM.gray800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    3.horizontalSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 1.w,
                          height: 22.w,
                          color: ColorM.gray300,
                        ),
                        10.verticalSpace,
                      ],
                    ),
                    3.horizontalSpace,
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
