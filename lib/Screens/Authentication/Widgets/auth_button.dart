import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AuthButton extends StatelessWidget {
  final void Function() onPressed;
  final String? text;
  final Color? color;
  final bool isLoading;
  const AuthButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
    this.color,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.width / 20),
      height: context.height / 20,
      width: context.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: const StadiumBorder(),
              elevation: 20,
              shadowColor: Theme.of(context).primaryColor),
          onPressed: onPressed,
          child: (isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(
                  animating: true,
                  color: Colors.white,
                ))
              : AutoSizeText(text ?? ""))),
    );
  }
}
