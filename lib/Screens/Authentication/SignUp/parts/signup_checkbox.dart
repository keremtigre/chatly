part of sign_up.dart;

class SignUpCheckBox extends StatelessWidget {
  const SignUpCheckBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: context.height / 40,
          top: context.height / 60,
          left: context.width / 100,
          right: context.width / 100),
      child: Row(
        children: [
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return Checkbox(
                tristate: false,
                shape: const CircleBorder(),
                checkColor: Theme.of(context).primaryColor,
                activeColor: Colors.transparent,
                value: context.read<SignUpCubit>().privacyPolicyAccepted,
                onChanged: (value) => context
                    .read<SignUpCubit>()
                    .setPrivacyPolicyAcceptedChoose(value ?? false),
              );
            },
          ),
          Expanded(
            child: AutoSizeText(
              "Gizlilik politikası ve sözleşmesini okudum ve kabul ediyorum",
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
