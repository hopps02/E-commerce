import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/extensions/navigation_extension.dart';
import 'package:store/app/extensions/theme_extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/app/services/whatsapp_service.dart';
import 'package:store/presentation/views/user/order_details/view/screens/order_details_view.dart';
import 'package:store/presentation/common/general_padding.dart';
import 'package:store/app/enums/enums.dart';

import '../../../../../../app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

class Body extends StatelessWidget {
  final SuccessViewType successViewType;
  final int? orderId;
  final String? orderNumber;
  final String? whatsappUrl;

  const Body({
    super.key,
    required this.successViewType,
    this.orderId,
    this.orderNumber,
    this.whatsappUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GeneralPadding(
      padding: EdgeInsets.symmetric(horizontal: SpaceM.s10.w),
      child: Column(
        children: [
          Text(
            successViewType.isAuth
                ? "${Translation.welcome_to_jar.tr} 👋 "
                : Translation.order_placed_successfully.tr,
            textAlign: TextAlign.center,
            style: context.displaySmall.copyWith(
              fontWeight: FontWeightM.semiBold,
              color: successViewType.isAuth ? ColorM.gray900 : ColorM.white,
              fontSize: successViewType.isAuth ? 24.sp : 28,
            ),
          ),
          SpaceM.s2.verticalSpace,
          Text(
            successViewType.isAuth
                ? Translation.account_created_success.tr
                : "${Translation.order_number.tr} #${orderNumber ?? ''}",
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: successViewType.isAuth ? ColorM.gray600 : ColorM.white,
              fontSize: 15,
            ),
          ),
          SpaceM.s8.verticalSpace,

          // Sending the order on WhatsApp is how it reaches the store, so it
          // leads here — viewing the order is the secondary action.
          if (successViewType.isOrder && (whatsappUrl ?? '').isNotEmpty) ...[
            CustomInkButton(
              onTap: () => WhatsAppService.sendOrder(whatsappUrl!),
              borderRadius: RadiusM.sm.r,
              height: 50,
              backgroundColor: ColorM.white,
              alignment: Alignment.center,
              child: Text(
                Translation.send_order_on_whatsapp.tr,
                style: context.bodyLarge.copyWith(
                  fontWeight: FontWeightM.semiBold,
                  color: ColorM.greenSecondary,
                  fontSize: 16,
                ),
              ),
            ),
            SpaceM.s3.verticalSpace,
          ],

          // Start Shopping Button
          CustomInkButton(
            onTap: () async {
              if (successViewType.isOrder) {
                context.popUntilNamed(Routes.home);
                if (orderId != null) {
                  context.pushNamed(
                    Routes.orderDetails,
                    arguments: OrderDetailsArgs(orderId: orderId!),
                  );
                }
                return;
              }
              // The session was established at verify-otp; land on the
              // home that matches the server-assigned role.
              final role = await DI().sessionService.storedRole();
              if (context.mounted) {
                context.goNamed(role?.homeRoute ?? Routes.auth);
              }
            },
            borderRadius: RadiusM.sm.r,
            height: 50,
            backgroundColor: successViewType.isAuth
                ? ColorM.primary
                : ColorM.transparent,
            alignment: Alignment.center,
            side: successViewType.isAuth
                ? GradientBorderSide.none
                : GradientBorderSide(color: ColorM.white, width: 1.r),
            child: Text(
              successViewType.isAuth
                  ? Translation.start_shopping.tr
                  : Translation.view_order.tr,
              style: context.bodyLarge.copyWith(
                fontWeight: FontWeightM.semiBold,
                color: ColorM.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
