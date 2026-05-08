import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/default_app_bar.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/app/extensions/widget_extensions.dart';

import 'package:jar/app/ui_components/custom_action_tile.dart';
import 'package:jar/app/ui_components/support_contact_card.dart';

class HelpSupportView extends ConsumerWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          DefaultAppBar(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: SizeM.pagePadding.w),
            title: Translation.help_and_support.tr,
          ).premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24.h) + EdgeInsets.only(bottom: context.bottomSafeAreaPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  CustomActionTile(
                    title: 'What do you mean?',
                    onTap: () {},
                    expandedContent: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla.',
                      style: context.bodyMedium.copyWith(color: ColorM.gray600, height: 1.5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w, vertical: 16.h),
                  ).premiumAppear(index: 2),
                  CustomActionTile(
                    title: 'How to become a partner?',
                    onTap: () {},
                    expandedContent: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor.',
                      style: context.bodyMedium.copyWith(color: ColorM.gray600, height: 1.5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w, vertical: 16.h),
                  ).premiumAppear(index: 3),
                  CustomActionTile(
                    title: 'Delivery policy',
                    onTap: () {},
                    expandedContent: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor.',
                      style: context.bodyMedium.copyWith(color: ColorM.gray600, height: 1.5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w, vertical: 16.h),
                  ).premiumAppear(index: 4),
                  CustomActionTile(
                    title: 'Refund Policy',
                    onTap: () {},
                    expandedContent: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor.',
                      style: context.bodyMedium.copyWith(color: ColorM.gray600, height: 1.5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w, vertical: 16.h),
                  ).premiumAppear(index: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
