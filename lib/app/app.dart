import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/app/di/dependency_injection.dart';
import 'package:store/app/extensions/view_extensions.dart';
import 'package:store/presentation/common/riverpod/brand_controller.dart';
import 'package:store/app/responsive/responsive.dart';
import 'package:store/app/ui_kit/global_keyboard_dismissal.dart';

import 'package:store/presentation/res/router/app_router.dart';
import 'package:store/presentation/res/theme_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// dart format off
// ignore: non_constant_identifier_names
GlobalKey<ScaffoldMessengerState> SCAFFOLD_MESSENGER_KEY = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState>   NAVIGATOR_KEY          = GlobalKey<NavigatorState>();
// dart format on

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    SCAFFOLD_MESSENGER_KEY = GlobalKey<ScaffoldMessengerState>();
    super.initState();

    // The colours on screen are last run's; this fetches today's and
    // repaints only if the panel changed something.
    Future.microtask(
      () => DI.container.read(brandController.notifier).refresh(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScope(
      child: Builder(
        builder: (context) {
          // Design canvas per form factor: phones/tablet keep the phone
          // baseline; desktop uses a desktop canvas so .w/.sp don't explode.
          final designSize = context.bySize<Size>(
            mobile: const Size(375, 812),
            tablet: const Size(768, 1024),
            desktop: const Size(1440, 1024),
            largeDesktop: const Size(1440, 1024),
          );
          return ScreenUtilInit(
            designSize: designSize,
            builder: (context, details) {
              return Consumer(
                builder: (context, ref, _) {
                  ref.watch(brandController);
                  return _app(context);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _app(BuildContext context) {
              return MaterialApp.router(
                scaffoldMessengerKey: SCAFFOLD_MESSENGER_KEY,
                debugShowCheckedModeBanner: false,
                scrollBehavior: const AppScrollBehavior(),
                theme: ThemeManager.lightTheme(context),
                themeMode: ThemeMode.light,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                routerConfig: appRouter,
                builder: (context, child) {
                  return GlobalKeyboardDismissal(
                    child: Stack(
                      children: [
                        child!,
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: context.topSafeAreaPadding,
                          child: IgnorePointer(
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: Container(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
  }

  ThemeMode get themeMode => ThemeMode.light;
}

/// Lets the mouse drag-scroll (and drive pull-to-refresh / pull-up gestures) on
/// web and desktop. Flutter's default behaviour only allows wheel/scrollbar
/// input for a mouse, so `SmartRefresher`'s pull gestures never fired there.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.unknown,
  };
}
