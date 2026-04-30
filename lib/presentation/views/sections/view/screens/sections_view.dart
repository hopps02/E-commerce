import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/app/extensions/view_extensions.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/views/sections/view/widgets/app_bar.dart';
import 'package:jar/presentation/views/sections/view/widgets/sections_data.dart';

class SectionsView extends StatefulWidget {
  const SectionsView({super.key});

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          TopAppBar(),
          Container(height: 6.h, color: ColorM.gray150),
          SectionsData()
        ],
      ),
    );
  }
}
