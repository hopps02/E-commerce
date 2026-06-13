import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/data/response/customer/catalog_response.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/fonts_manager.dart';
import 'package:for_u/presentation/res/gen/assets.gen.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';

/// One saved address, in the app's card language (smooth corners, gray250
/// hairline, primary50 icon plate) with default badge and edit/delete.
class AddressCard extends StatelessWidget {
  final DeliveryAddress address;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onSetDefault;

  const AddressCard({
    super.key,
    required this.address,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onSetDefault,
  });

  String _labelName(BuildContext context) => switch (address.label) {
    'work' => Translation.label_work.tr,
    'other' => Translation.label_other.tr,
    _ => Translation.label_home.tr,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(15.r),
            side: BorderSide(color: ColorM.gray250, width: 1.w),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: ColorM.primary50,
                    shape: SmoothRectangleBorder(
                      smoothness: 1,
                      borderRadius: BorderRadius.circular(11.r),
                    ),
                  ),
                  child: SvgPicture.asset(
                    Assets.svg.borderLocation.path,
                    width: 18.w,
                    height: 18.w,
                    colorFilter: const ColorFilter.mode(
                      ColorM.primary500,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                9.horizontalSpace,
                Expanded(
                  child: Text(
                    _labelName(context),
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeightM.medium,
                      color: ColorM.gray950,
                    ),
                  ),
                ),
                if (address.isDefault)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: ShapeDecoration(
                      color: ColorM.primary50,
                      shape: SmoothRectangleBorder(
                        smoothness: 1,
                        borderRadius: BorderRadius.circular(99.r),
                      ),
                    ),
                    child: Text(
                      Translation.address_default_badge.tr,
                      style: context.labelMedium.copyWith(
                        color: ColorM.primary500,
                        fontWeight: FontWeightM.medium,
                      ),
                    ),
                  ),
              ],
            ),
            10.verticalSpace,
            Text(
              address.displayAddress,
              style: context.labelLarge.copyWith(color: ColorM.gray950),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (address.detailsLine.isNotEmpty) ...[
              4.verticalSpace,
              Text(
                address.detailsLine,
                style: context.labelMedium.copyWith(color: ColorM.gray600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            10.verticalSpace,
            Container(height: 1.h, color: ColorM.gray250),
            10.verticalSpace,
            Row(
              children: [
                if (!address.isDefault)
                  CustomInkButton(
                    onTap: onSetDefault,
                    backgroundColor: ColorM.transparent,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    borderRadius: 10.r,
                    child: Text(
                      Translation.address_set_default.tr,
                      style: context.labelLarge.copyWith(
                        color: ColorM.primary500,
                        fontWeight: FontWeightM.medium,
                      ),
                    ),
                  ),
                const Spacer(),
                _ActionIcon(
                  asset: Assets.svg.userPen.path,
                  color: ColorM.gray700,
                  onTap: onEdit,
                ),
                8.horizontalSpace,
                _ActionIcon(
                  asset: Assets.svg.bin.path,
                  color: ColorM.red,
                  onTap: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final String asset;
  final Color color;
  final VoidCallback? onTap;

  const _ActionIcon({required this.asset, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkButton(
      onTap: onTap,
      width: 32.w,
      height: 32.w,
      backgroundColor: ColorM.gray100,
      borderRadius: 10.r,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        asset,
        width: 15.w,
        height: 15.w,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
