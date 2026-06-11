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
        case StartHome(:final role):
          context.goNamed(role.homeRoute);
        case StartAuth():
          context.goNamed(Routes.auth);
      }
    });
  }
}
