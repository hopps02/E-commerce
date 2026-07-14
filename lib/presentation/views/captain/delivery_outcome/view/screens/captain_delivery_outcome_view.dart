import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/app/enums/enums.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/translations_manager.dart';

class CaptainDeliveryOutcomeArgs {
  final CaptainDeliveryOutcomeKind kind;
  final String orderId;
  const CaptainDeliveryOutcomeArgs({required this.kind, required this.orderId});
}

class CaptainDeliveryOutcomeView extends StatelessWidget {
  final CaptainDeliveryOutcomeArgs args;

  const CaptainDeliveryOutcomeView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorM.white,
      body: ResponsiveConstrained(
        maxWidth: 450,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
              child: SizedBox(
                width: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _OutcomeIcon(kind: args.kind),
                    49.verticalSpace,
                    _OutcomeText(kind: args.kind, orderId: args.orderId),
                    49.verticalSpace,
                    _BackHomeButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OutcomeIcon extends StatelessWidget {
  final CaptainDeliveryOutcomeKind kind;
  const _OutcomeIcon({required this.kind});

  @override
  Widget build(BuildContext context) {
    if (kind.isSuccess) {
      return SizedBox(
        width: 180,
        height: 180,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 179,
              height: 179,
              decoration: BoxDecoration(
                color: const Color(0xFFB9F8CF).withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 112,
              height: 112,
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 56,
                color: const Color(0xFF16A34A),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      width: 96,
      height: 96,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFFFE2E2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.cancel_outlined,
        size: 48,
        color: const Color(0xFFEF4444),
      ),
    );
  }
}

class _OutcomeText extends StatelessWidget {
  final CaptainDeliveryOutcomeKind kind;
  final String orderId;
  const _OutcomeText({required this.kind, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final title = kind.isSuccess
        ? Translation.order_delivered_successfully.tr
        : Translation.could_not_complete_delivery.tr;
    final subtitle = kind.isSuccess
        ? Translation.order_delivered_confirmed.trNamed({'order': orderId})
        : Translation.delivery_failure_recorded.trNamed({'order': orderId});

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.titleLarge.copyWith(
            color: const Color(0xFF101828),
            fontWeight: FontWeightM.bold,
            fontSize: kind.isSuccess ? 22.sp : 20,
            height: 1.5,
          ),
        ),
        9.verticalSpace,
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: context.labelMedium.copyWith(
            color: const Color(0xFF6A7282),
            fontSize: 13,
            height: 19.5 / 13,
          ),
        ),
      ],
    );
  }
}

class _BackHomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: () => context.goNamed(Routes.captainHome),
      height: 56,
      width: double.infinity,
      borderRadius: 16.r,
      smoothness: 1,
      backgroundColor: ColorM.primary500,
      alignment: Alignment.center,
      tap: const ButtonAnimationSettings(
        ButtonAnimation.scaleTap,
        intensity: 0.2,
      ),
      child: Text(
        Translation.back_to_home.tr,
        style: context.bodyLarge.copyWith(
          color: ColorM.white,
          fontWeight: FontWeightM.medium,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}
