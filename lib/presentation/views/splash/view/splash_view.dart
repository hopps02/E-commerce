import 'dart:async';

import 'package:jar/app/extensions/navigation_extension.dart';
import 'package:jar/app/ui_components/animations/animated_on_appear.dart';
import 'package:jar/app/ui_components/animations/animations_enum.dart';
import 'package:flutter/material.dart';

import 'package:jar/app/utils/after_layout.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jar/app/config/constants.dart';
import 'package:jar/app/di/dependency_injection.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/routes_manager.dart';

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
        child: AnimatedOnAppear(
          animationTypes: {AnimationType.fade, AnimationType.pulse},
          animationDuration: Duration(seconds: 1),
          child: SvgPicture.asset(
            Assets.svg.appLogo.path,
            width: 63.w,
            height: 140.h,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> afterLayout(BuildContext context) async {
    Timer(Duration(seconds: Constants.splashTimer), () async {
      if (!DI().storageService.isSkippedOnBoarding) {
        context.pushNamedAndRemoveUntil(RoutesManager.onboarding.route, (_) => false);
      } else if (await DI().storageService.isUserRegistered) {
        // Navigator.of(
        //   context,
        // ).pushNamedAndRemoveUntil(RoutesManager.home.route, (_) => false);
      } else {
        if (context.mounted) context.pushNamedAndRemoveUntil(RoutesManager.auth.route, (_) => false);
      }
    });
  }
}
