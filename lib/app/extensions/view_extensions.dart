import 'package:flutter/material.dart';

// dart format off
extension ViewExt on BuildContext{
  double get devicePixelRatio       => View.of(this).devicePixelRatio;
  double get screenWidth            => View.of(this).display.size.width / devicePixelRatio;
  double get screenHeight           => View.of(this).display.size.height / devicePixelRatio;
  double get topPadding             => View.of(this).padding.top / devicePixelRatio;
  double get bottomPadding          => View.of(this).padding.bottom / devicePixelRatio;
  double get leftPadding            => View.of(this).padding.left / devicePixelRatio;
  double get rightPadding           => View.of(this).padding.right / devicePixelRatio;
  double get topSafeAreaPadding     => View.of(this).viewPadding.top / devicePixelRatio;
  double get bottomSafeAreaPadding  => View.of(this).viewPadding.bottom / devicePixelRatio;
  double get leftSafeAreaPadding    => View.of(this).viewPadding.left / devicePixelRatio;
  double get rightSafeAreaPadding   => View.of(this).viewPadding.right / devicePixelRatio;
  double get bottomViewInsets       => View.of(this).viewInsets.bottom / devicePixelRatio;
  double get topViewInsets          => View.of(this).viewInsets.top / devicePixelRatio;
  double get leftViewInsets         => View.of(this).viewInsets.left / devicePixelRatio;
  double get rightViewInsets        => View.of(this).viewInsets.right / devicePixelRatio;
  double get textScaleFactor        => View.of(this).platformDispatcher.textScaleFactor;
  TextDirection get textDirection   => Directionality.of(this);
  bool get isRTL                    => textDirection == TextDirection.rtl;
  bool get isLTR                    => textDirection == TextDirection.ltr;
  TextScaler get textScaler         => TextScaler.linear(textScaleFactor);
}
// dart format on
