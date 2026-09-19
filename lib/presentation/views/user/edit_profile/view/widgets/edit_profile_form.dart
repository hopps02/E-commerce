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
import 'package:store/presentation/res/spacing_manager.dart';

/// The market is Egypt: an account's phone arrives as +20 followed by the
/// local number, and the field shows it beside the Egyptian flag.
const String _countryCode = 'EG';
const String _dialCode = '+20';

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
    // The dial code sits in the picker beside the field, so the text carries
    // only the local part — and the whole number if it ever arrives with
    // another country's code.
    phoneController.text = profile.phone.startsWith(_dialCode)
        ? profile.phone.substring(_dialCode.length)
        : profile.phone;
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
      padding: EdgeInsets.all(SpaceM.s4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpaceM.s6.verticalSpace,

          Text(
            Translation.name.tr,
            style: context.bodyMedium.copyWith(fontWeight: FontWeightM.medium),
          ),
          SpaceM.s2.verticalSpace,
          SimpleForm(
            hintText: Translation.name.tr,
            keyboardType: TextInputType.name,
            controller: nameController,
          ),

          SpaceM.s6.verticalSpace,

          ProfilePhoneField(
            phoneNumberController: phoneController,
            initialCountryCode: _countryCode,
            initialDialCode: _dialCode,
          ),

          SpaceM.s12.verticalSpace,

          CustomInkButton(
            onTap: _save,
            borderRadius: 20.r,
            backgroundColor: ColorM.primary500,
            padding: EdgeInsets.symmetric(vertical: SpaceM.s4.h),
            child: Center(
              child: Text(
                Translation.save.tr,
                style: context.titleMedium.copyWith(
                  color: ColorM.white,
                  fontWeight: FontWeightM.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
