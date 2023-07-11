import 'package:final_project/views/confirm/confirmation_view.dart';
import 'package:final_project/views/home/home_view.dart';
import 'package:final_project/views/login/login_view.dart';
import 'package:final_project/views/main/main_view.dart';
import 'package:final_project/views/product/product_view.dart';
import 'package:final_project/views/sign_up/sign_up_view.dart';
import 'package:flutter/material.dart';

class RouteHelper {
  static const String loginRoute = '/login';
  static const String signUpRoute = '/sign-up';
  static const String confirmationRoute = '/confirmation';
  static const String homeRoute = '/home';
  static const String mainRoute = '/main';
  static const String productInfoRoute = '/product-info';

  static final Map<String, WidgetBuilder> routes = {
    loginRoute: (context) => const LoginView(),
    signUpRoute: (context) => const SignUpView(),
    homeRoute: (context) => const HomeView(),
    mainRoute: (context) => const MainView(),
  };
}
