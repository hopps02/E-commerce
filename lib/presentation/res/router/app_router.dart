import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/presentation/views/shared/auth/view/screens/auth_view.dart';
import 'package:for_u/presentation/views/user/auth_success/view/screens/auth_success_view.dart';
import 'package:for_u/presentation/views/user/cart/view/screens/cart_view.dart';
import 'package:for_u/presentation/views/user/confirm_order/view/screens/confirm_order_view.dart';
import 'package:for_u/presentation/views/user/edit_profile/view/screens/edit_profile_view.dart';
import 'package:for_u/presentation/views/user/help_support/view/screens/help_support_view.dart';
import 'package:for_u/presentation/views/user/home/view/screens/home_view.dart';
import 'package:for_u/presentation/views/user/language/view/screens/language_view.dart';
import 'package:for_u/presentation/views/user/legal_policies/view/screens/legal_policies_view.dart';
import 'package:for_u/presentation/views/user/onboarding/view/screens/onboarding_view.dart';
import 'package:for_u/presentation/views/user/order_details/view/screens/order_details_view.dart';
import 'package:for_u/presentation/views/user/product_details/view/screens/product_details_view.dart';
import 'package:for_u/presentation/views/user/products/view/screens/products_view.dart';
import 'package:for_u/presentation/views/user/search/view/screens/search_view.dart';
import 'package:for_u/presentation/views/user/sections/view/screens/sections_view.dart';
import 'package:for_u/presentation/views/shared/splash/view/splash_view.dart';

/// Centralized path/name constants — pass these to `context.pushNamed` /
/// `context.go` so we never typo a route name and IDE rename works.
///
// dart format off
enum Routes {
  splash         ('splash'),
  onboarding     ('onboarding'),
  auth           ('auth'),
  authSuccess    ('authSuccess'),
  home           ('home'),
  search         ('search'),
  sections       ('sections'),
  products       ('products'),
  productDetails ('productDetails'),
  cart           ('cart'),
  confirmOrder   ('confirmOrder'),
  orderDetails   ('orderDetails'),
  language       ('language'),
  editProfile    ('editProfile'),
  legalPolicies  ('legalPolicies'),
  helpSupport    ('helpSupport');

  final String name;
  const Routes(this.name);


  String get path => '/$name';
    
  
}

// dart format on

Widget _slideFadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final curved = CurvedAnimation(
    parent: animation,
    curve: Curves.fastLinearToSlowEaseIn,
  );
  return Opacity(
    opacity: curved.value,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(curved),
      child: child,
    ),
  );
}

GoRoute _r({
  required String name,
  required String path,
  required Widget Function(BuildContext context, GoRouterState state) builder,
}) => GoRoute(
  name: name,
  path: path,
  pageBuilder: (context, state) => CustomTransitionPage<void>(
    key: state.pageKey,
    name: name,
    child: builder(context, state),
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: _slideFadeTransition,
  ),
);

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.splash.path,
  routes: [
    _r(
      name: Routes.splash.name,
      path: Routes.splash.path,
      builder: (_, __) => const SplashView(),
    ),
    _r(
      name: Routes.onboarding.name,
      path: Routes.onboarding.path,
      builder: (_, __) => const OnboardingView(),
    ),
    _r(
      name: Routes.auth.name,
      path: Routes.auth.path,
      builder: (_, __) => const AuthView(),
    ),
    _r(
      name: Routes.authSuccess.name,
      path: Routes.authSuccess.path,
      builder: (_, state) => AuthSuccessView(
        args: state.extra is AuthSuccessArgs
            ? state.extra as AuthSuccessArgs
            : const AuthSuccessArgs(successViewType: SuccessViewType.auth),
      ),
    ),
    _r(
      name: Routes.home.name,
      path: Routes.home.path,
      builder: (_, __) => HomeView(),
    ),
    _r(
      name: Routes.search.name,
      path: Routes.search.path,
      builder: (_, __) => const SearchView(),
    ),
    _r(
      name: Routes.sections.name,
      path: Routes.sections.path,
      builder: (_, __) => const SectionsView(),
    ),
    _r(
      name: Routes.products.name,
      path: Routes.products.path,
      builder: (_, state) => ProductsView(
        args: state.extra is ProductsViewArgs
            ? state.extra as ProductsViewArgs
            : ProductsViewArgs(title: 'NONE'),
      ),
    ),
    _r(
      name: Routes.productDetails.name,
      path: Routes.productDetails.path,
      builder: (_, state) => ProductDetailsView(
        args: state.extra is ProductDetailsViewArgs
            ? state.extra as ProductDetailsViewArgs
            : const ProductDetailsViewArgs(productId: ''),
      ),
    ),
    _r(
      name: Routes.cart.name,
      path: Routes.cart.path,
      builder: (_, __) => const CartView(),
    ),
    _r(
      name: Routes.confirmOrder.name,
      path: Routes.confirmOrder.path,
      builder: (_, __) => const ConfirmOrderView(),
    ),
    _r(
      name: Routes.orderDetails.name,
      path: Routes.orderDetails.path,
      builder: (_, __) => const OrderDetailsView(),
    ),
    _r(
      name: Routes.language.name,
      path: Routes.language.path,
      builder: (_, __) => const LanguageView(),
    ),
    _r(
      name: Routes.editProfile.name,
      path: Routes.editProfile.path,
      builder: (_, __) => const EditProfileView(),
    ),
    _r(
      name: Routes.legalPolicies.name,
      path: Routes.legalPolicies.path,
      builder: (_, __) => const LegalPoliciesView(),
    ),
    _r(
      name: Routes.helpSupport.name,
      path: Routes.helpSupport.path,
      builder: (_, __) => const HelpSupportView(),
    ),
  ],
);
