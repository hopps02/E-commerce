import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/utils/fast_function.dart';
import 'package:store/data/response/notification_response.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/spacing_manager.dart';

class NotificationTile extends StatelessWidget {
  final MobileNotification notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;
    final style = _styleFor(notification.type);
    final unread = !notification.read;

    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(SpaceM.s4.w),
        decoration: BoxDecoration(
          color: unread
              ? ColorM.primary50.withValues(alpha: .45)
              : ColorM.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: unread ? ColorM.primary100 : ColorM.gray150,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TypeIcon(style: style),
            SpaceM.s3.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notification.localizedTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyMedium.copyWith(
                            color: ColorM.gray900,
                            fontWeight: FontWeightM.semiBold,
                            height: 1.25,
                          ),
                        ),
                      ),
                      SpaceM.s2.horizontalSpace,
                      Padding(
                        padding: EdgeInsets.only(top: SpaceM.s1.h),
                        child: Text(
                          timeAgo(
                            notification.createdAt.toLocal(),
                            context.locale,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.labelSmall.copyWith(
                            color: ColorM.gray500,
                            fontWeight: FontWeightM.medium,
                            height: 1.1,
                          ),
                        ),
                      ),
                      if (unread) ...[
                        SpaceM.s2.horizontalSpace,
                        Padding(
                          padding: EdgeInsets.only(top: SpaceM.s1.h),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: ColorM.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SpaceM.s1.verticalSpace,
                  Text(
                    notification.localizedBody,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall.copyWith(
                      color: ColorM.gray600,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeIcon extends StatelessWidget {
  final _TypeStyle style;

  const _TypeIcon({required this.style});

  @override
  Widget build(BuildContext context) {
    final icon = style.assetPath == null
        ? Icon(style.icon, color: style.color, size: 22.sp)
        : SvgPicture.asset(
            style.assetPath!,
            width: 22,
            height: 22,
            colorFilter: ColorFilter.mode(style.color, BlendMode.srcIn),
          );

    return Container(
      width: 42,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: style.color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: icon,
    );
  }
}

class _TypeStyle {
  final Color color;
  final String? assetPath;
  final IconData icon;

  const _TypeStyle({
    required this.color,
    this.assetPath,
    this.icon = Icons.notifications_rounded,
  });
}

_TypeStyle _styleFor(String type) {
  if (type.startsWith('order.')) {
    return _TypeStyle(color: ColorM.primary700, assetPath: Assets.svg.box.path);
  }
  if (type.startsWith('delivery.')) {
    return _TypeStyle(color: ColorM.orange, assetPath: Assets.svg.car.path);
  }
  if (type.startsWith('support.')) {
    return _TypeStyle(
      color: ColorM.primary600,
      assetPath: Assets.svg.messages.path,
    );
  }
  if (type.startsWith('cashhandover.')) {
    return _TypeStyle(
      color: ColorM.gold,
      icon: Icons.account_balance_wallet_rounded,
    );
  }
  if (type.startsWith('inventory.')) {
    return _TypeStyle(
      color: ColorM.orange,
      icon: Icons.inventory_2_rounded,
    );
  }
  if (type.startsWith('account.')) {
    return _TypeStyle(
      color: ColorM.secondary,
      assetPath: Assets.svg.borderUser.path,
    );
  }
  if (type.startsWith('billing.')) {
    return _TypeStyle(
      color: ColorM.primary800,
      assetPath: Assets.svg.borderReceipt.path,
    );
  }
  if (type.startsWith('catalog.')) {
    return _TypeStyle(
      color: ColorM.greenSecondary,
      icon: Icons.sell_rounded,
    );
  }
  return _TypeStyle(color: ColorM.gray600, assetPath: Assets.svg.bell.path);
}
