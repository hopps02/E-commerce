import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/views/user/products/view/screens/products_view.dart';
import 'package:store/presentation/views/user/user_home/view/widgets/category_grid_item.dart';
import 'package:store/presentation/views/user/sections/riverpod/sections_controller.dart';
import 'package:store/app/extensions/widget_extensions.dart';

class SectionsData extends ConsumerWidget {
  const SectionsData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionsState = ref.watch(sectionsController);
    final sectionsNotifier = ref.read(sectionsController.notifier);
    final arabic = context.locale.languageCode == 'ar';

    return Expanded(
      child: FastStateRender(
        reqState: sectionsState.reqState,
        errorMessage: sectionsState.errorMessage,
        onRetry: () => sectionsNotifier.load(),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
              EdgeInsets.only(
                top: 16,
                bottom: context.bottomPadding + SizeM.pagePadding,
              ),
          child: Wrap(
            spacing: 15,
            runSpacing: 16,
            alignment: WrapAlignment.start,
            children: [
              for (final category in sectionsState.categories)
                CategoryGridItem(
                  title: category.name(arabic),
                  imageUrl: category.imageUrl ?? "",
                  onTap: () {
                    context.pushNamed(
                      Routes.products,
                      arguments: ProductsViewArgs(
                        title: category.name(arabic),
                        categoryId: category.id,
                      ),
                    );
                  },
                ),
            ],
          ),
        ).premiumAppear(),
      ),
    );
  }
}
