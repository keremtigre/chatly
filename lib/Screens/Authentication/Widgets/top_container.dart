import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Screens/Authentication/Login/viewmodel/cubit/login_cubit.dart';
import 'package:chatly/Screens/Authentication/SignUp/viewmodel/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget topContainer(BuildContext context,
    {SignUpState? signUpState, LoginState? loginState}) {
  final state = signUpState ?? loginState;
  String? errorMessage = "";
  if (state is LoginError) {
    errorMessage = state.errorMessage;
  } else if (state is SignUpError) {
    errorMessage = state.errorMessage;
  }
  return (state is SignUpState
          ? (state is SignUpComplated || state is SignUpError)
          : state is LoginComplated || state is LoginError)
      ? Container(
          alignment: Alignment.center,
          height: 200,
          width: context.width,
          color: (state is SignUpComplated || state is LoginComplated)
              ? Colors.green
              : Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AutoSizeText(
                      errorMessage!.isNotEmpty
                          ? errorMessage
                          : state is LoginComplated
                              ? "Giriş Başarılı"
                              : "Kayıt Başarılı",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.white, fontSize: 20)),
                ),
                const SizedBox(
                  width: 10,
                ),
                errorMessage.isNotEmpty
                    ? const SizedBox()
                    : Lottie.asset("assets/json/completed.json"),
              ],
            ),
          ),
        )
      : const SizedBox();
}
