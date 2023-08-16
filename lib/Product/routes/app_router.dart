import 'package:auto_route/auto_route.dart';
import 'package:chatly/Screens/Authentication/Login/login.dart';
import 'package:chatly/Screens/Authentication/SignUp/sign_up.dart';
import 'package:chatly/Screens/Home/Contacts/contacts.dart';
import 'package:chatly/Screens/Home/Messages/messages.dart';
import 'package:chatly/Screens/Home/home.dart';
import 'package:chatly/Screens/SplashSceen/splash.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(
      initial: true,
      page: SplashPage,
      path: "/splash",
    ),
    CustomRoute(
        page: MessagesPage,
        path: "/messages",
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: LoginPage,
        path: "/login",
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        page: SignUpPage,
        path: "/signup",
        transitionsBuilder: TransitionsBuilders.slideBottom),
    AutoRoute(
      page: HomePage,
      path: "/home",
    ),
    AutoRoute(
      page: ContactsPage,
      path: "/contacts",
    ),
  ],
)
class AppRouter extends _$AppRouter {}
