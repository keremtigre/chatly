library login.dart;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Screens/Authentication/Login/viewmodel/cubit/login_cubit.dart';
import 'package:chatly/Screens/Authentication/Widgets/create_auth_text_field.dart';
import 'package:chatly/Screens/Authentication/Widgets/go_login_or_signup_page_text.dart';
import 'package:chatly/Screens/Authentication/Widgets/auth_button.dart';
import 'package:chatly/Screens/Authentication/Widgets/auth_title.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Screens/Authentication/Widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
part 'parts/forgot_password_widget.dart';
part 'parts/login_with_other_platforms.dart';
part 'parts/remember_me_checkbox.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Form(
                key: context.read<LoginCubit>().loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topContainer(context, loginState: state),
                    const LoginSignUpPageTitle(text: "giriş yap !"),
                    emailField(context),
                    passwordField(context),
                    const RememberMeCheckBox(),
                    loginButton(state, context),
                    const ForgotPasswordWidget(),
                    const LoginWithOtherPlatforms(),
                    Padding(
                      padding: (state is LoginComplated || state is LoginError)
                          ? EdgeInsets.only(bottom: context.height / 10)
                          : EdgeInsets.zero,
                      child: const GoLoginOrSignUpPageText(
                        isLoginPage: true,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AuthButton loginButton(LoginState state, BuildContext context) {
    return AuthButton(
                      isLoading: state is LoginLoading ? true : false,
                      color: buttonColor(context, state),
                      text: "Giriş Yap",
                      onPressed: /* state is LoginComplated
                          ? () {}
                          :  */
                          () {
                        context
                            .read<LoginCubit>()
                            .loginWithEmailAndPassword();
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
  }

  Widget passwordField(BuildContext context) {
    return createAuthTextFormField(
                    validator: (value) =>
                        context.passwordValidator(value ?? ""),
                    textEditingController:
                        context.read<LoginCubit>().loginPasswordController,
                    context,
                    showPassword:
                        context.read<LoginCubit>().loginPasswordVisibility,
                    label: "password",
                    hintText: "************",
                    isPasswordText: true,
                    onPressed: () =>
                        context.read<LoginCubit>().setPasswordVisibility(),
                  );
  }

  Widget emailField(BuildContext context) {
    return createAuthTextFormField(
                    validator: (value) => context.emailValidator(value ?? ""),
                    textEditingController:
                        context.read<LoginCubit>().loginEmailController,
                    context,
                    label: "email",
                    hintText: "example@example.com",
                  );
  }

  Color? buttonColor(BuildContext context, LoginState state) {
    if (state is LoginError) {
      return Colors.red;
    } else if (state is LoginComplated) {
      return Colors.green;
    } else {
      return Theme.of(context).primaryColor;
    }
  }
}
