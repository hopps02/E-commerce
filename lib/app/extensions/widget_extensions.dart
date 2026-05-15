import 'package:flutter/material.dart';
import 'package:for_u/app/ui_components/animations/animated_on_appear.dart';
import 'package:for_u/app/ui_components/animations/animations_enum.dart';

extension PulseAnimation on Widget {
  Widget pluseAnimation(int index, [bool enablePluse = true]) {
    return AnimatedOnAppear(
      delay: 300 + (50 * index),
      animationTypes: enablePluse
          ? {AnimationType.fade, AnimationType.pulse}
          : {AnimationType.fade},
      animationDuration: Duration(milliseconds: 700),
      pluseInterval: .65,
      pluseScale: 1.015,
      child: this,
    );
  }
}

extension PremiumAppearAnimation on Widget {
  Widget premiumAppear({int index = 0, int baseDelay = 100}) {
    return AnimatedOnAppear(
      delay: baseDelay + (index * 80),
      slideDistance: 30.0,
      slideDirection: SlideDirection.up,
      animationDuration: const Duration(milliseconds: 700),
      animationCurve: Curves.easeOutCubic,
      animationTypes: const {
        AnimationType.slide,
        AnimationType.fade,
        AnimationType.scale,
      },
      scaleSize: 0.96, // Just a tiny bit smaller to pop up smoothly
      child: this,
    );
  }
}

extension ContainerSlideAnimation on Widget {
  Widget containerSlideUp({int delay = 0, double slideDistance = 60.0}) {
    return AnimatedOnAppear(
      delay: delay,
      slideDistance: slideDistance,
      slideDirection: SlideDirection.up,
      animationDuration: const Duration(milliseconds: 700),
      animationCurve: Curves.easeOutQuart,
      animationTypes: const {AnimationType.slide, AnimationType.fade},
      child: this,
    );
  }
}
