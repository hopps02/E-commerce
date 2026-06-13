import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/user_home/riverpod/profile_controller.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/delete_account_bottom_sheet.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/profile_menu_item.dart';
import 'package:for_u/presentation/res/router/app_router.dart';

class ProfileSettings extends ConsumerWidget {
  const ProfileSettings({super.key});

  /// Apple-required account deletion: confirm -> server soft delete ->
  /// local teardown -> auth.
  Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
    final confirmed = await DeleteAccountBottomSheet.show(context);
    if (confirmed != true || !context.mounted) return;

    final deleted = await ref.read(profileController.notifier).deleteAccount();
    if (deleted && context.mounted) context.goNamed(Routes.auth);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            icon: Assets.svg.borderHeart.svg(
              width: 22.w,
              height: 22.w,
              colorFilter: const ColorFilter.mode(
                ColorM.primary500,
                BlendMode.srcIn,
              ),
            ),
            title: Translation.favorites.tr,
            onTap: () {
              context.pushNamed(Routes.favorites);
            },
          ),
          ProfileMenuItem(
            icon: Assets.svg.borderLocation.svg(
              width: 22.w,
              height: 22.w,
              colorFilter: const ColorFilter.mode(
                ColorM.primary500,
                BlendMode.srcIn,
              ),
            ),
            title: Translation.addresses.tr,
            onTap: () {
              context.pushNamed(Routes.addresses);
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
              colorFilter: const ColorFilter.mode(ColorM.red, BlendMode.srcIn),
            ),
            title: Translation.delete_account.tr,
            isDestructive: true,
            showArrow: false,
            onTap: () => _deleteAccount(context, ref),
          ),
        ],
      ),
    );
  }
}
