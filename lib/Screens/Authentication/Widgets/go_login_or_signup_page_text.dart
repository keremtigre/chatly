import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GoLoginOrSignUpPageText extends StatelessWidget {
  final bool isLoginPage;
  const GoLoginOrSignUpPageText({Key? key, this.isLoginPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: context.height / 20),
      child: AutoSizeText.rich(
        TextSpan(
          text: isLoginPage ? "Hesabın yok mu? " : "Zaten bir hesabım var. ",
          children: [
            TextSpan(
                text: !isLoginPage ? "Giriş yap" : "Kayıt ol",
                recognizer: TapGestureRecognizer()
                  ..onTap = () => isLoginPage
                      ? context.pushRoute(const SignUpRoute())
                      : Navigator.pop(context),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 17)),
          ],
        ),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 17),
      ),
    );
  }
}
