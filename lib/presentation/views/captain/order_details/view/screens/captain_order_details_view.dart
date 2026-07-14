import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/views/captain/order_details/riverpod/captain_order_details_controller.dart';
import 'package:store/presentation/views/captain/order_details/view/widgets/captain_cancellation_reason_box.dart';
import 'package:store/presentation/views/captain/order_details/view/widgets/captain_customer_card.dart';
import 'package:store/presentation/views/captain/order_details/view/widgets/captain_order_details_app_bar.dart';
import 'package:store/presentation/views/captain/order_details/view/widgets/captain_order_details_footer.dart';
import 'package:store/presentation/views/captain/order_details/view/widgets/captain_products_card.dart';

class CaptainOrderDetailsArgs {
  final int orderId;

  const CaptainOrderDetailsArgs({required this.orderId});
}

class CaptainOrderDetailsView extends ConsumerStatefulWidget {
  final CaptainOrderDetailsArgs args;

  const CaptainOrderDetailsView({super.key, required this.args});

  @override
  ConsumerState<CaptainOrderDetailsView> createState() =>
      _CaptainOrderDetailsViewState();
}

class _CaptainOrderDetailsViewState
    extends ConsumerState<CaptainOrderDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(captainOrderDetailsController.notifier)
          .load(widget.args.orderId);
    });
  }

  /// The phone is the only contact channel (no in-app chat in v1).
  Future<void> _callCustomer(String phone) async {
    if (phone.isEmpty) return;
    await launchUrl(Uri(scheme: 'tel', path: phone));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(captainOrderDetailsController);
    final notifier = ref.read(captainOrderDetailsController.notifier);

    return Scaffold(
      backgroundColor: ColorM.white,
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: Column(
          children: [
            SizedBox(height: context.topSafeAreaPadding),
            const CaptainOrderDetailsAppBar().premiumAppear(index: 0),
            Expanded(
              child: FastStateRender(
                reqState: state.reqState,
                errorMessage: state.msgError,
                onRetry: () => notifier.load(widget.args.orderId),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 12, bottom: 24.h),
                  child: GeneralPadding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CaptainCustomerCard(
                          customerName: state.customerName,
                          address: state.address,
                          status: state.status,
                          onTapCall: () => _callCustomer(state.customerPhone),
                        ).premiumAppear(index: 1),
                        12.verticalSpace,
                        CaptainProductsCard(
                          items: state.items,
                          totalHalalas: state.totalHalalas,
                        ).premiumAppear(index: 2),
                        if ((state.status.isCancelled ||
                                state.status.isFailed) &&
                            state.cancellationReason != null) ...[
                          16.verticalSpace,
                          CaptainCancellationReasonBox(
                            reason: state.cancellationReason!,
                          ).premiumAppear(index: 3),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CaptainOrderDetailsFooter(status: state.status),
          ],
        ),
      ),
    );
  }
}
