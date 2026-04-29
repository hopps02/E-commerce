import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/app/ui_components/gradient_border_side.dart' as gradient_border_side;

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.backFunction,
    this.actionButtons,
    this.customBackButton,
    this.hideBackButton = false,
    this.titleAlignment = Alignment.center,
    this.titleTextAlign = TextAlign.center,
    this.padding,
  });

  final String? title;
  final Widget? titleWidget;
  final VoidCallback? backFunction;
  final List<Widget>? actionButtons;
  final Widget? customBackButton;
  final bool hideBackButton;
  final AlignmentGeometry titleAlignment;
  final TextAlign titleTextAlign;
  final EdgeInsetsGeometry? padding;

  EdgeInsetsGeometry get _defaultPadding =>
      EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg);

  Widget? _buildLeading(BuildContext context) {
    if (hideBackButton) return null;
    if (customBackButton != null) return customBackButton;

    // Determine arrow color based on background
    Color arrowColor =  ColorM.gray700;
    Color backgroundColor =  Colors.transparent;

    return CustomInkButton(
      onTap: backFunction ?? () => Navigator.of(context).maybePop(),
      padding: EdgeInsets.zero,
      width: 38.w,
      height: 38.w,
      smoothness: 0,
      backgroundColor: backgroundColor,
      borderRadius:12.r,
      alignment: Alignment.center,
      side: gradient_border_side.BorderSide(color: ColorM.gray300, width: 1.w),
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: arrowColor,
        size: 20.sp,
      ),
    );
  }

  Widget? _buildTitle(BuildContext context) {
    if (titleWidget == null && (title == null || title!.isEmpty)) {
      return SizedBox.shrink();
    }

    final Widget? resolvedTitle =
        titleWidget ??
        (title == null
            ? null
            : Text(
                title!,
                textAlign: titleTextAlign,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.bodyLarge.copyWith(
                  height: 1,
                  fontWeight: FontWeightM.semiBold,
                ),
              ));

    return resolvedTitle != null
        ? Align(alignment: titleAlignment, child: resolvedTitle)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading(context);
    final title = _buildTitle(context);
    final actions = actionButtons ?? const [];

    return Padding(
      padding: padding ?? _defaultPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 40.w, child: leading),

          if (title != null) title,

          Expanded(
            child: SizedBox(
              child: actions.isEmpty
                  ? null
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions.map((action) => action).toList(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
