import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Navigation Extensions
// Use these when inside a widget where you have a BuildContext.
// Use NAVIGATOR_KEY.currentState when navigating outside a widget (services,
// DI, notification callbacks, etc.).
// ---------------------------------------------------------------------------
extension NavigationExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  // ── Push ──────────────────────────────────────────────────────────────────

  /// Push a named route.
  Future<T?> pushNamed<T>(String route, {Object? arguments}) =>
      navigator.pushNamed<T>(route, arguments: arguments);

  /// Push a named route and remove all previous routes.
  Future<T?> pushNamedAndRemoveAll<T>(String route, {Object? arguments}) =>
      navigator.pushNamedAndRemoveUntil<T>(
        route,
        (_) => false,
        arguments: arguments,
      );

  /// Push a named route and remove routes until [predicate] returns true.
  Future<T?> pushNamedAndRemoveUntil<T>(
    String route,
    RoutePredicate predicate, {
    Object? arguments,
  }) => navigator.pushNamedAndRemoveUntil<T>(
        route,
        predicate,
        arguments: arguments,
      );

  /// Push a named route and replace the current route.
  Future<T?> pushReplacementNamed<T>(String route, {Object? arguments}) =>
      navigator.pushReplacementNamed<T, dynamic>(
        route,
        arguments: arguments,
      );

  // ── Pop ───────────────────────────────────────────────────────────────────

  /// Pop the current route.
  void pop<T>([T? result]) => navigator.pop<T>(result);

  /// Pop if the navigator can (safe pop).
  void maybePop<T>([T? result]) => navigator.maybePop<T>(result);

  /// Pop until the route matches [predicate].
  void popUntil(RoutePredicate predicate) => navigator.popUntil(predicate);

  /// Pop until a named route.
  void popUntilNamed(String route) =>
      navigator.popUntil(ModalRoute.withName(route));

  /// Whether the navigator can pop.
  bool get canPop => navigator.canPop();
}
