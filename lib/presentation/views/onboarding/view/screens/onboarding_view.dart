import 'package:flutter/material.dart';
import 'package:jar/app/di/dependency_injection.dart';
import 'package:jar/app/extensions/navigation_extension.dart';
import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/views/onboarding/view/widgets/image_background.dart';
import 'package:jar/presentation/views/onboarding/view/widgets/gradient_background.dart';
import 'package:jar/presentation/views/onboarding/view/widgets/onboarding_content.dart';

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
            onNext: _handleOnboardingComplete,
            onLogin: _handleOnboardingComplete,
          ),
        ],
      ),
    );
  }

  Future<void> _handleOnboardingComplete() async {
    await DI().storageService.setSkippedOnBoarding();
    if(mounted) context.pushNamedAndRemoveUntil(RoutesManager.auth.route, (route) => false);
  }
}



