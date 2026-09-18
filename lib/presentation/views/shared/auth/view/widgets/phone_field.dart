import 'package:animated_visibility/animated_visibility.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/country_code_button.dart';
import 'package:store/app/utils/formatters/phone_input_formatter.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/shared/auth/riverpod/sign_up_controller.dart';
import 'package:nice_text_form/nice_text_form.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final FocusNode phoneNumberFocusNode;

  const PhoneField({
    super.key,
    required this.phoneNumberController,
    required this.phoneNumberFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          Translation.mobile_number.tr,
          style: context.bodyMedium.copyWith(fontWeight: FontWeightM.medium),
        ),
        Consumer(
          builder: (context, ref, _) {
            final authState = ref.watch(authController);
            final authNotifier = ref.read(authController.notifier);
            return SimpleForm(
              hintText: Translation.your_mobile_number.tr,
              keyboardType: TextInputType.number,
              controller: phoneNumberController,
              focusNode: phoneNumberFocusNode,
              textDirection: TextDirection.ltr,
              inputFormatters: phoneInputFormatters(authState.countryCode),
              onChanged: authNotifier.onPhoneChanged,
              // Green check appears the moment the number is valid.
              suffixWidget: authState.phoneValid
                  ? (_) => Padding(
                      padding: EdgeInsetsDirectional.only(end: 6.w),
                      child: SvgPicture.asset(
                        Assets.svg.circleCheck.path,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          ColorM.primary500,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : null,
              prefixWidget: Row(
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FastCountryCodeButton(
                    controller: CountryCodePickerController(
                      initialSelection: authState.countryCode,
                      locale: context.locale,
                    ),
                    onSelectionChange: (cCode) {
                      authNotifier.onSelectionChange(
                        cCode.countryCode,
                        cCode.dialCode,
                      );
                    },
                  ),
                  Container(width: 1, height: 32, color: ColorM.gray300),

                  AnimatedVisibility(
                    visible: authState.textActive,
                    enterDuration: Duration(milliseconds: 150),
                    exitDuration: Duration(milliseconds: 150),
                    enter:
                        expandHorizontally(
                          curve: Curves.fastEaseInToSlowEaseOut,
                        ) +
                        fadeIn(curve: Curves.fastEaseInToSlowEaseOut),
                    exit:
                        shrinkHorizontally(
                          curve: Curves.fastEaseInToSlowEaseOut,
                        ) +
                        fadeOut(curve: Curves.fastEaseInToSlowEaseOut),
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        7.horizontalSpace,
                        Column(
                          mainAxisSize: .min,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              Translation.mobile_number.tr,
                              style: context.bodyMedium.copyWith(
                                fontSize: 8,
                                color: ColorM.gray600,
                              ),
                            ),
                            Text(
                              authState.dialCode,
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
                          mainAxisAlignment: .end,
                          children: [
                            Container(
                              width: 1,
                              height: 22,
                              color: ColorM.gray300,
                            ),
                            10.verticalSpace,
                          ],
                        ),
                        3.horizontalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
