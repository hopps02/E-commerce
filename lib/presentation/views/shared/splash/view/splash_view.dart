import 'dart:async';

import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

import 'package:store/app/utils/mixins/after_layout.dart';
import 'package:store/presentation/res/color_manager.dart';

import 'package:store/app/config/constants.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/services/session_service.dart';
import 'package:store/presentation/views/shared/auth/view/widgets/logo.dart';
import 'package:store/presentation/res/router/app_router.dart';

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
        child: const Logo(),
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
        case StartHome(:final role):
          context.goNamed(role.homeRoute);
        case StartAuth():
          // No stored session — open the storefront as a guest by default;
          // sign-in is prompted later, only when an action needs an account.
          final entered = await enterAsGuest();
          if (!context.mounted) return;
          context.goNamed(entered ? Routes.home : Routes.auth);
      }
    });
  }
}
