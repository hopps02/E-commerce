import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/view_extensions.dart';
import 'package:jar/app/utils/state_render.dart';
import 'package:jar/presentation/common/fast_state_render.dart';
import 'package:jar/presentation/res/sizes_manager.dart';
import 'package:jar/presentation/views/home/view/widgets/category_grid_item.dart';
import 'package:jar/presentation/views/sections/riverpod/sections_controller.dart';

class SectionsData extends ConsumerWidget {
  const SectionsData({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionsState = ref.watch(sectionsController);
    final sectionsNotifier = ref.read(sectionsController.notifier);
    return Expanded(
      child: FastStateRender(
        reqState: ReqState.success /* sectionsState.reqState */,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeM.pagePadding.w,
          ) + EdgeInsets.only(top: 16.h , bottom: context.bottomPadding + SizeM.pagePadding.w),
          child: Wrap(
          spacing: 15.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.start,
          children: [
            for(int i =0;i<40;i++) CategoryGridItem(
              title: "مواد البقالة",
              imageUrl:"",
              onTap: () {},
            )
          ],
        ),
        ),
      ),
    );
  }
}
