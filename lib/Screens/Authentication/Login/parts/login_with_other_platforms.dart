part of login.dart;
class LoginWithOtherPlatforms extends StatelessWidget {
  const LoginWithOtherPlatforms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.height / 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          createLoginPlatformButtons(context, "assets/svg/auth_facebook.svg"),
          createLoginPlatformButtons(context, "assets/svg/auth_google.svg"),
          createLoginPlatformButtons(context, "assets/svg/auth_apple.svg"),
        ],
      ),
    );
  }
}




Widget createLoginPlatformButtons(BuildContext context, String path) {
  return SizedBox(
      height: context.height / 14,
      width: context.width / 9,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.white),
          onPressed: () {},
          child: SvgPicture.asset(path)));
}
