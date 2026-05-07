import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/navigation_extension.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/delete_account_bottom_sheet.dart';
import 'package:jar/presentation/views/home/view/widgets/profile_menu_item.dart';
import 'package:jar/presentation/res/routes_manager.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: ColorM.gray50,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            ProfileMenuItem(
              icon: Assets.svg.userPen.svg(
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.gray900,
                  BlendMode.srcIn,
                ),
              ),
              title: Translation.edit_profile.tr,
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Assets.svg.language.svg(
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.gray900,
                  BlendMode.srcIn,
                ),
              ),
              title: Translation.languages.tr,
              onTap: () {
                context.pushNamed(RoutesManager.language.route);
              },
            ),
            ProfileMenuItem(
              icon: Assets.svg.headphone.svg(
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.gray900,
                  BlendMode.srcIn,
                ),
              ),
              title: Translation.help_and_support.tr,
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Assets.svg.infoNote.svg(
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  ColorM.gray900,
                  BlendMode.srcIn,
                ),
              ),
              title: Translation.legal_and_policies.tr,
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Assets.svg.deleteAccount.svg(
                width: 20.w,
                height: 20.w,
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
      ),
    );
  }
}
