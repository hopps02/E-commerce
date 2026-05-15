import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_components/default_app_bar.dart';
import 'package:for_u/app/ui_components/custom_ink_button.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/app/extensions/widget_extensions.dart';

import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/views/help_support/riverpod/help_support_controller.dart';
import 'package:for_u/presentation/views/help_support/view/widgets/help_support_app_bar.dart';
import 'package:for_u/presentation/views/help_support/view/widgets/help_support_body.dart';

class HelpSupportView extends ConsumerWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          const HelpSupportAppBar().premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          Expanded(
            child: FastStateRender(
              reqState: ref.watch(helpSupportController).reqState,
              onRetry: () {},
              child: const HelpSupportBody().containerSlideUp(),
            ),
          ),
        ],
      ),
    );
  }
}
