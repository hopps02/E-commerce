import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/view_extensions.dart';
import 'package:for_u/app/utils/state_render.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/user/user_home/view/widgets/category_grid_item.dart';
import 'package:for_u/presentation/views/user/sections/riverpod/sections_controller.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

class SectionsData extends ConsumerWidget {
  const SectionsData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionsState = ref.watch(sectionsController);
    final sectionsNotifier = ref.read(sectionsController.notifier);
    return Expanded(
      child: FastStateRender(
        reqState: ReqState.success /* sectionsState.reqState */,
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
              EdgeInsets.only(
                top: 16.h,
                bottom: context.bottomPadding + SizeM.pagePadding.w,
              ),
          child: Wrap(
            spacing: 15.w,
            runSpacing: 16.h,
            alignment: WrapAlignment.start,
            children: [
              for (int i = 0; i < 20; i++)
                CategoryGridItem(
                  title: "مواد البقالة",
                  imageUrl: "",
                  onTap: () {},
                ),
            ],
          ),
        ).premiumAppear(),
      ),
    );
  }
}
