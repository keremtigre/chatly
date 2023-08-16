import 'package:auto_route/auto_route.dart';
import 'package:chatly/Product/helper/shared_pref_helper.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Authentication/Service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          if (rememberMe) {
            await PreferenceUtils.setBool("remember_me", true);
          }
          emit(LoginComplated());
          await Future.delayed(const Duration(milliseconds: 500))
              .then((value) => context.router.pushAndPopUntil(
                    const HomeRoute(),
                    predicate: (route) => false,
                  ));
        } else {
          emit(LoginError(errorMessage: value));
        }
      });
    }
  }
}
