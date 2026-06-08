import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/indicators/error_widget.dart';
import 'package:for_u/app/ui_kit/indicators/state_render.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/common/out_of_coverage_body.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:lottie/lottie.dart';

class FastStateRender extends StatelessWidget {
  final ReqState reqState;
  final String errorMessage;

  /// Success child widget
  final Widget child;

  /// Idl child widget
  final Widget? idleChild;

  /// Empty child widget
  final Widget? emptyChild;

  /// Error retry function
  final VoidCallback? onRetry;

  /// When true, the out-of-delivery-coverage UI is shown instead of any other
  /// state. Driven by the selected location, so it can be flipped on from any
  /// screen without touching [reqState].
  final bool isOutOfCoverage;

  /// alignment of loading, error, empty states
  final AlignmentGeometry alignment;

  const FastStateRender({
    super.key,
    required this.reqState,
    this.errorMessage = "",
    this.onRetry,
    this.isOutOfCoverage = false,
    this.alignment = Alignment.center,
    this.idleChild,
    required this.child,
    this.emptyChild,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutOfCoverage) {
      return OutOfCoverageBody(onRetry: onRetry);
    }

    return StateRender(
      reqState: reqState,
      loading: (context) {
        return Align(
          alignment: alignment,
          child: Lottie.asset(
            Assets.lottieAnimations.sandyLoading.path,
            key: const Key("loading-lottie-fast-render"),
            width: 100.w,
            height: 100.w,
            repeat: true,
            fit: BoxFit.contain,
          ),
        ).premiumAppear(index: 2);
      },
      error: (context) => Align(
        alignment: alignment,
        child: GeneralPadding(
          child: MyErrorWidget(titleMessage: errorMessage, onRetry: onRetry),
        ),
      ),
      idle: (context) => idleChild ?? const SizedBox.shrink(),
      success: (context) => child,
      empty: (context) => Align(
        alignment: alignment,
        child: Column(
          spacing: 10.w,
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            emptyChild ??
                Lottie.asset(
                  Assets.lottieAnimations.empty.path,
                  key: const Key("empty-lottie-fast-render"),
                  width: 200.w,
                  height: 200.w,
                  repeat: true,
                  fit: BoxFit.contain,
                ),

            Text(
              errorMessage.trim().isEmpty
                  ? Translation.no_data_found.tr
                  : errorMessage,
              style: context.labelLarge.copyWith(
                fontWeight: FontWeightM.bold,
                color: ColorM.gray600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
