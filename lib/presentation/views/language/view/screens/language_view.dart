import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/config/supported_locales.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/app/ui_components/default_app_bar.dart';
import 'package:jar/app/ui_components/gradient_border_side.dart' as gradient_border;
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Current locale
    final currentLocale = context.locale;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            16.verticalSpace,
            DefaultAppBar(
              title: Translation.languages.tr,
            ),
            32.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  _LanguageItem(
                    title: Translation.english.tr,
                    locale: SupportedLocales.EN.locale,
                    currentLocale: currentLocale,
                    icon: Assets.svg.language.svg(
                      width: 24.w, 
                      height: 24.w,
                      colorFilter: const ColorFilter.mode(ColorM.gray900, BlendMode.srcIn),
                    ),
                  ),
                  16.verticalSpace,
                  _LanguageItem(
                    title: Translation.arabic.tr,
                    locale: SupportedLocales.AR.locale,
                    currentLocale: currentLocale,
                    icon: Assets.svg.language.svg(
                      width: 24.w, 
                      height: 24.w,
                      colorFilter: const ColorFilter.mode(ColorM.gray900, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageItem extends StatelessWidget {
  final String title;
  final Locale locale;
  final Locale currentLocale;
  final Widget icon;

  const _LanguageItem({
    required this.title,
    required this.locale,
    required this.currentLocale,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentLocale.languageCode == locale.languageCode;

    return CustomInkButton(
      onTap: () async {
        if (!isSelected) {
          await context.setLocale(locale);
          if(context.mounted) Phoenix.rebirth(context);
        }
      },
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      backgroundColor: Colors.transparent,
      borderRadius: 16.r,
      side: gradient_border.GradientBorderSide(
        color: isSelected ? ColorM.primary : ColorM.gray200,
        width: 1,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.dg),
            decoration: const BoxDecoration(
              color: ColorM.gray50,
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
          16.horizontalSpace,
          Expanded(
            child: Text(
              title,
              style: context.titleMedium.copyWith(
                fontWeight: FontWeightM.medium,
                color: ColorM.gray900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
