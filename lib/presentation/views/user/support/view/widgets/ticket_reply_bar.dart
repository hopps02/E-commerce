import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/ui_kit/forms/simple_form.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/support/riverpod/ticket_detail_controller.dart';

/// The reply composer pinned to the bottom of the ticket thread. Reads its
/// field, busy state, and send action straight from the controller — no logic
/// or text handling lives in the view. Collapses to a notice when the ticket is
/// closed.
class TicketReplyBar extends ConsumerWidget {
  const TicketReplyBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(ticketDetailController.notifier);
    final sending = ref.watch(
      ticketDetailController.select((s) => s.sending),
    );
    final closed = ref.watch(
      ticketDetailController.select((s) => s.ticket?.isClosed ?? false),
    );

    if (closed) {
      return Container(
        width: double.infinity,
        color: ColorM.gray100,
        padding: EdgeInsets.fromLTRB(
          SizeM.pagePadding.w,
          14.h,
          SizeM.pagePadding.w,
          14.h + context.bottomSafeAreaPadding,
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
        SizeM.pagePadding.w,
        10.h,
        SizeM.pagePadding.w,
        10.h + context.bottomSafeAreaPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SimpleForm(
              controller: notifier.replyController,
              hintText: Translation.write_a_reply.tr,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              borderRadius: 15.r,
              backgroundColor: ColorM.gray100,
              borderColor: ColorM.gray100,
              alignment: AlignmentDirectional.topStart,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              textAlign: TextAlign.start,
            ),
          ),
          10.horizontalSpace,
          CustomInkButton(
            onTap: notifier.sendReply,
            isLoading: sending,
            width: 52.w,
            height: 52.w,
            backgroundColor: ColorM.primary,
            borderRadius: 15.r,
            alignment: Alignment.center,
            child: Icon(Icons.send_rounded, color: ColorM.white, size: 22.w),
          ),
        ],
      ),
    );
  }
}
