import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/customized_smart_refresh.dart';
import 'package:store/app/ui_kit/default_app_bar.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/data/response/customer/support_response.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/sizes_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/user/support/riverpod/tickets_controller.dart';
import 'package:store/presentation/views/user/support/view/screens/ticket_detail_view.dart';
import 'package:store/presentation/views/user/support/view/widgets/ticket_status_chip.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

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
              title: Translation.my_tickets.tr,
            ).premiumAppear(index: 0),
            Container(height: 6, color: ColorM.gray150).premiumAppear(index: 1),
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
                          top: SpaceM.s4,
                          bottom: context.bottomPadding + 80,
                        ),
                    itemCount: state.tickets.length,
                    separatorBuilder: (_, _) => SpaceM.s3.verticalSpace,
                    itemBuilder: (context, index) =>
                        _TicketCard(ticket: state.tickets[index]),
                  ),
                ).premiumAppear(),
              ),
            ),
          ],
        ),
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
      borderRadius: BorderRadius.circular(RadiusM.md.r),
      onTap: () => context.pushNamed(
        Routes.ticketDetail,
        arguments: TicketDetailArgs(id: ticket.id, number: ticket.ticketNumber),
      ),
      child: Container(
        padding: EdgeInsets.all(SpaceM.s4.w),
        decoration: BoxDecoration(
          color: ColorM.white,
          borderRadius: BorderRadius.circular(RadiusM.md.r),
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
                SpaceM.s2.horizontalSpace,
                TicketStatusChip(status: ticket.status),
              ],
            ),
            SpaceM.s2.verticalSpace,
            Text(
              ticket.previewText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium.copyWith(color: ColorM.gray600),
            ),
            SpaceM.s3.verticalSpace,
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
        padding: EdgeInsets.symmetric(horizontal: SpaceM.s8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.confirmation_number_outlined,
              size: 64,
              color: ColorM.gray300,
            ),
            SpaceM.s4.verticalSpace,
            Text(
              Translation.no_tickets_yet.tr,
              textAlign: TextAlign.center,
              style: context.titleSmall.copyWith(
                color: ColorM.gray700,
                fontWeight: FontWeightM.medium,
              ),
            ),
            SpaceM.s2.verticalSpace,
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
