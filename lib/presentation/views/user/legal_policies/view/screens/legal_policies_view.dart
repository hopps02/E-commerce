import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/views/user/legal_policies/riverpod/legal_policies_controller.dart';
import 'package:store/presentation/views/user/legal_policies/view/widgets/legal_policies_app_bar.dart';
import 'package:store/presentation/views/user/legal_policies/view/widgets/legal_policies_body.dart';

class LegalPoliciesView extends ConsumerWidget {
  const LegalPoliciesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ResponsiveConstrained(
        maxWidth: 600,
        child: Column(
          children: [
            SizedBox(height: context.topSafeAreaPadding),
            const LegalPoliciesAppBar().premiumAppear(index: 0),
            Container(
              height: 6.h,
              color: ColorM.gray150,
            ).premiumAppear(index: 1),
            Expanded(
              child: FastStateRender(
                reqState: ref.watch(legalPoliciesController).reqState,
                errorMessage: ref.watch(legalPoliciesController).errorMessage,
                onRetry: ref.read(legalPoliciesController.notifier).retry,
                child: const LegalPoliciesBody().containerSlideUp(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
