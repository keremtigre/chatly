import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:flutter/material.dart';

Widget createAuthTextFormField(
  BuildContext context, {
  String? label,
  String? hintText,
  bool isPasswordText = false,
  bool showPassword = false,
  String? Function(String?)? validator,
  TextEditingController? textEditingController,
  void Function()? onPressed,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.width / 50,
    ),
    child: TextFormField(
      validator: validator,
      controller: textEditingController,
      keyboardType: TextInputType.text,
      obscureText: isPasswordText ? !showPassword : false,
      decoration: InputDecoration(
        errorMaxLines: 5,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        hintText: hintText,
        labelText: label,
        suffixIcon: isPasswordText
            ? IconButton(
                onPressed: onPressed,
                icon: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility),
                color: Theme.of(context).primaryColor,
              )
            : null,
      ),
    ),
  );
}
