

import 'package:flutter/material.dart';

extension ViewExt on BuildContext{
  double get devicePixelRatio => View.of(this).devicePixelRatio;
  double get screenWidth => View.of(this).display.size.width / devicePixelRatio;
  double get screenHeight => View.of(this).display.size.height / devicePixelRatio;
  double get topPadding => View.of(this).padding.top / devicePixelRatio;
  double get bottomPadding => View.of(this).padding.bottom / devicePixelRatio;
  double get leftPadding => View.of(this).padding.left / devicePixelRatio;
  double get rightPadding => View.of(this).padding.right / devicePixelRatio;
  double get topSafeAreaPadding => View.of(this).viewPadding.top / devicePixelRatio;
  double get bottomSafeAreaPadding => View.of(this).viewPadding.bottom / devicePixelRatio;
  double get leftSafeAreaPadding => View.of(this).viewPadding.left / devicePixelRatio;
  double get rightSafeAreaPadding => View.of(this).viewPadding.right / devicePixelRatio;
}