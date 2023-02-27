import 'package:auto_route/auto_route.dart';
import 'package:chatly/Screens/Authentication/Login/login.dart';
import 'package:chatly/Screens/Authentication/SignUp/sign_up.dart';
import 'package:chatly/Screens/Home/home.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(
        page: LoginPage,
        initial: true,
        path: "/login",
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        page: SignUpPage,
        path: "/signup",
        transitionsBuilder: TransitionsBuilders.slideBottom),
    AutoRoute(page: HomePage, path: "/home")
  ],
)
class AppRouter extends _$AppRouter {}
