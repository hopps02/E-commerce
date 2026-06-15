import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/customized_smart_refresh.dart';
import 'package:for_u/app/ui_kit/default_app_bar.dart';
import 'package:for_u/data/response/customer/support_response.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/router/app_router.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/user/support/riverpod/tickets_controller.dart';
import 'package:for_u/presentation/views/user/support/view/screens/ticket_detail_view.dart';
import 'package:for_u/presentation/views/user/support/view/widgets/ticket_status_chip.dart';

/// The customer's support tickets (My Tickets). Replaces the old static FAQ as
/// the destination of profile "Help & Support".
class TicketsView extends ConsumerWidget {
  const TicketsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ticketsController);
    final notifier = ref.read(ticketsController.notifier);

    return Scaffold(
      backgroundColor: ColorM.white,
      floatingActionButton: state.reqState.isSuccess || state.reqState.isEmpty
          ? FloatingActionButton.extended(
              onPressed: () => context.pushNamed(Routes.createTicket),
              backgroundColor: ColorM.primary,
              foregroundColor: ColorM.white,
              icon: const Icon(Icons.add),
              label: Text(
                Translation.new_ticket.tr,
                style: context.bodyLarge.copyWith(
                  color: ColorM.white,
                  fontWeight: FontWeightM.medium,
                ),
              ),
            ).premiumAppear(index: 2)
          : null,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          DefaultAppBar(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: SizeM.pagePadding.w,
            ),
            title: Translation.my_tickets.tr,
          ).premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          Expanded(
            child: FastStateRender(
              reqState: state.reqState,
              errorMessage: state.msgError,
              alignment: const Alignment(0, -0.2),
              onRetry: notifier.retry,
              emptyChild: const _NoTickets(),
              child: CustomizedSmartRefresh(
                enableLoading: true,
                controller: notifier.refreshController,
                classicFooterPadding: EdgeInsets.only(
                  bottom: context.bottomSafeAreaPadding,
                ),
                onRefresh: notifier.refresh,
                onLoading: notifier.loadMore,
                child: ListView.separated(
                  padding:
                      EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
                      EdgeInsets.only(
                        top: 16.h,
                        bottom: context.bottomPadding + 80.h,
                      ),
                  itemCount: state.tickets.length,
                  separatorBuilder: (_, _) => 12.verticalSpace,
                  itemBuilder: (context, index) =>
                      _TicketCard(ticket: state.tickets[index]),
                ),
              ).premiumAppear(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final Ticket ticket;

  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final created = ticket.createdAt;
    final date = created == null
        ? ''
        : '${created.day}/${created.month}/${created.year}';

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () => context.pushNamed(
        Routes.ticketDetail,
        arguments: TicketDetailArgs(id: ticket.id, number: ticket.ticketNumber),
      ),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: ColorM.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorM.gray150),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    ticket.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyLarge.copyWith(
                      color: ColorM.gray900,
                      fontWeight: FontWeightM.medium,
                    ),
                  ),
                ),
                8.horizontalSpace,
                TicketStatusChip(status: ticket.status),
              ],
            ),
            8.verticalSpace,
            Text(
              ticket.previewText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium.copyWith(color: ColorM.gray600),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ticket.ticketNumber,
                  style: context.labelMedium.copyWith(color: ColorM.gray500),
                ),
                Text(
                  date,
                  style: context.labelMedium.copyWith(color: ColorM.gray500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NoTickets extends StatelessWidget {
  const _NoTickets();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.confirmation_number_outlined,
              size: 64.w,
              color: ColorM.gray300,
            ),
            16.verticalSpace,
            Text(
              Translation.no_tickets_yet.tr,
              textAlign: TextAlign.center,
              style: context.titleSmall.copyWith(
                color: ColorM.gray700,
                fontWeight: FontWeightM.medium,
              ),
            ),
            8.verticalSpace,
            Text(
              Translation.no_tickets_hint.tr,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(color: ColorM.gray500),
            ),
          ],
        ),
      ),
    );
  }
}
