import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/shared/support/riverpod/support_controller.dart';
import 'package:store/presentation/views/shared/support/view/widgets/support_app_bar.dart';
import 'package:store/presentation/views/shared/support/view/widgets/support_body.dart';
import 'package:store/presentation/views/shared/support/view/widgets/support_send_button.dart';

class SupportView extends ConsumerWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(supportController, (previous, next) {
      if (next.success) {
        context.pop();
      }
    });
    return Scaffold(
      backgroundColor: ColorM.white,
      body: SafeArea(
        child: ResponsiveConstrained(
          maxWidth: 550,
          child: Column(
            children: [
              const SupportAppBar().premiumAppear(index: 0),
              const Expanded(child: SupportBody()),
              const SupportSendButton(),
            ],
          ),
        ),
      ),
    );
  }
}
