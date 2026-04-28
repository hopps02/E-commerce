import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/app/ui_components/gradient_border_side.dart'
    as gradient_border;
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

import 'custom_form_field.dart';

class SimpleForm extends StatelessWidget {
  final TextEditingController controller;
  final SecurityController? securityController;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String? Function(String)? validator;
  final Widget Function(bool)? suffixWidget;
  final Widget? prefixWidget;
  final bool? obscureText;
  final Widget? label;
  final int? textLength;
  final double? height;
  final bool outlineBorder;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Future<Widget?> Function(String, void Function() hide)?
  searchResultsBuilder;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final TextStyle? hintStyle;
  final double? fontSize;
  final int maxLines;
  final AlignmentDirectional alignment;
  final double? borderRadius;
  final bool removeBorders;
  final bool removeShadow;
  final Color? unFocusedBorderColor;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final double smoothness;
  final bool enableCustomValidation;
  final List<Function(String)?>? customValidators;
  final bool enableActiveBorder;

  final Widget? label2;
  final TextStyle? label2Style;
  final TextAlign textAlign;

  const SimpleForm({
    super.key,
    this.securityController,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.height,
    this.focusNode,
    this.validator,
    this.suffixWidget,
    this.obscureText,
    this.prefixWidget,
    this.textLength,
    this.hintStyle,
    this.label,
    this.backgroundColor,
    this.padding,
    this.outlineBorder = true,
    this.searchResultsBuilder,
    this.onFieldSubmitted,
    this.textInputAction,
    this.fontSize,
    this.maxLines = 1,
    this.alignment = AlignmentDirectional.center,
    this.onChanged,
    this.borderRadius,
    this.removeBorders = false,
    this.removeShadow = true,
    this.unFocusedBorderColor,
    this.readOnly = false,
    this.inputFormatters,
    this.smoothness = 1,
    this.enableCustomValidation = false,
    this.customValidators,
    this.label2,
    this.label2Style,
    this.enableActiveBorder = false,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return NiceTextForm(
      key: super.key,
      alignment: alignment,
      maxLines: maxLines,
      enableCustomValidation: enableCustomValidation,
      customValidators: customValidators,
      label2: label2,
      textAlign: textAlign,
      label2Style: label2Style,
      prefixWidget: prefixWidget,
      height: height ?? 52.h,
      width: double.infinity,
      textLength: textLength,
      controller: securityController,
      searchResultsBuilder: searchResultsBuilder,
      onTextChanged: onChanged,
      inputFormatters: inputFormatters,
      validatorStyle: context.labelSmall.copyWith(
        color: Colors.red,
        fontSize: 9.sp,
        fontWeight: FontWeightM.medium,
      ),
      boxDecoration: ShapeDecoration(
        color:
            backgroundColor ??
             ColorM.white,
        shape: SmoothRectangleBorder(
          smoothness: smoothness,
          borderRadius: BorderRadius.circular(
            borderRadius ?? SizeM.commonBorderRadius.r,
          ),
          side: BorderSide(
            color: ColorM.gray100,
            width: 1.w,
          ),
        ),
      ),
      activeBoxDecoration: enableActiveBorder ? 
      ShapeDecoration(
        color:
            backgroundColor ??ColorM.white,
        shape: gradient_border.SmoothRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? SizeM.commonBorderRadius.r,
          ),
          smoothness: smoothness,
          side: gradient_border.BorderSide(
            color: ColorM.primary,
            width: 1.w,
          ),
        ),
      ) : null,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      isPhoneForm: false,
      obscureText: obscureText,
      focusNode: focusNode,
      label: label,
      keyboardType: keyboardType,
      hintText: hintText,
      validator: validator,
      textStyle: context.labelLarge.copyWith(
        fontSize: fontSize ?? context.labelMedium.fontSize!,
      ),
      hintStyle:
          hintStyle ??
          context.labelLarge.copyWith(
            color: ColorM.gray600,
            fontSize: fontSize ?? context.labelSmall.fontSize!,
          ),
      textEditingController: controller,
      sufixWidget: suffixWidget,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: readOnly,
    );
  }
}
