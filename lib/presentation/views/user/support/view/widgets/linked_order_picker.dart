import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/failure_display_extension.dart';
import 'package:store/app/ui_kit/indicators/state_render.dart';
import 'package:store/data/response/customer/customer_response.dart';
import 'package:store/domain/usecase/get_customer_orders_usecase.dart';
import 'package:store/presentation/common/fast_state_render.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/res/spacing_manager.dart';

/// The order a customer optionally links to a ticket. id == null means "no order
/// / general ticket".
typedef LinkedOrder = ({int? id, String number});

/// Bottom sheet to pick a recent order to link to a support ticket. Returns null
/// if dismissed, or a [LinkedOrder] (id null = general) on selection.
class LinkedOrderPicker {
  static Future<LinkedOrder?> show(BuildContext context) {
    return showModalBottomSheet<LinkedOrder>(
      context: context,
      backgroundColor: ColorM.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => const _LinkedOrderPickerBody(),
    );
  }
}

class _LinkedOrderPickerBody extends StatefulWidget {
  const _LinkedOrderPickerBody();

  @override
  State<_LinkedOrderPickerBody> createState() => _LinkedOrderPickerBodyState();
}

class _LinkedOrderPickerBodyState extends State<_LinkedOrderPickerBody> {
  ReqState _reqState = ReqState.loading;
  String _errorMessage = '';
  List<CustomerOrder> _orders = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _reqState = ReqState.loading);

    final results = await Future.wait([
      DI().getCustomerOrdersUseCase.execute(
        const CustomerOrdersParams(statusGroup: 'current', page: 1),
      ),
      DI().getCustomerOrdersUseCase.execute(
        const CustomerOrdersParams(statusGroup: 'previous', page: 1),
      ),
    ]);

    final orders = <CustomerOrder>[];
    var anySucceeded = false;
    var failureMessage = '';
    for (final r in results) {
      r.fold((failure) => failureMessage = failure.displayMessage, (page) {
        anySucceeded = true;
        orders.addAll(page.orders);
      });
    }
    if (!mounted) return;
    setState(() {
      _orders = orders;
      // If even one bucket loaded we trust the list ("no order" is always there);
      // only when BOTH fail do we block with a retryable error instead of
      // pretending the customer has no orders.
      _reqState = anySucceeded ? ReqState.success : ReqState.error;
      _errorMessage = anySucceeded ? '' : failureMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 0.7.sh),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpaceM.s3.verticalSpace,
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: ColorM.gray200,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SpaceM.s4.verticalSpace,
            Text(
              Translation.select_order.tr,
              style: context.titleSmall.copyWith(
                color: ColorM.gray900,
                fontWeight: FontWeightM.semiBold,
              ),
            ),
            SpaceM.s4.verticalSpace,
            Flexible(
              child: FastStateRender(
                reqState: _reqState,
                errorMessage: _errorMessage,
                onRetry: _load,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(SpaceM.s4, 0, SpaceM.s4, SpaceM.s4.h),
                  itemCount: _orders.length + 1,
                  separatorBuilder: (_, _) =>
                      Divider(height: 1, color: ColorM.gray150),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _OrderTile(
                        title: Translation.no_linked_order.tr,
                        onTap: () =>
                            Navigator.of(context).pop((id: null, number: '')),
                      );
                    }
                    final order = _orders[index - 1];
                    return _OrderTile(
                      title: order.orderNumber,
                      onTap: () => Navigator.of(
                        context,
                      ).pop((id: order.id, number: order.orderNumber)),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _OrderTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: SpaceM.s1.w),
      title: Text(
        title,
        style: context.bodyLarge.copyWith(color: ColorM.gray900),
      ),
      trailing: Icon(
        isRtl ? Icons.chevron_left : Icons.chevron_right,
        color: ColorM.gray400,
      ),
    );
  }
}
