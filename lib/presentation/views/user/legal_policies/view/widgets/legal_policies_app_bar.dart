import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class LegalPoliciesAppBar extends StatelessWidget {
  const LegalPoliciesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      padding: EdgeInsets.symmetric(
        vertical: SpaceM.s4,
        horizontal: SizeM.pagePadding,
      ),
      title: Translation.legal_and_policies.tr,
    );
  }
}
