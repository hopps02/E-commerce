import 'dart:async';

import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

import 'package:for_u/app/utils/mixins/after_layout.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:for_u/app/config/constants.dart';
import 'package:for_u/app/di/dependency_injection.dart';
import 'package:for_u/app/extensions/guest_gate.dart';
import 'package:for_u/app/services/notification_deep_link.dart';
import 'package:for_u/app/services/session_service.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/router/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with AfterLayout {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorM.primary200, ColorM.gray50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          Assets.svg.appLogo.path,
          width: 155.w,
          colorFilter: ColorFilter.mode(ColorM.primary700, BlendMode.srcIn),
        ).premiumAppear(),
      ),
    );
  }

  @override
  Future<void> afterLayout(BuildContext context) async {
    Timer(Duration(seconds: Constants.splashTimer), () async {
      if (!DI().storageService.isSkippedOnBoarding) {
        context.goNamed(Routes.onboarding);
        return;
      }

      // Stored session is validated against the backend (dead sessions are
      // cleared); offline keeps the stored role so nobody gets locked out.
      final start = await DI().sessionService.resolveStart();
      if (!context.mounted) return;
      switch (start) {
        case StartGuest():
          context.goNamed(Routes.home);
          NotificationDeepLink.consumeColdStart();
        case StartHome(:final role):
          context.goNamed(role.homeRoute);
          // A notification that cold-started the app now lands on its screen,
          // stacked on top of the home the user just reached.
          NotificationDeepLink.consumeColdStart();
        case StartAuth():
          // No stored session — open the storefront as a guest by default;
          // sign-in is prompted later, only when an action needs an account.
          final entered = await enterAsGuest();
          if (!context.mounted) return;
          context.goNamed(entered ? Routes.home : Routes.auth);
          if (entered) NotificationDeepLink.consumeColdStart();
      }
    });
  }
}
