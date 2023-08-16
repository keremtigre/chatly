
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:flutter/material.dart';

class LoginSignUpPageTitle extends StatelessWidget {
  final String? text;
  const LoginSignUpPageTitle({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: context.height / 9, left: context.width / 60),
          child: AutoSizeText(
            "Hoş Geldin,",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: context.height / 50,
              left: context.width / 60,
              bottom: context.height / 20),
          child: AutoSizeText(
            "Güvenli ve bir o kadar keyifli mesajlaşma için hemen ${text ?? ""}",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
