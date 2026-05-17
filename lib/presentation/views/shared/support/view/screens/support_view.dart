import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/views/shared/support/riverpod/support_controller.dart';
import 'package:for_u/presentation/views/shared/support/view/widgets/support_app_bar.dart';
import 'package:for_u/presentation/views/shared/support/view/widgets/support_body.dart';
import 'package:for_u/presentation/views/shared/support/view/widgets/support_send_button.dart';

class SupportView extends ConsumerWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(supportController, (previous, next) {
      if (next) {
        context.pop();
      }
    });
    return Scaffold(
      backgroundColor: ColorM.white,
      body: SafeArea(
        child: Column(
          children: [
            const SupportAppBar().premiumAppear(index: 0),
            const Expanded(child: SupportBody()),
            const SupportSendButton(),
          ],
        ),
      ),
    );
  }
}
