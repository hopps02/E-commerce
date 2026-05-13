import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/navigation_extension.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/delete_account_bottom_sheet.dart';
import 'package:jar/presentation/views/home/view/widgets/profile_menu_item.dart';
import 'package:jar/presentation/res/router/app_router.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ProfileMenuItem(
            icon: Assets.svg.userPen.svg(
              width: 22.w,
              height: 22.w,
              colorFilter: const ColorFilter.mode(
                ColorM.primary500,
                BlendMode.srcIn,
              ),
            ),
            title: Translation.edit_profile.tr,
            onTap: () {
              context.pushNamed(Routes.editProfile);
            },
          ),
          ProfileMenuItem(
            icon: Assets.svg.language.svg(
              width: 22.w,
              height: 22.w,
              colorFilter: const ColorFilter.mode(
                ColorM.primary500,
                BlendMode.srcIn,
              ),
            ),
            title: Translation.languages.tr,
            onTap: () {
              context.pushNamed(Routes.language);
            },
          ),
          ProfileMenuItem(
            icon: Assets.svg.headphone.svg(
              width: 22.w,
              height: 22.w,
              colorFilter: const ColorFilter.mode(
                ColorM.primary500,
                BlendMode.srcIn,
              ),
            ),
            title: Translation.help_and_support.tr,
            onTap: () {
              context.pushNamed(Routes.helpSupport);
            },
          ),
          ProfileMenuItem(
            icon: Assets.svg.infoNote.svg(
              width: 22.w,
              height: 22.w,
              colorFilter: const ColorFilter.mode(
                ColorM.primary500,
                BlendMode.srcIn,
              ),
            ),
            title: Translation.legal_and_policies.tr,
            onTap: () {
              context.pushNamed(Routes.legalPolicies);
            },
          ),
          ProfileMenuItem(
            icon: Assets.svg.deleteAccount.svg(
              width: 22.w,
              height: 22.w,
              colorFilter: const ColorFilter.mode(
                ColorM.red,
                BlendMode.srcIn,
              ),
            ),
            title: Translation.delete_account.tr,
            isDestructive: true,
            showArrow: false,
            onTap: () {
              DeleteAccountBottomSheet.show(context);
            },
          ),
        ],
      ),
    );
  }
}
