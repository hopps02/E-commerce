import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/presentation/res/color_manager.dart';

/// A single chat bubble in a ticket thread. The opener's messages align to the
/// trailing edge and use the primary tint; staff replies align to the start.
class TicketMessageBubble extends StatelessWidget {
  final TicketMessage message;

  const TicketMessageBubble({super.key, required this.message});

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
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isOpener ? ColorM.primary.withValues(alpha: 0.10) : ColorM.gray100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.r),
            topRight: Radius.circular(14.r),
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
              4.verticalSpace,
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
