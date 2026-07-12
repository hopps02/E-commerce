import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/config/supported_locales.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

/// App language picker bottom sheet, shared across roles (cashier, captain, …).
class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  static Future<void> show(BuildContext context) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) => const LanguageBottomSheet(),
    );
  }

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  Locale? _selected;

  @override
  Widget build(BuildContext context) {
    _selected ??= context.locale;

    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.all(24.w) +
          EdgeInsets.only(bottom: context.bottomSafeAreaPadding),
      decoration: ShapeDecoration(
        color: ColorM.white,
        shape: SmoothRectangleBorder(
          smoothness: 1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36.r),
            topRight: Radius.circular(36.r),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          12.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              Translation.language.tr,
              style: context.titleMedium.copyWith(
                fontWeight: FontWeightM.medium,
                color: const Color(0xFF2B2E48),
                fontSize: 20.sp,
              ),
            ),
          ),
          12.verticalSpace,
          _LanguageRow(
            label: Translation.arabic.tr,
            isSelected:
                _selected?.languageCode ==
                SupportedLocales.AR.locale.languageCode,
            onTap: () => setState(() => _selected = SupportedLocales.AR.locale),
          ),
          4.verticalSpace,
          _LanguageRow(
            label: Translation.english.tr,
            isSelected:
                _selected?.languageCode ==
                SupportedLocales.EN.locale.languageCode,
            onTap: () => setState(() => _selected = SupportedLocales.EN.locale),
          ),
          12.verticalSpace,
          Container(height: 1.h, color: ColorM.gray200),
          12.verticalSpace,
          CustomInkButton(
            onTap: _onConfirm,
            height: 48.h,
            width: double.infinity,
            borderRadius: SizeM.commonBorderRadius.r,
            backgroundColor: ColorM.primary500,
            alignment: Alignment.center,
            tap: const ButtonAnimationSettings(
              ButtonAnimation.scaleTap,
              intensity: 0.2,
            ),
            child: Text(
              Translation.confirm.tr,
              style: context.bodyLarge.copyWith(
                color: ColorM.white,
                fontWeight: FontWeightM.medium,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onConfirm() async {
    final selected = _selected;
    final navigator = Navigator.of(context);
    if (selected != null && selected != context.locale) {
      await context.setLocale(selected);
    }
    if (navigator.canPop()) navigator.pop();
  }
}

class _LanguageRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageRow({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: context.bodyLarge.copyWith(
                fontWeight: FontWeightM.medium,
                color: const Color(0xFF161216),
                height: 20 / 16,
              ),
            ),
            _RadioDot(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool isSelected;
  const _RadioDot({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? ColorM.primary500 : Colors.transparent,
        border: Border.all(
          color: isSelected ? ColorM.primary500 : ColorM.gray300,
          width: 2.w,
        ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? Icon(Icons.check_rounded, color: ColorM.white, size: 14.sp)
          : null,
    );
  }
}
