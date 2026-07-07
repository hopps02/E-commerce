import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:for_u/app/extensions/extensions.dart';
import 'package:for_u/app/extensions/guest_gate.dart';
import 'package:for_u/app/services/notification_deep_link.dart';
import 'package:for_u/app/ui_kit/buttons/custom_ink_button.dart';
import 'package:for_u/app/ui_kit/customized_smart_refresh.dart';
import 'package:for_u/app/ui_kit/default_app_bar.dart';
import 'package:for_u/presentation/common/fast_state_render.dart';
import 'package:for_u/presentation/res/color_manager.dart';
import 'package:for_u/presentation/res/sizes_manager.dart';
import 'package:for_u/presentation/res/translations_manager.dart';
import 'package:for_u/presentation/views/shared/notifications/riverpod/notifications_controller.dart';
import 'package:for_u/presentation/views/shared/notifications/view/widgets/notification_tile.dart';
import 'package:for_u/presentation/views/shared/notifications/view/widgets/notifications_empty_state.dart';

class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({super.key});

  @override
  ConsumerState<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends ConsumerState<NotificationsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_ensureAccessAndLoad);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationsController);
    final notifier = ref.read(notificationsController.notifier);

    return Scaffold(
      backgroundColor: ColorM.white,
      body: Column(
        children: [
          SizedBox(height: context.topSafeAreaPadding),
          DefaultAppBar(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: SizeM.pagePadding.w,
            ),
            title: Translation.notifications.tr,
            actionButtons: state.unreadCount > 0
                ? [
                    Tooltip(
                      message: Translation.mark_all_read.tr,
                      child: CustomInkButton(
                        onTap: notifier.markAllRead,
                        width: 38.w,
                        height: 38.w,
                        borderRadius: 12.r,
                        backgroundColor: ColorM.primary50,
                        child: Icon(
                          Icons.done_all_rounded,
                          color: ColorM.primary700,
                          size: 21.sp,
                        ),
                      ),
                    ),
                  ]
                : null,
          ).premiumAppear(index: 0),
          Container(height: 6.h, color: ColorM.gray150).premiumAppear(index: 1),
          Expanded(
            child: FastStateRender(
              reqState: state.reqState,
              errorMessage: state.reqState.isEmpty
                  ? '${Translation.no_notifications_yet.tr}\n${Translation.no_notifications_hint.tr}'
                  : state.msgError,
              alignment: const Alignment(0, -0.2),
              onRetry: notifier.retry,
              emptyChild: const NotificationsEmptyState(),
              child: CustomizedSmartRefresh(
                enableLoading: true,
                controller: notifier.refreshController,
                classicFooterPadding: EdgeInsets.only(
                  bottom: context.bottomSafeAreaPadding,
                ),
                onRefresh: notifier.refresh,
                onLoading: notifier.loadMore,
                child: ListView.separated(
                  padding:
                      EdgeInsets.symmetric(horizontal: SizeM.pagePadding.w) +
                      EdgeInsets.only(
                        top: 16.h,
                        bottom: context.bottomPadding + SizeM.pagePadding.w,
                      ),
                  itemCount: state.notifications.length,
                  separatorBuilder: (_, _) => 12.verticalSpace,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return NotificationTile(
                      notification: notification,
                      onTap: () {
                        unawaited(notifier.markRead(notification.id));
                        NotificationDeepLink.open(
                          type: notification.type,
                          payload: notification.payload,
                        );
                      },
                    );
                  },
                ),
              ).premiumAppear(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _ensureAccessAndLoad() async {
    if (!await requireLogin(context, ref)) {
      if (mounted) Navigator.of(context).maybePop();
      return;
    }
    await ref.read(notificationsController.notifier).load();
  }
}
