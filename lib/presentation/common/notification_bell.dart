import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/app/extensions/extensions.dart';
import 'package:store/app/extensions/guest_gate.dart';
import 'package:store/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:store/app/ui_kit/shapes/gradient_border_side.dart';
import 'package:store/presentation/res/color_manager.dart';
import 'package:store/presentation/res/fonts_manager.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/translations_manager.dart';
import 'package:store/presentation/views/shared/notifications/riverpod/notifications_controller.dart';

class NotificationBell extends ConsumerStatefulWidget {
  final bool dark;

  const NotificationBell({super.key, this.dark = false});

  @override
  ConsumerState<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends ConsumerState<NotificationBell> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(notificationsController.notifier).refreshUnreadCount(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = ref
        .watch(isGuestProvider)
        .maybeWhen(data: (guest) => guest, orElse: () => false);
    final unread = isGuest
        ? 0
        : ref.watch(
            notificationsController.select((state) => state.unreadCount),
          );
    final iconColor = widget.dark ? ColorM.white : ColorM.gray800;

    return Tooltip(
      message: Translation.notifications.tr,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomInkButton(
            onTap: () async {
              if (!await requireLogin(context, ref)) return;
              await context.pushNamed(Routes.notifications);
              if (!mounted) return;
              await ref
                  .read(notificationsController.notifier)
                  .refreshUnreadCount();
            },
            width: 38.w,
            height: 38.w,
            borderRadius: 12.r,
            backgroundColor: widget.dark
                ? ColorM.white.withValues(alpha: .14)
                : ColorM.gray100,
            side: widget.dark
                ? GradientBorderSide.none
                : GradientBorderSide(color: ColorM.gray300, width: 1.w),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              Assets.svg.bell.path,
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          if (unread > 0)
            PositionedDirectional(
              top: -4.h,
              end: -5.w,
              child: Container(
                constraints: BoxConstraints(minWidth: 17.w, minHeight: 17.w),
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorM.red,
                  borderRadius: BorderRadius.circular(999.r),
                  border: Border.all(color: ColorM.white, width: 1.4.w),
                ),
                child: Text(
                  unread > 9 ? '9+' : '$unread',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontsM.ibmPlexSansArabic.name,
                    fontSize: 9.sp,
                    color: ColorM.white,
                    fontWeight: FontWeightM.bold,
                    height: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
