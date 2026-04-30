import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/ui_components/error_widget.dart';
import 'package:jar/app/utils/state_render.dart';
import 'package:jar/presentation/common/general_padding.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:lottie/lottie.dart';

class FastStateRender extends StatelessWidget {
  final ReqState reqState;
  final String errorMessage;

  /// Success child widget
  final Widget child;

  /// Idl child widget
  final Widget? idleChild;

  /// Error retry function
  final VoidCallback? onRetry;

  /// loading alignment
  final AlignmentGeometry loadingAlignment;

  /// Error alignment
  final AlignmentGeometry errorAlignment;

  const FastStateRender({
    super.key,
    required this.reqState,
    this.errorMessage = "",
    this.onRetry,
    this.loadingAlignment = Alignment.center,
    this.errorAlignment = Alignment.center,
    this.idleChild,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StateRender(
      reqState: reqState,
      loading: (context) {
        return Align(
          alignment: loadingAlignment,
          child: Lottie.asset(
            Assets.lottieAnimations.sandyLoading.path,
            key: Key("loading-lottie"),
            width: 100.w,
            height: 100.w,
            repeat: true,
            fit: BoxFit.contain,
          ),
        );
      },
      error: (context) => Align(
        alignment: errorAlignment,
        child: GeneralPadding(
          child: MyErrorWidget(titleMessage: errorMessage, onRetry: onRetry),
        ),
      ),
      idle: (context) => idleChild ?? const SizedBox.shrink(),
      success: (context) => child,
    );
    ;
  }
}
