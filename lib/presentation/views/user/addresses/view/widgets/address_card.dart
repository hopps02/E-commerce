import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/data/response/customer/catalog_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:store/presentation/res/spacing_manager.dart';
import 'package:store/presentation/res/radius_manager.dart';

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
        padding: EdgeInsets.all(SpaceM.s4.w),
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            smoothness: 1,
            borderRadius: BorderRadius.circular(RadiusM.md.r),
            side: BorderSide(color: ColorM.gray250, width: 1.w),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: ColorM.primary50,
                    shape: SmoothRectangleBorder(
                      smoothness: 1,
                      borderRadius: BorderRadius.circular(RadiusM.sm.r),
                    ),
                  ),
                  child: SvgPicture.asset(
                    Assets.svg.borderLocation.path,
                    width: 18,
                    height: 18,
                    colorFilter: ColorFilter.mode(
                      ColorM.primary500,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SpaceM.s2.horizontalSpace,
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
                    padding: EdgeInsets.symmetric(horizontal: SpaceM.s3, vertical: SpaceM.s1),
                    decoration: ShapeDecoration(
                      color: ColorM.primary50,
                      shape: SmoothRectangleBorder(
                        smoothness: 1,
                        borderRadius: BorderRadius.circular(RadiusM.pill.r),
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
            SpaceM.s3.verticalSpace,
            Text(
              address.displayAddress,
              style: context.labelLarge.copyWith(color: ColorM.gray950),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (address.detailsLine.isNotEmpty) ...[
              SpaceM.s1.verticalSpace,
              Text(
                address.detailsLine,
                style: context.labelMedium.copyWith(color: ColorM.gray600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            SpaceM.s3.verticalSpace,
            Container(height: 1, color: ColorM.gray250),
            SpaceM.s3.verticalSpace,
            Row(
              children: [
                if (!address.isDefault)
                  CustomInkButton(
                    onTap: onSetDefault,
                    backgroundColor: ColorM.transparent,
                    padding: EdgeInsets.symmetric(horizontal: SpaceM.s2, vertical: SpaceM.s2.h),
                    borderRadius: RadiusM.sm.r,
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
                SpaceM.s2.horizontalSpace,
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
      width: 32,
      height: 32,
      backgroundColor: ColorM.gray100,
      borderRadius: RadiusM.sm.r,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        asset,
        width: 15,
        height: 15,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
