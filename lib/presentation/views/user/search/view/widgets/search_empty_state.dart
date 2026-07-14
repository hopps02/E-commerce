import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: ColorM.gray300),
          16.verticalSpace,
          Text(
            Translation.search_hint.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeightM.semiBold,
              color: ColorM.gray500,
            ),
          ),
        ],
      ),
    );
  }
}
