import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/country_code_button.dart';
import 'package:jar/app/ui_components/custom_form_field/simple_form.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/a_common/general_padding.dart';
import 'package:nice_text_form/nice_text_form.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode phoneNumberFocusNode = FocusNode();
  String dialCode = "+966";
  String countryCode = "SA";

  @override
  void dispose() {
    phoneNumberController.dispose();
    phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                onSelectionChange: (countryCode, dialCode) {
                  setState(() {
                    this.countryCode = countryCode;
                    this.dialCode = dialCode;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final FocusNode phoneNumberFocusNode;
  final Function(String countryCode, String dialCode) onSelectionChange;
  const Content({
    super.key,
    required this.phoneNumberController,
    required this.phoneNumberFocusNode,
    required this.onSelectionChange,
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
          Title(),
          PhoneField(
            phoneNumberController: phoneNumberController,
            phoneNumberFocusNode: phoneNumberFocusNode,
            onSelectionChange: onSelectionChange,
          ),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.svg.appLogo.path,
      width: 63.w,
      height: 140.h,
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Text(
          Translation.login.tr,
          style: context.titleLarge.copyWith(fontWeight: FontWeightM.semiBold),
        ),
        6.verticalSpace,
        Text(
          Translation.enter_mobile_to_continue.tr,
          style: context.bodyMedium.copyWith(
            fontSize: 15.sp,
            color: ColorM.gray500,
          ),
        ),
      ],
    );
  }
}

class PhoneField extends StatelessWidget {
  final Function(String countryCode, String dialCode) onSelectionChange;
  final TextEditingController phoneNumberController;
  final FocusNode phoneNumberFocusNode;
  const PhoneField({
    super.key,
    required this.onSelectionChange,
    required this.phoneNumberController,
    required this.phoneNumberFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleForm(
      hintText: Translation.mobile_number.tr,
      keyboardType: TextInputType.number,
      controller: phoneNumberController,
      focusNode: phoneNumberFocusNode,
      label2: Text(
        Translation.your_mobile_number.tr,
        style: context.labelSmall.copyWith(color: ColorM.gray600),
      ),
      prefixWidget: Row(
        spacing: 5.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          FastCountryCodeButton(
            controller: CountryCodePickerController(
              initialSelection: "SA",
              locale: context.locale,
            ),
            onSelectionChange: (cCode) =>
                onSelectionChange(cCode.countryCode, cCode.dialCode),
          ),

          Row(
            mainAxisSize: .min,
            children: [
              Text(
                "+966",
                style: context.bodyMedium.copyWith(
                  color: ColorM.gray800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Container(width: 1.w, height: 32.w, color: ColorM.gray200),
        ],
      ),
    );
  }
}
