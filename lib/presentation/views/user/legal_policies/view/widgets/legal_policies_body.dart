import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/custom_scrollbar.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/user/legal_policies/view/widgets/policy_section.dart';

class LegalPoliciesBody extends ConsumerStatefulWidget {
  const LegalPoliciesBody({super.key});

  @override
  ConsumerState<LegalPoliciesBody> createState() => _LegalPoliciesBodyState();
}

class _LegalPoliciesBodyState extends ConsumerState<LegalPoliciesBody> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollbar(
      controller: scrollController,
      wrapWithScrollView: false,
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
        bottom: 16.h,
      ),
      child: ListView(
        controller: scrollController,
        padding:
            EdgeInsets.symmetric(
              horizontal: SizeM.pagePadding.w,
              vertical: SizeM.pagePadding.h,
            ) +
            EdgeInsets.only(bottom: context.bottomSafeAreaPadding),
        children: [
          const PolicySection(
            title: 'Changes to the Service and/or Terms:',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.',
          ).premiumAppear(index: 2),
          32.verticalSpace,
          for (int i = 0; i < 10; i++)
            const PolicySection(
              title: 'Terms',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.',
            ).premiumAppear(index: 5),
        ],
      ),
    );
  }
}
