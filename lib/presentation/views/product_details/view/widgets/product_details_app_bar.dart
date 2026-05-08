import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jar/app/extensions/extensions.dart';
import 'package:jar/app/ui_components/custom_ink_button.dart';
import 'package:jar/app/ui_components/default_app_bar.dart';
import 'package:jar/presentation/res/color_manager.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';
import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/res/translations_manager.dart';
import 'package:jar/app/ui_components/gradient_border_side.dart';


class ProductDetailsAppBar extends StatelessWidget {
  const ProductDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 17.h),
      child: DefaultAppBar(
        title: Translation.product_details.tr,
        titleAlignment: .center,
        actionButtons: [
          _CartIconButton(),
        ],
      ),
    );
  }
}

class _CartIconButton extends StatelessWidget {
  const _CartIconButton();

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: () => context.pushNamed(RoutesManager.cart.route),
      padding: EdgeInsets.zero,
      width: 38.w,
      height: 38.w,
      smoothness: 0,
      backgroundColor: ColorM.white,
      borderRadius: 12.r,
      alignment: Alignment.center,
      side: GradientBorderSide(color: ColorM.gray300, width: 1.w),
      child: SvgPicture.asset(
        Assets.svg.borderBag.path,
        width: 22.w,
        height: 22.w,
        colorFilter: ColorFilter.mode(ColorM.gray900, BlendMode.srcIn),
      ),
    );
  }
}
