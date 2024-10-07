import 'package:ecom/app/admin/category/category_add.dart';
import 'package:ecom/app/admin/category/category_admin.dart';
import 'package:ecom/app/admin/products/product_add.dart';
import 'package:ecom/app/admin/products/product_admin.dart';
import 'package:ecom/app/admin/sliders/slider_add.dart';
import 'package:ecom/app/admin/sliders/slider_admin.dart';
import 'package:ecom/app/user/view/auth/forget_password_page.dart';
import 'package:ecom/app/user/view/auth/registration_page.dart';
import 'package:ecom/app/user/view/auth/welcome_back_page.dart';
import 'package:ecom/app/user/view/main/bottom_navigation_menu.dart';
import 'package:ecom/app/user/view/main/components/cart_page.dart';
import 'package:ecom/app/user/view/main/components/home.dart';
import 'package:ecom/app/user/view/main/components/shop_list_item.dart';
import 'package:ecom/share/error/error.dart';
import 'package:ecom/share/intro/intro.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../global_variable/global_variable.dart';

class CustomRoute {
  static GoRouter routes = GoRouter(
      navigatorKey: NavigationService.navigatorKey,
      routes: <GoRoute>[
        route(TRouteNames.introPage, const IntroScreen()),
        route(TRouteNames.login, const WelcomeBackPage()),
        route(TRouteNames.errorPage, const ErrorPage()),
        route(TRouteNames.forgetPassword, const ForgetPasswordPage()),
        route(TRouteNames.register, const RegistrationPage()),
        route(TRouteNames.homeScreen, const HomeScreen()),
        route(TRouteNames.userBottomNavigation, const BottomNavigationMenu()),
        route(TRouteNames.shopProduct, const ShopListItem()),
        route(TRouteNames.categoryAddPage, const CategoryAddPage()),
        route(TRouteNames.adminCategoryPage, const AdminCategoryPage()),
        route(TRouteNames.adminProductPage, const ProductAdminPage()),
        route(TRouteNames.adminProductAddPage, const AdminProductAddPage()),
        route(TRouteNames.adminSliderPage, const SliderAdminPage()),
        route(TRouteNames.adminSliderAddPage, const AdminSliderAddPage()),
        route(TRouteNames.cartPage, const CartPage()),
      ],
      errorBuilder: (_, __) => const ErrorPage());

  //-------------------- route model ------------------//
  static GoRoute route(String path, Widget route) {
    return GoRoute(
      path: path,
      builder: (BuildContext context, GoRouterState state) => route,
    );
  }

  // redirect url on the basis of condition
  static launch(BuildContext context, String route, [Object? extra]) {
    GoRouter.of(context).push(route, extra: extra);
  }

  // next page without leading arrow
  static replace(BuildContext context, String route, [Object? extra]) {
    GoRouter.of(context).replace(route, extra: extra);
  }

// Next Page with toolbar leading arrow
  static launchReplace(BuildContext context, String route, [Object? extra]) {
    GoRouter.of(context).pushReplacement(route, extra: extra);
  }

  static finish(BuildContext context) => GoRouter.of(context).pop();
}
