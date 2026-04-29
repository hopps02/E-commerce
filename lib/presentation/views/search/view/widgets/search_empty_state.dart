import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/fonts_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64.w,
            color: ColorM.gray300,
          ),
          16.verticalSpace,
          Text(
            Translation.search_hint.tr,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightM.semiBold,
              color: ColorM.gray500,
            ),
          ),
        ],
      ),
    );
  }
}
