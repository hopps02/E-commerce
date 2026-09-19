import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/app/ui_kit/rate_widget.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

/// The ratings + comment the user submitted from [RateOrderBottomSheet].
class RateOrderResult {
  final double overall;
  final double orderMatch;
  final double deliverySpeed;
  final String comment;

  const RateOrderResult({
    required this.overall,
    required this.orderMatch,
    required this.deliverySpeed,
    required this.comment,
  });
}

/// "How was your experience?" rating sheet shown after an order is delivered.
class RateOrderBottomSheet extends StatefulWidget {
  const RateOrderBottomSheet({super.key});

  /// Returns the submitted [RateOrderResult], or `null` if dismissed.
  static Future<RateOrderResult?> show(BuildContext context) async {
    return showModalBottomSheet<RateOrderResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) => const RateOrderBottomSheet(),
    );
  }

  @override
  State<RateOrderBottomSheet> createState() => _RateOrderBottomSheetState();
}

class _RateOrderBottomSheetState extends State<RateOrderBottomSheet> {
  final TextEditingController _commentController = TextEditingController();

  double _overall = 0;
  double _orderMatch = 0;
  double _deliverySpeed = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: context.bottomViewInsetsMedia),
      decoration: ShapeDecoration(
        color: ColorM.white,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(RadiusM.xl.r),
            topRight: Radius.circular(RadiusM.xl.r),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.symmetric(vertical: SpaceM.s3.h),
            child: Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: ColorM.slate,
                borderRadius: BorderRadius.circular(RadiusM.pill.r),
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(SpaceM.s4, 0, SpaceM.s4, SpaceM.s4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Header(onClose: () => Navigator.of(context).pop()),
                  SpaceM.s3.verticalSpace,
                  Container(height: 1, color: ColorM.gray200),
                  SpaceM.s5.verticalSpace,
                  // Overall rating
                  Text(
                    Translation.share_your_experience.tr,
                    textAlign: TextAlign.center,
                    style: context.titleMedium.copyWith(
                      color: ColorM.gray900,
                      fontWeight: FontWeightM.medium,
                      height: 26 / 18,
                    ),
                  ),
                  SpaceM.s3.verticalSpace,
                  _Stars(
                    size: 38,
                    spacing: SpaceM.s2,
                    onChanged: (v) => setState(() => _overall = v),
                  ),
                  SpaceM.s4.verticalSpace,
                  Container(height: 1, color: ColorM.gray200),
                  SpaceM.s4.verticalSpace,
                  // Aspect ratings
                  _AspectRow(
                    label: Translation.rating_order_match.tr,
                    onChanged: (v) => _orderMatch = v,
                  ),
                  SpaceM.s4.verticalSpace,
                  _AspectRow(
                    label: Translation.rating_delivery_speed.tr,
                    onChanged: (v) => _deliverySpeed = v,
                  ),
                  SpaceM.s4.verticalSpace,
                  // Comment
                  SimpleForm(
                    controller: _commentController,
                    keyboardType: TextInputType.multiline,
                    hintText: Translation.share_experience_hint.tr,
                    maxLines: 4,
                    height: 107,
                    alignment: AlignmentDirectional.topStart,
                    textAlign: TextAlign.start,
                    backgroundColor: ColorM.gray100,
                    borderColor: ColorM.gray200,
                    borderRadius: RadiusM.sm.r,
                    padding: EdgeInsets.all(SpaceM.s3.w),
                    textInputAction: TextInputAction.newline,
                  ),
                ],
              ),
            ),
          ),
          _SendButton(enabled: _overall > 0, onTap: _onSend),
        ],
      ),
    );
  }

  void _onSend() {
    FocusScope.of(context).unfocus();
    // TODO: forward the result to the controller / API.
    Navigator.of(context).pop(
      RateOrderResult(
        overall: _overall,
        orderMatch: _orderMatch,
        deliverySpeed: _deliverySpeed,
        comment: _commentController.text.trim(),
      ),
    );
  }
}

/// Close button (start/left in RTL) + title (end/right in RTL).
class _Header extends StatelessWidget {
  final VoidCallback onClose;
  const _Header({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      // In RTL the first child sits on the right: title right, close left.
      children: [
        Expanded(
          child: Text(
            Translation.how_was_your_experience.tr,
            style: context.titleMedium.copyWith(
              color: ColorM.darkNavy,
              fontWeight: FontWeightM.semiBold,
              height: 1.4,
            ),
          ),
        ),
        CustomInkButton(
          onTap: onClose,
          backgroundColor: ColorM.offWhite,
          customBorderRadius: BorderRadius.circular(RadiusM.pill),
          padding: EdgeInsets.all(SpaceM.s3.w),
          alignment: Alignment.center,
          tap: const ButtonAnimationSettings(
            ButtonAnimation.scaleTap,
            intensity: 0.3,
          ),
          child: Icon(Icons.cancel, size: 21, color: ColorM.red),
        ),
      ],
    );
  }
}

/// One aspect row: label on the right, small stars on the left (RTL aware).
class _AspectRow extends StatelessWidget {
  final String label;
  final ValueChanged<double> onChanged;
  const _AspectRow({required this.label, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: context.labelMedium.copyWith(
              color: ColorM.gray600,
              fontWeight: FontWeightM.medium,
            ),
          ),
        ),
        _Stars(size: 18, spacing: SpaceM.s1, onChanged: onChanged),
      ],
    );
  }
}

/// Star row forced LTR so it always fills left-to-right (matching the design),
/// regardless of the surrounding RTL layout.
class _Stars extends StatelessWidget {
  final double size;
  final double spacing;
  final ValueChanged<double> onChanged;
  const _Stars({
    required this.size,
    required this.spacing,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: RateWidget(
        onRateChange: onChanged,
        size: size,
        spacing: spacing,
        activeColor: ColorM.gold,
        inactiveColor: ColorM.gray300,
        starAsset: Assets.svg.star.path,
        alignment: MainAxisAlignment.center,
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;
  const _SendButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        SpaceM.s4,
        SpaceM.s4,
        SpaceM.s4,
        context.bottomSafeAreaPadding + 16,
      ),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: ColorM.gray300)),
      ),
      child: CustomInkButton(
        enabled: enabled,
        onTap: onTap,
        height: 56,
        width: double.infinity,
        borderRadius: SizeM.commonBorderRadius.r,
        backgroundColor: enabled ? ColorM.orange : ColorM.gray300,
        alignment: Alignment.center,
        tap: const ButtonAnimationSettings(
          ButtonAnimation.scaleTap,
          intensity: 0.2,
        ),
        child: Text(
          Translation.send.tr,
          style: context.bodyLarge.copyWith(
            color: ColorM.white,
            fontWeight: FontWeightM.medium,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
