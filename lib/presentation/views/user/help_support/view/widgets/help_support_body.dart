import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';
import 'package:for_u/app/ui_components/custom_action_tile.dart';
import 'package:for_u/app/ui_components/support_contact_card.dart';

class HelpSupportBody extends ConsumerWidget {
  const HelpSupportBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.symmetric(vertical: 24.h) +
          EdgeInsets.only(bottom: context.bottomSafeAreaPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomActionTile(
            title: 'What do you mean?',
            onTap: () {},
            expandedContent: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla.',
              style: context.bodyMedium.copyWith(
                color: ColorM.gray600,
                height: 1.5,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeM.pagePadding.w,
              vertical: 16.h,
            ),
          ).premiumAppear(index: 2),
          CustomActionTile(
            title: 'How to become a partner?',
            onTap: () {},
            expandedContent: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor.',
              style: context.bodyMedium.copyWith(
                color: ColorM.gray600,
                height: 1.5,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeM.pagePadding.w,
              vertical: 16.h,
            ),
          ).premiumAppear(index: 3),
          CustomActionTile(
            title: 'Delivery policy',
            onTap: () {},
            expandedContent: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor.',
              style: context.bodyMedium.copyWith(
                color: ColorM.gray600,
                height: 1.5,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeM.pagePadding.w,
              vertical: 16.h,
            ),
          ).premiumAppear(index: 4),
          CustomActionTile(
            title: 'Refund Policy',
            onTap: () {},
            expandedContent: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor.',
              style: context.bodyMedium.copyWith(
                color: ColorM.gray600,
                height: 1.5,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: SizeM.pagePadding.w,
              vertical: 16.h,
            ),
          ).premiumAppear(index: 5),
        ],
      ),
    );
  }
}
