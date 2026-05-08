import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/default_app_bar.dart';
import 'package:jar/app/ui_components/custom_scrollbar.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/app/extensions/widget_extensions.dart';

import 'package:jar/presentation/views/legal_policies/view/widgets/policy_section.dart';

class LegalPoliciesView extends ConsumerWidget {
  const LegalPoliciesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          DefaultAppBar(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: SizeM.pagePadding.w),
            title: Translation.legal_and_policies.tr,
          ).premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          Expanded(
            child: CustomScrollbar(
              // alwaysVisible: true,
              thumbColor: ColorM.primary500,
              trackColor: ColorM.gray200,
              thumbRadius: 28.r,
              thumbWidth: 6.w,
              trackWidth: 4.w,
              position: context.isLTR ? .right : .left,
              margin: EdgeInsets.only(
                right: 8.w,
                left: context.isLTR ? 0 : 8.w,
                top: 16.h,
                bottom: 16.h
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PolicySection(
                      title: 'Changes to the Service and/or Terms:',
                      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.',
                    ).premiumAppear(index: 2),
                    32.verticalSpace,
                    const PolicySection(
                      title: 'Terms',
                      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.',
                    ).premiumAppear(index: 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
