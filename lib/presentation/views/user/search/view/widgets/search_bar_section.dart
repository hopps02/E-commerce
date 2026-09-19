import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

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
      // height: 72,
      padding: EdgeInsets.symmetric(vertical: SpaceM.s4.h),
      child: DefaultAppBar(
        actionButtons: [
          SpaceM.s4.horizontalSpace,
          Expanded(
            child: SimpleForm(
              height: 38,
              fontSize: 14,
              borderRadius: RadiusM.sm.r,
              smoothness: 0,
              enableActiveBorder: true,
              borderColor: ColorM.gray300,
              hintText: Translation.search_hint.tr,
              keyboardType: TextInputType.text,
              controller: controller,
              onChanged: onChanged,
              prefixWidget: Assets.svg.search.svg(width: 18, height: 18.w),
            ),
          ),
        ],
      ),
    );
  }
}
