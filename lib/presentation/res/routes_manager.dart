import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:jar/app/enums/enums.dart';
import 'package:jar/presentation/views/auth/view/screens/auth_view.dart';
import 'package:jar/presentation/views/auth_success/view/screens/auth_success_view.dart';
import 'package:jar/presentation/views/cart/view/screens/cart_view.dart';
import 'package:jar/presentation/views/home/view/screens/home_view.dart';
import 'package:jar/presentation/views/product_details/view/screens/product_details_view.dart';
import 'package:jar/presentation/views/products/view/screens/products_view.dart';
import 'package:jar/presentation/views/search/view/screens/search_view.dart';
import 'package:jar/presentation/views/sections/view/screens/sections_view.dart';
import 'package:jar/presentation/views/language/view/screens/language_view.dart';
import 'package:jar/presentation/views/edit_profile/view/screens/edit_profile_view.dart';

import '../views/splash/view/splash_view.dart';
import '../views/onboarding/view/screens/onboarding_view.dart';
import '../views/confirm_order/view/screens/confirm_order_view.dart';
import '../views/order_details/view/screens/order_details_view.dart';

// dart format off
enum RoutesManager {
  splash            ('splash/'),
  onboarding        ('onboarding/'),
  auth              ('auth/'),
  authSuccess       ('authSuccess/'),
  home              ('home/'),
  search            ('search/'),
  sections          ('sections/'),
  products          ('products/'),
  productDetails    ('productDetails/'),
  cart              ('cart/'),
  confirmOrder      ('confirmOrder/'),
  orderDetails      ('orderDetails/'),
  language          ('language/'),
  editProfile       ('editProfile/');

  final String route;

  const RoutesManager(this.route);
}

class RoutesGeneratorManager {
  static Widget _getScreen(String? name, RouteSettings settings) {
    return switch (RoutesManager.values.firstWhere((t) => t.route == name)) {
      RoutesManager.splash            => const SplashView(),
      RoutesManager.onboarding        => const OnboardingView(),
      RoutesManager.auth              => const AuthView(),
      RoutesManager.authSuccess       => _authSuccessView(settings.arguments),
      RoutesManager.home              => _homeView(settings.arguments),
      RoutesManager.search            => const SearchView(),
      RoutesManager.sections          => const SectionsView(),
      RoutesManager.products          => _productsView(settings.arguments),
      RoutesManager.productDetails    => _productDetailsView(settings.arguments),
      RoutesManager.cart              => const CartView(),
      RoutesManager.confirmOrder      => const ConfirmOrderView(),
      RoutesManager.orderDetails      => const OrderDetailsView(),
      RoutesManager.language          => const LanguageView(),
      RoutesManager.editProfile       => const EditProfileView(),
    };
  }
  // dart format on

  // custom navigation animation
  static Route<dynamic> getRoute(RouteSettings settings) => PageRouteBuilder(
    settings: settings,
    transitionDuration: Duration(milliseconds: 400),
    reverseTransitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) =>
        _getScreen(settings.name, settings),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.fastLinearToSlowEaseIn,
      );

      return Opacity(
        opacity: curvedAnimation.value,
        child: SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        ),
      );
    },
  );

  static Widget _homeView(Object? arguments) {
    return Phoenix(key: Key('phoenix'),  child: HomeView());
  }

  static ProductsView _productsView(Object? arguments) {
    return ProductsView(
      args: arguments as ProductsViewArgs? ?? ProductsViewArgs(title: "NONE"),
    );
  }

  static ProductDetailsView _productDetailsView(Object? arguments) {
    return ProductDetailsView(
      args: arguments is ProductDetailsViewArgs
          ? arguments
          : const ProductDetailsViewArgs(productId: ''),
    );
  }

   static AuthSuccessView _authSuccessView(Object? arguments) {
    return AuthSuccessView(
      args: arguments is AuthSuccessArgs
          ? arguments
          : const AuthSuccessArgs(successViewType: SuccessViewType.auth),
    );
  }
}
