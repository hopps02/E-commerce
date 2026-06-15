import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/default_app_bar.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/support/riverpod/ticket_detail_controller.dart';
import 'package:for_u/presentation/views/user/support/view/widgets/ticket_reply_bar.dart';
import 'package:for_u/presentation/views/user/support/view/widgets/ticket_thread.dart';

class TicketDetailArgs {
  final int id;
  final String number;

  const TicketDetailArgs({required this.id, this.number = ''});
}

class TicketDetailView extends ConsumerStatefulWidget {
  final TicketDetailArgs args;

  const TicketDetailView({super.key, required this.args});

  @override
  ConsumerState<TicketDetailView> createState() => _TicketDetailViewState();
}

class _TicketDetailViewState extends ConsumerState<TicketDetailView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(ticketDetailController.notifier).load(widget.args.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ticketDetailController);
    final ticket = state.ticket;
    final arabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          DefaultAppBar(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: SizeM.pagePadding.w,
            ),
            title: widget.args.number.isEmpty
                ? Translation.support.tr
                : widget.args.number,
          ),
          Container(height: 6.h, color: ColorM.gray150),
          Expanded(
            child: FastStateRender(
              reqState: state.reqState,
              errorMessage: state.msgError,
              onRetry: ref.read(ticketDetailController.notifier).retry,
              child: ticket == null
                  ? const SizedBox.shrink()
                  : TicketThread(ticket: ticket, arabic: arabic),
            ),
          ),
          if (ticket != null) const TicketReplyBar(),
        ],
      ),
    );
  }
}
