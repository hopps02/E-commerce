import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/ui_kit/forms/simple_form.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/ui_kit/default_app_bar.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

class SearchBarSection extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onBackTap;

  const SearchBarSection({
    super.key,
    required this.controller,
    this.onChanged,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: 72.h,
      padding: EdgeInsets.symmetric(vertical: 17.h),
      child: DefaultAppBar(
        actionButtons: [
          16.horizontalSpace,
          Expanded(
            child: SimpleForm(
              height: 38.h,
              fontSize: 14.sp,
              borderRadius: 12.r,
              smoothness: 0,
              enableActiveBorder: true,
              borderColor: ColorM.gray300,
              hintText: Translation.search_hint.tr,
              keyboardType: TextInputType.text,
              controller: controller,
              prefixWidget: Assets.svg.search.svg(width: 18.w, height: 18.w),
            ),
          ),
        ],
      ),
    );
  }
}
