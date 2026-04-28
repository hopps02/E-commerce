import 'package:flutter/material.dart';
import 'package:jar/app/ui_components/animations/animated_on_appear.dart';
import 'package:jar/app/ui_components/animations/animations_enum.dart';

extension PulseAnimation on Widget {
  Widget pluseAnimation(int index, [bool enablePluse = true]) {
    return AnimatedOnAppear(
      delay: 300 + (50 * index),
      animationTypes: enablePluse ? {AnimationType.fade, AnimationType.pulse} : {AnimationType.fade},
      animationDuration: Duration(milliseconds: 700),
      pluseInterval: .65,
      pluseScale: 1.015,
      child: this,
    );
  }
}
