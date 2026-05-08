import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/default_app_bar.dart';
import 'package:jar/app/ui_components/custom_scrollbar.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';

import 'package:jar/presentation/common/fast_state_render.dart';
import 'package:jar/presentation/views/legal_policies/riverpod/legal_policies_controller.dart';
import 'package:jar/presentation/views/legal_policies/view/widgets/legal_policies_app_bar.dart';
import 'package:jar/presentation/views/legal_policies/view/widgets/legal_policies_body.dart';

class LegalPoliciesView extends ConsumerWidget {
  const LegalPoliciesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          const LegalPoliciesAppBar().premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          Expanded(
            child: FastStateRender(
              reqState: ref.watch(legalPoliciesController).reqState,
              onRetry: () {},
              child: const LegalPoliciesBody().containerSlideUp(),
            ),
          ),
        ],
      ),
    );
  }
}
