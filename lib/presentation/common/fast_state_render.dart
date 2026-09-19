import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/indicators/error_widget.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:store/presentation/res/spacing_manager.dart';

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
            width: 100,
            height: 100,
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
        child: GeneralPadding(
          child: Column(
            spacing: SpaceM.s3,
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              emptyChild ??
                  Lottie.asset(
                    Assets.lottieAnimations.empty.path,
                    key: const Key("empty-lottie-fast-render"),
                    width: 200,
                    height: 200,
                    repeat: true,
                    fit: BoxFit.contain,
                  ),

              Text(
                errorMessage.trim().isEmpty
                    ? Translation.no_data_found.tr
                    : errorMessage,
                textAlign: TextAlign.center,
                style: context.labelLarge.copyWith(
                  fontWeight: FontWeightM.bold,
                  color: ColorM.gray600,
                ),
              ),

              if (onRetry != null) ...[
                SpaceM.s3.verticalSpace,
                RetryButton(onRetry: onRetry),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
