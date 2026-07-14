import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';

/// Confirms — before any backend call — that the cashier wants to mark an item
/// unavailable. Removal is not reversible server-side, so this sheet is the
/// gate: it resolves with the (optional) reason on confirm, or null on dismiss.
class MarkUnavailableBottomSheet extends StatefulWidget {
  final String itemName;
  const MarkUnavailableBottomSheet({super.key, required this.itemName});

  /// Returns the reason string (possibly empty) when confirmed, or null when
  /// the cashier backs out without confirming.
  static Future<String?> show(
    BuildContext context, {
    required String itemName,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.32),
      useSafeArea: true,
      builder: (_) => MarkUnavailableBottomSheet(itemName: itemName),
    );
  }

  @override
  State<MarkUnavailableBottomSheet> createState() =>
      _MarkUnavailableBottomSheetState();
}

class _MarkUnavailableBottomSheetState
    extends State<MarkUnavailableBottomSheet> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: context.bottomViewInsetsMedia, top: 10.h),
      decoration: BoxDecoration(
        color: ColorM.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36.r),
          topRight: Radius.circular(36.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
            20.verticalSpace,
            Text(
              Translation.mark_unavailable_title.tr,
              style: context.titleMedium.copyWith(
                color: ColorM.gray900,
                fontWeight: FontWeightM.bold,
              ),
            ),
            8.verticalSpace,
            Text(
              Translation.mark_unavailable_message.trNamed({
                'name': widget.itemName,
              }),
              style: context.bodyMedium.copyWith(
                color: ColorM.gray600,
                height: 1.5,
              ),
            ),
            16.verticalSpace,
            SimpleForm(
              height: 48,
              fontSize: 14,
              borderRadius: 16.r,
              borderColor: ColorM.gray250,
              hintText: Translation.mark_unavailable_reason_hint.tr,
              keyboardType: TextInputType.text,
              controller: _reasonController,
            ),
            24.verticalSpace,
            CustomInkButton(
              onTap: () =>
                  Navigator.of(context).pop(_reasonController.text.trim()),
              height: 56,
              width: double.infinity,
              borderRadius: SizeM.commonBorderRadius.r,
              backgroundColor: const Color(0xFFDC2626),
              alignment: Alignment.center,
              child: Text(
                Translation.mark_unavailable_confirm.tr,
                style: context.bodyLarge.copyWith(
                  color: ColorM.white,
                  fontWeight: FontWeightM.medium,
                  height: 1.5,
                ),
              ),
            ),
            12.verticalSpace,
            CustomInkButton(
              onTap: () => Navigator.of(context).maybePop(),
              height: 56,
              width: double.infinity,
              borderRadius: SizeM.commonBorderRadius.r,
              backgroundColor: ColorM.gray50,
              alignment: Alignment.center,
              child: Text(
                Translation.cancel.tr,
                style: context.bodyLarge.copyWith(
                  color: ColorM.gray900,
                  fontWeight: FontWeightM.medium,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
