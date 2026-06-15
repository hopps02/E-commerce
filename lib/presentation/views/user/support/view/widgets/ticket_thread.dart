import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/views/user/support/view/widgets/ticket_message_bubble.dart';
import 'package:for_u/presentation/views/user/support/view/widgets/ticket_status_chip.dart';

/// The scrollable conversation for a ticket: header (title, merchant, status)
/// followed by the message bubbles.
class TicketThread extends StatelessWidget {
  final Ticket ticket;
  final bool arabic;

  const TicketThread({super.key, required this.ticket, required this.arabic});

  @override
  Widget build(BuildContext context) {
    final messages = ticket.thread;
    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
          EdgeInsets.only(top: 16.h, bottom: 16.h),
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
            8.horizontalSpace,
            TicketStatusChip(status: ticket.status),
          ],
        ),
        if (ticket.merchantName(arabic).isNotEmpty) ...[
          6.verticalSpace,
          Text(
            ticket.merchantName(arabic),
            style: context.bodyMedium.copyWith(color: ColorM.gray500),
          ),
        ],
        16.verticalSpace,
        for (final message in messages)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: TicketMessageBubble(message: message),
          ),
      ],
    );
  }
}
