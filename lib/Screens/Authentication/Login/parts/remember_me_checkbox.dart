part of login.dart;

class RememberMeCheckBox extends StatelessWidget {
  const RememberMeCheckBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: context.height / 40,
          top: context.height / 60,
          left: context.width / 100),
      child: Row(
        children: [
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Checkbox(
                  tristate: false,
                  shape: const CircleBorder(),
                  checkColor: Theme.of(context).primaryColor,
                  activeColor: Colors.transparent,
                  value: context.read<LoginCubit>().rememberMe,
                  onChanged: (value) => context
                      .read<LoginCubit>()
                      .setRememberMeChoose(value ?? false));
            },
          ),
          AutoSizeText(
            "Beni Hatırla",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
          )
        ],
      ),
    );
  }
}
