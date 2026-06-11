import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/common/general_padding.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/views/captain/order_details/riverpod/captain_order_details_controller.dart';
import 'package:for_u/presentation/views/captain/order_details/view/widgets/captain_cancellation_reason_box.dart';
import 'package:for_u/presentation/views/captain/order_details/view/widgets/captain_customer_card.dart';
import 'package:for_u/presentation/views/captain/order_details/view/widgets/captain_order_details_app_bar.dart';
import 'package:for_u/presentation/views/captain/order_details/view/widgets/captain_order_details_footer.dart';
import 'package:for_u/presentation/views/captain/order_details/view/widgets/captain_products_card.dart';

class CaptainOrderDetailsArgs {
  final CaptainOrderStatus initialStatus;

  const CaptainOrderDetailsArgs({
    this.initialStatus = CaptainOrderStatus.upcoming,
  });
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
          .seed(widget.args.initialStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(captainOrderDetailsController);
    final notifier = ref.read(captainOrderDetailsController.notifier);

    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          const CaptainOrderDetailsAppBar().premiumAppear(index: 0),
          Expanded(
            child: FastStateRender(
              reqState: state.reqState,
              errorMessage: state.msgError,
              onRetry: notifier.retry,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
                child: GeneralPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CaptainCustomerCard(
                        customerName: state.customerName,
                        address: state.address,
                        status: state.status,
                        onTapCall: () {},
                      ).premiumAppear(index: 1),
                      12.verticalSpace,
                      CaptainProductsCard(
                        items: state.items,
                        totalAmount: state.totalAmount,
                      ).premiumAppear(index: 2),
                      if (state.status.isCancelled &&
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
    );
  }
}
