import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/custom_scrollbar.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/legal_policies/riverpod/legal_policies_controller.dart';
import 'package:store/presentation/views/user/legal_policies/view/widgets/policy_section.dart';
import 'package:store/presentation/res/spacing_manager.dart';

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
    final sections = ref.watch(legalPoliciesController).sections;
    final arabic = context.locale.languageCode == 'ar';
    return CustomScrollbar(
      controller: scrollController,
      wrapWithScrollView: false,
      thumbColor: ColorM.primary500,
      trackColor: ColorM.gray200,
      thumbRadius: 28.r,
      thumbWidth: 6,
      trackWidth: 4,
      position: context.isLTR ? .right : .left,
      margin: EdgeInsets.only(
        right: SpaceM.s2,
        left: context.isLTR ? 0 : SpaceM.s2,
        top: SpaceM.s4,
        bottom: SpaceM.s4,
      ),
      child: ListView(
        controller: scrollController,
        padding:
            EdgeInsets.symmetric(
              horizontal: SizeM.pagePadding,
              vertical: SizeM.pagePadding,
            ) +
            EdgeInsets.only(bottom: context.bottomSafeAreaPadding),
        children: [
          for (int i = 0; i < sections.length; i++) ...[
            PolicySection(
              title: sections[i].title(arabic),
              description: sections[i].hasBody
                  ? sections[i].body
                  : Translation.legal_content_empty.tr,
              isPlaceholder: !sections[i].hasBody,
            ).premiumAppear(index: 2 + i),
            if (i != sections.length - 1) SpaceM.s8.verticalSpace,
          ],
        ],
      ),
    );
  }
}
