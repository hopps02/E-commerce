import 'package:easy_localization/easy_localization.dart';
import 'package:jar/app/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:jar/app/utils/global_keyboard_dismissal.dart';

import 'package:jar/presentation/res/routes_manager.dart';
import 'package:jar/presentation/res/theme_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: non_constant_identifier_names
GlobalKey<ScaffoldMessengerState> SCAFFOLD_MESSENGER_KEY =
    GlobalKey<ScaffoldMessengerState>();
// ignore: non_constant_identifier_names
GlobalKey<NavigatorState> NAVIGATOR_KEY = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Key key = UniqueKey();
  late ThemeMode _themeMode;

  @override
  void initState() {
    SCAFFOLD_MESSENGER_KEY = GlobalKey<ScaffoldMessengerState>();
    NAVIGATOR_KEY = GlobalKey<NavigatorState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeMode = DI().storageService.themeMode == ThemeMode.dark
        ? ThemeMode.dark
        : ThemeMode.light;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, details) {
        return MaterialApp(
          scaffoldMessengerKey: SCAFFOLD_MESSENGER_KEY,
          navigatorKey: NAVIGATOR_KEY,
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesManager.splash.route,
          theme: ThemeManager.lightTheme(context),
          // darkTheme: ThemeManager.darkTheme,
          themeMode: _themeMode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: RoutesGeneratorManager.getRoute,
          builder: (context, child) {
            return GlobalKeyboardDismissal(child: child!);
          },
        );
      },
    );
  }

  ThemeMode get themeMode => _themeMode;
}
