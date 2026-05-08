import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_form_field/simple_form.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/edit_profile/view/widgets/profile_phone_field.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController nameController = TextEditingController(text: 'Leonardo');
  final TextEditingController phoneController = TextEditingController(text: '799999999');

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.verticalSpace,
          
          Text(
            Translation.name.tr,
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeightM.medium,
            ),
          ),
          8.verticalSpace,
          SimpleForm(
            hintText: Translation.name.tr,
            keyboardType: TextInputType.name,
            controller: nameController,
          ),
          
          24.verticalSpace,
          
          ProfilePhoneField(
            phoneNumberController: phoneController,
            initialCountryCode: 'SA',
            initialDialCode: '+966',
          ),

          48.verticalSpace,

          CustomInkButton(
            onTap: () {
              // Save logic here
              context.pop();
            },
            borderRadius: 20.r,
            backgroundColor: ColorM.primary500,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: Text(
                Translation.save.tr,
                style: context.titleMedium.copyWith(
                  color: ColorM.white,
                  fontWeight: FontWeightM.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
