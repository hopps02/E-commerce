import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';

/// A small pill showing a ticket's status (open / in progress / resolved /
/// closed), colour-coded.
class TicketStatusChip extends StatelessWidget {
  final String status;

  const TicketStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      'open' => (ColorM.primary, Translation.ticket_status_open),
      'in_progress' => (const Color(0xFFE08A1E), Translation.ticket_status_in_progress),
      'resolved' => (const Color(0xFF2E9E5B), Translation.ticket_status_resolved),
      'closed' => (ColorM.gray500, Translation.ticket_status_closed),
      _ => (ColorM.gray500, Translation.ticket_status_open),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label.tr,
        style: context.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeightM.medium,
        ),
      ),
    );
  }
}
