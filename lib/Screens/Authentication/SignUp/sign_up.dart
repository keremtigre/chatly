library sign_up.dart;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/validator.dart';
import 'package:chatly/Screens/Authentication/Login/viewmodel/cubit/login_cubit.dart';
import 'package:chatly/Screens/Authentication/SignUp/viewmodel/cubit/signup_cubit.dart';
import 'package:chatly/Screens/Authentication/Widgets/create_auth_text_field.dart';
import 'package:chatly/Screens/Authentication/Widgets/go_login_or_signup_page_text.dart';
import 'package:chatly/Screens/Authentication/Widgets/auth_title.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Screens/Authentication/Widgets/auth_button.dart';
import 'package:chatly/Screens/Authentication/Widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
part 'parts/signup_checkbox.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
/*               if (state is SignUpError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage.toString())));
              } */
            },
            builder: (context, state) {
              return Form(
                key: context.read<SignUpCubit>().signUpFormKeyFormKey,
                onChanged: () => context
                    .read<SignUpCubit>()
                    .signUpFormKeyFormKey
                    .currentState
                    ?.validate(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topContainer(context, signUpState: state),
                    const LoginSignUpPageTitle(text: "Kayıt ol !"),
                    createAuthTextFormField(
                      context,
                      textEditingController:
                          context.read<SignUpCubit>().signUpNameController,
                      validator: (value) => context.nameValidator(value ?? ""),
                      label: "name",
                      hintText: "name",
                    ),
                    createAuthTextFormField(
                      context,
                      label: "surname",
                      textEditingController:
                          context.read<SignUpCubit>().signUpSurnameController,
                      validator: (value) => context.nameValidator(value ?? ""),
                      hintText: "surname",
                    ),
                    createAuthTextFormField(
                      context,
                      label: "email",
                      textEditingController:
                          context.read<SignUpCubit>().signUpEmailController,
                      validator: (value) => context.emailValidator(value ?? ""),
                      hintText: "example@example.com",
                    ),
                    createAuthTextFormField(
                      context,
                      label: "password",
                      hintText: "******",
                      textEditingController:
                          context.read<SignUpCubit>().signUpPasswordController,
                      validator: (value) =>
                          context.passwordValidator(value ?? ""),
                      isPasswordText: true,
                    ),
                    const SignUpCheckBox(),
                    AuthButton(
                      isLoading: state is SignUpLoading ? true : false,
                      color: buttonColor(context, state),
                      onPressed: /* ß */ () async {
                        await context
                            .read<SignUpCubit>()
                            .signUpWithEmailAndPassword(context);
                      },
                      text: "Kayıt ol",
                    ),
                    SizedBox(
                      height: context.height / 30,
                    ),
                    Center(
                      child: context.read<SignUpCubit>().privacyPolicyAccepted
                          ? SizedBox()
                          : Text("* Gizlilik Politikasını kabul etmediniz.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: context.height / 30,
                    ),
                    const GoLoginOrSignUpPageText(),
                    SizedBox(
                      height: context.height / 30,
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

  Color? buttonColor(BuildContext context, SignUpState state) {
    if (state is SignUpError) {
      return Colors.red;
    } else if (state is SignUpComplated) {
      return Colors.green;
    } else {
      return Theme.of(context).primaryColor;
    }
  }
}
