import 'package:flutter/material.dart';
import 'package:for_u/app/app.dart';
import 'package:for_u/data/models/auth/auth_models.dart';
import 'package:for_u/presentation/views/captain/captain_home/view/screens/captain_home_view.dart';
import 'package:for_u/presentation/views/captain/delivery_outcome/view/screens/captain_delivery_outcome_view.dart';
import 'package:for_u/presentation/views/captain/order_details/view/screens/captain_order_details_view.dart';
import 'package:for_u/presentation/views/cashier/cashier_home/view/screens/cashier_home_view.dart';
import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/presentation/views/cashier/order_details/view/screens/cashier_order_details_view.dart';
import 'package:for_u/presentation/views/shared/support/view/screens/support_view.dart';
import 'package:go_router/go_router.dart';

import 'package:for_u/app/enums/enums.dart';
import 'package:for_u/presentation/views/shared/auth/view/screens/auth_view.dart';
import 'package:for_u/presentation/views/shared/auth_success/view/screens/auth_success_view.dart';
import 'package:for_u/presentation/views/user/cart/view/screens/cart_view.dart';
import 'package:for_u/presentation/views/user/confirm_order/view/screens/confirm_order_view.dart';
import 'package:for_u/presentation/views/user/addresses/view/screens/address_form_view.dart';
import 'package:for_u/presentation/views/user/addresses/view/screens/addresses_view.dart';
import 'package:for_u/presentation/views/user/edit_profile/view/screens/edit_profile_view.dart';
import 'package:for_u/presentation/views/user/help_support/view/screens/help_support_view.dart';
import 'package:for_u/presentation/views/user/user_home/view/screens/user_home_view.dart';
import 'package:for_u/presentation/views/user/language/view/screens/language_view.dart';
import 'package:for_u/presentation/views/user/legal_policies/view/screens/legal_policies_view.dart';
import 'package:for_u/presentation/views/shared/onboarding/view/screens/onboarding_view.dart';
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

  // Shared routes
  splash         ('splash'),
  auth           ('auth'),

  // User routes
  onboarding     ('onboarding'),
  authSuccess    ('auth-success'),
  home           ('home'),
  search         ('search'),
  sections       ('sections'),
  products       ('products'),
  productDetails ('product-details'),
  cart           ('cart'),
  confirmOrder   ('confirm-order'),
  orderDetails   ('order-details'),
  language       ('language'),
  editProfile    ('edit-profile'),
  legalPolicies  ('legal-policies'),
  helpSupport    ('help-support'),
  addresses      ('addresses'),
  addressForm    ('address-form'),

  // Cashier routes
  cashierHome           ('cashier-home'),
  cashierOrderDetails   ('cashier-order-details'),

  // Captain routes
  captainHome             ('captain-home'),
  captainOrderDetails     ('captain-order-details'),
  captainDeliveryOutcome  ('captain-delivery-outcome'),

  // Shared (cashier + captain)
  support               ('support');

  final String name;
  const Routes(this.name);


  String get path => '/$name';


}

// dart format on

/// Each role lands on its own home — the role comes from the backend
/// (verify-otp / stored session), never from user choice.
extension MobileRoleHome on MobileRole {
  Routes get homeRoute => switch (this) {
    MobileRole.customer => Routes.home,
    MobileRole.cashier => Routes.cashierHome,
    MobileRole.captain => Routes.captainHome,
  };
}

Widget _slideFadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final inCurve = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeInOut,
  );

  final outCurve = CurvedAnimation(
    parent: secondaryAnimation,
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeInOut,
  );

  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(inCurve),
    child: SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-0.3, 0),
      ).animate(outCurve),
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
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: _slideFadeTransition,
  ),
);

final GoRouter appRouter = GoRouter(
  navigatorKey: NAVIGATOR_KEY,
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
      builder: (_, __) => UserHomeView(),
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
            : const ProductDetailsViewArgs(productId: 0),
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
      builder: (_, state) => OrderDetailsView(
        args: state.extra is OrderDetailsArgs
            ? state.extra as OrderDetailsArgs
            : const OrderDetailsArgs(orderId: 0),
      ),
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
      name: Routes.addresses.name,
      path: Routes.addresses.path,
      builder: (_, __) => const AddressesView(),
    ),
    _r(
      name: Routes.addressForm.name,
      path: Routes.addressForm.path,
      builder: (_, state) => AddressFormView(
        args: state.extra is AddressFormArgs
            ? state.extra as AddressFormArgs
            : const AddressFormArgs(),
      ),
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
    _r(
      name: Routes.cashierHome.name,
      path: Routes.cashierHome.path,
      builder: (_, __) => const CashierHomeView(),
    ),
    _r(
      name: Routes.support.name,
      path: Routes.support.path,
      builder: (_, __) => const SupportView(),
    ),
    _r(
      name: Routes.cashierOrderDetails.name,
      path: Routes.cashierOrderDetails.path,
      builder: (_, state) => CashierOrderDetailsView(
        args: state.extra is CashierOrderDetailsArgs
            ? state.extra as CashierOrderDetailsArgs
            : const CashierOrderDetailsArgs(orderId: 0),
      ),
    ),
    _r(
      name: Routes.captainHome.name,
      path: Routes.captainHome.path,
      builder: (_, __) => const CaptainHomeView(),
    ),
    _r(
      name: Routes.captainOrderDetails.name,
      path: Routes.captainOrderDetails.path,
      builder: (_, state) => CaptainOrderDetailsView(
        args: state.extra is CaptainOrderDetailsArgs
            ? state.extra as CaptainOrderDetailsArgs
            : const CaptainOrderDetailsArgs(orderId: 0),
      ),
    ),
    _r(
      name: Routes.captainDeliveryOutcome.name,
      path: Routes.captainDeliveryOutcome.path,
      builder: (_, state) => CaptainDeliveryOutcomeView(
        args: state.extra is CaptainDeliveryOutcomeArgs
            ? state.extra as CaptainDeliveryOutcomeArgs
            : const CaptainDeliveryOutcomeArgs(
                kind: CaptainDeliveryOutcomeKind.success,
                orderId: '',
              ),
      ),
    ),
  ],
);
