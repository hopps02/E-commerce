import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/app/ui_kit/forms/simple_form.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/data/response/customer/support_response.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/support/riverpod/ticket_detail_controller.dart';
import 'package:store/presentation/views/user/support/view/widgets/ticket_status_chip.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

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
  final TextEditingController _replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final notifier = ref.read(ticketDetailController.notifier);
      notifier.load(widget.args.id);
      notifier.startAutoRefresh(
        const Duration(seconds: 30),
        notifier.silentRefresh,
      );
    });
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final body = _replyController.text.trim();
    if (body.isEmpty) return;
    final ticket = await ref.read(ticketDetailController.notifier).reply(body);
    if (ticket != null) _replyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ticketDetailController);
    final ticket = state.ticket;
    final arabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: ColorM.white,
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: Column(
          children: [
            SizedBox(height: context.topSafeAreaPadding),
            DefaultAppBar(
              padding: EdgeInsets.symmetric(
                vertical: SpaceM.s4,
                horizontal: SizeM.pagePadding,
              ),
              title: widget.args.number.isEmpty
                  ? Translation.support.tr
                  : widget.args.number,
            ),
            Container(height: 6, color: ColorM.gray150),
            Expanded(
              child: FastStateRender(
                reqState: state.reqState,
                errorMessage: state.msgError,
                onRetry: ref.read(ticketDetailController.notifier).retry,
                child: ticket == null
                    ? const SizedBox.shrink()
                    : _Thread(ticket: ticket, arabic: arabic),
              ),
            ),
            if (ticket != null)
              _ReplyBar(
                controller: _replyController,
                sending: state.sending,
                closed: ticket.isClosed,
                onSend: _send,
              ),
          ],
        ),
      ),
    );
  }
}

class _Thread extends StatelessWidget {
  final Ticket ticket;
  final bool arabic;

  const _Thread({required this.ticket, required this.arabic});

  @override
  Widget build(BuildContext context) {
    final messages = ticket.thread;
    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
          EdgeInsets.only(top: SpaceM.s4, bottom: SpaceM.s4.h),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                ticket.title,
                style: context.titleSmall.copyWith(
                  color: ColorM.gray900,
                  fontWeight: FontWeightM.semiBold,
                ),
              ),
            ),
            SpaceM.s2.horizontalSpace,
            TicketStatusChip(status: ticket.status),
          ],
        ),
        if (ticket.merchantName(arabic).isNotEmpty) ...[
          SpaceM.s2.verticalSpace,
          Text(
            ticket.merchantName(arabic),
            style: context.bodyMedium.copyWith(color: ColorM.gray500),
          ),
        ],
        SpaceM.s4.verticalSpace,
        for (final message in messages)
          Padding(
            padding: EdgeInsets.only(bottom: SpaceM.s3.h),
            child: _MessageBubble(message: message),
          ),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final TicketMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isOpener = message.isFromOpener;
    final created = message.createdAt;
    final time = created == null
        ? ''
        : '${created.hour.toString().padLeft(2, '0')}:${created.minute.toString().padLeft(2, '0')}';

    return Align(
      alignment: isOpener
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.78.sw),
        padding: EdgeInsets.symmetric(horizontal: SpaceM.s4, vertical: SpaceM.s3.h),
        decoration: BoxDecoration(
          color: isOpener
              ? ColorM.primary.withValues(alpha: 0.10)
              : ColorM.gray100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(RadiusM.md.r),
            topRight: Radius.circular(RadiusM.md.r),
            bottomLeft: Radius.circular(isOpener ? 14.r : 4.r),
            bottomRight: Radius.circular(isOpener ? 4.r : 14.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.body,
              style: context.bodyMedium.copyWith(color: ColorM.gray900),
            ),
            if (time.isNotEmpty) ...[
              SpaceM.s1.verticalSpace,
              Text(
                time,
                style: context.labelSmall.copyWith(color: ColorM.gray500),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ReplyBar extends StatelessWidget {
  final TextEditingController controller;
  final bool sending;
  final bool closed;
  final VoidCallback onSend;

  const _ReplyBar({
    required this.controller,
    required this.sending,
    required this.closed,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    if (closed) {
      return Container(
        width: double.infinity,
        color: ColorM.gray100,
        padding: EdgeInsets.fromLTRB(
          SizeM.pagePadding,
          SpaceM.s4,
          SizeM.pagePadding,
          SpaceM.s4.h + context.bottomSafeAreaPadding,
        ),
        child: Text(
          Translation.ticket_closed_cannot_reply.tr,
          textAlign: TextAlign.center,
          style: context.bodyMedium.copyWith(color: ColorM.gray600),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: ColorM.white,
        boxShadow: [
          BoxShadow(
            color: ColorM.gray900.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: Offset(0, -8.h),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        SizeM.pagePadding,
        SpaceM.s3,
        SizeM.pagePadding,
        SpaceM.s3.h + context.bottomSafeAreaPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SimpleForm(
              controller: controller,
              hintText: Translation.write_a_reply.tr,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              borderRadius: RadiusM.md.r,
              backgroundColor: ColorM.gray100,
              borderColor: ColorM.gray100,
              alignment: AlignmentDirectional.topStart,
              padding: EdgeInsets.symmetric(horizontal: SpaceM.s4, vertical: SpaceM.s3.h),
              textAlign: TextAlign.start,
            ),
          ),
          SpaceM.s3.horizontalSpace,
          CustomInkButton(
            onTap: onSend,
            isLoading: sending,
            width: 52,
            height: 52,
            backgroundColor: ColorM.primary,
            borderRadius: RadiusM.md.r,
            alignment: Alignment.center,
            child: Icon(Icons.send_rounded, color: ColorM.white, size: 22.w),
          ),
        ],
      ),
    );
  }
}
