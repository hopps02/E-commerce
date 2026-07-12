import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/edit_profile/view/widgets/profile_phone_field.dart';
import 'package:store/presentation/views/user/user_home/riverpod/profile_controller.dart';

class EditProfileForm extends ConsumerStatefulWidget {
  const EditProfileForm({super.key});

  @override
  ConsumerState<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<EditProfileForm> {
  final TextEditingController nameController = TextEditingController();

  /// The phone is the account's identity — it cannot be edited here; the
  /// field shows the current number.
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileController);
    nameController.text = profile.name;
    phoneController.text = profile.phone.replaceFirst('+966', '');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = nameController.text.trim();
    if (name.isEmpty) return;

    final saved = await ref.read(profileController.notifier).updateName(name);
    if (saved && mounted) context.pop();
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
            style: context.bodyMedium.copyWith(fontWeight: FontWeightM.medium),
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
            onTap: _save,
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
