part of login.dart;
class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: context.height / 20),
      child: AutoSizeText(
        "Şifreni mi Unuttun?",
        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17),
      ),
    );
  }
}
