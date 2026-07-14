import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/sections/riverpod/sections_controller.dart';
import 'package:store/presentation/views/user/sections/view/widgets/app_bar.dart';
import 'package:store/presentation/views/user/sections/view/widgets/sections_data.dart';
import 'package:store/app/extensions/widget_extensions.dart';

class SectionsView extends ConsumerStatefulWidget {
  const SectionsView({super.key});

  @override
  ConsumerState<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends ConsumerState<SectionsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(sectionsController.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveConstrained(
        maxWidth: 600,
        child: Column(
          children: [
            SizedBox(height: context.topSafeAreaPadding),
            TopAppBar(title: Translation.categories.tr).premiumAppear(index: 0),
            Container(
              height: 6.h,
              color: ColorM.gray150,
            ).premiumAppear(index: 1),
            const SectionsData(),
          ],
        ),
      ),
    );
  }
}
