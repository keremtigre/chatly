import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Authentication/Service/auth_service.dart';
import 'package:chatly/Screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final loginFormKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool _loginPasswordVisibility = false;
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  bool get loginPasswordVisibility => _loginPasswordVisibility;

  setRememberMeChoose(bool value) {
    _rememberMe = value;
    emit(LoginInitial());
  }

  setPasswordVisibility() {
    _loginPasswordVisibility = !_loginPasswordVisibility;
    emit(LoginInitial());
  }

  loginWithEmailAndPassword(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      emit(LoginLoading());
      // await Future.delayed(const Duration(milliseconds: 200));
      FirebaseAuthService()
          .loginWithEmailAndPassword(
              email: loginEmailController.text,
              password: loginPasswordController.text)
          .then((value) async {
        if (value == null) {
          emit(LoginComplated());
          await context.router.pushAndPopUntil(
            HomeRoute(),
            predicate: (route) => false,
          );
        } else {
          emit(LoginError(errorMessage: value));
        }
      });
    }
  }
}
