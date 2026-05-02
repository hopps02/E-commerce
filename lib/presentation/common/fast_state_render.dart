import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/error_widget.dart';
import 'package:jar/app/utils/state_render.dart';
import 'package:jar/presentation/common/general_padding.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/translations_manager.dart';
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

  /// alignment of loading, error, empty states
  final AlignmentGeometry alignment;

  const FastStateRender({
    super.key,
    required this.reqState,
    this.errorMessage = "",
    this.onRetry,
    this.alignment = Alignment.center,
    this.idleChild,
    required this.child,
    this.emptyChild,
  });

  @override
  Widget build(BuildContext context) {
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
        );
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
