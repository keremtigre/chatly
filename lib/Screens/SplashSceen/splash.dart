import 'package:auto_route/auto_route.dart';
import 'package:chatly/Product/helper/shared_pref_helper.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _isLogged(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Image.asset('assets/icon/chat_icon.png'));
  }
}

_isLogged(BuildContext context) async {
  bool rememberMe = PreferenceUtils.getBool("remember_me");
  if (rememberMe) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        context.router.replace(
          const LoginRoute(),
        );
        debugPrint('User is currently signed out!');
      } else {
        debugPrint("User is currently sign in!");
        context.router.push(
          const HomeRoute(),
        );
      }
    });
  } else {
    context.router.replace(
      const LoginRoute(),
    );
  }
}
