import 'package:flutter/material.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:for_u/presentation/common/role_entry_dialog.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/shared/onboarding/view/widgets/image_background.dart';
import 'package:for_u/presentation/views/shared/onboarding/view/widgets/gradient_background.dart';
import 'package:for_u/presentation/views/shared/onboarding/view/widgets/onboarding_content.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ImageBackground(),
          GradientBackground(),
          OnboardingContent(
            title: Translation.welcome_to_jar.tr,
            description: Translation.onboarding_grocery_desc.tr,
            onNext: _handleOnNext,
            onLogin: _handleOnboardingComplete,
          ),
        ],
      ),
    );
  }

  Future<void> _handleOnboardingComplete() async {
    await DI().storageService.setSkippedOnBoarding();
    if (mounted) context.goNamed(Routes.auth);
  }

  Future<void> _handleOnNext() async {
    await DI().storageService.setSkippedOnBoarding();
    if (!mounted) return;
    final picked = await RoleEntryDialog.show(context);
    if (picked != null && mounted) context.goNamed(picked);
  }
}
