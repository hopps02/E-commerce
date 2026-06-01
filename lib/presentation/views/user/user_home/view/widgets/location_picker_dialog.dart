import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

class LocationPickerDialog extends StatefulWidget {
  final Future<bool> Function()? onEnablePressed;
  final VoidCallback? onDismiss;
  final bool isUpdating;

  const LocationPickerDialog({
    super.key,
    this.onEnablePressed,
    this.onDismiss,
    this.isUpdating = false,
  });

  static Future<void> show(
    BuildContext context, {
    Future<bool> Function()? onEnablePressed,
    VoidCallback? onDismiss,
    bool isUpdating = false,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) => LocationPickerContent(
        onEnablePressed: onEnablePressed,
        onDismiss: onDismiss,
        isUpdating: isUpdating,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<LocationPickerDialog> createState() => _LocationPickerDialogState();
}

class _LocationPickerDialogState extends State<LocationPickerDialog> {
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class LocationPickerContent extends StatefulWidget {
  final Future<bool> Function()? onEnablePressed;
  final VoidCallback? onDismiss;
  final bool isUpdating;

  const LocationPickerContent({
    super.key,
    this.onEnablePressed,
    this.onDismiss,
    this.isUpdating = false,
  });

  @override
  State<LocationPickerContent> createState() => _LocationPickerContentState();
}

class _LocationPickerContentState extends State<LocationPickerContent> {
  bool isLoadingLocation = false;
  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && !isSuccess) {
          widget.onDismiss?.call();
        }
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: SmoothClipRRect(
            smoothness: 1,
            borderRadius: BorderRadius.circular(32.r),
            child: Material(
              color: ColorM.white,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                decoration: BoxDecoration(
                  color: ColorM.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Lottie Globe Animation
                    Container(
                      width: 160.w,
                      height: 160.w,
                      decoration: BoxDecoration(
                        color: ColorM.primary500.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Assets.lottieAnimations.globe.lottie(
                        fit: BoxFit.contain,
                      ),
                    ),
                    24.verticalSpace,
                    Text(
                      widget.isUpdating
                          ? Translation.update_location_title.tr
                          : Translation.enable_locations_title.tr,
                      style: context.headlineSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorM.gray900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    16.verticalSpace,
                    Text(
                      widget.isUpdating
                          ? Translation.update_location_subtitle.tr
                          : Translation.enable_locations_subtitle.tr,
                      style: context.bodyMedium.copyWith(
                        color: ColorM.gray600,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    32.verticalSpace,
                    CustomInkButton(
                      onTap: isLoadingLocation
                          ? null
                          : () async {
                              setState(() => isLoadingLocation = true);
                              bool success =
                                  await (widget.onEnablePressed?.call() ??
                                      Future.value(false));
                              if (success) {
                                isSuccess = true;
                                if (context.mounted) context.pop();
                              } else if (context.mounted) {
                                setState(() => isLoadingLocation = false);
                              }
                            },
                      width: double.infinity,
                      height: 54.h,
                      borderRadius: 16.r,
                      alignment: Alignment.center,
                      backgroundColor: isLoadingLocation
                          ? ColorM.gray200
                          : ColorM.primary500,
                      child: isLoadingLocation
                          ? SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: ColorM.primary400,
                              ),
                            )
                          : Text(
                              Translation.continue_location.tr,
                              style: context.titleMedium.copyWith(
                                color: ColorM.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
