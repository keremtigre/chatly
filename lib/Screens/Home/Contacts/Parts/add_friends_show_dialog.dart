part of contacts.dart;

class AddFriendWidget extends StatefulWidget {
  const AddFriendWidget({
    required this.contacts,
    Key? key,
  }) : super(key: key);

  final List<Contacts> contacts;

  @override
  State<AddFriendWidget> createState() => _AddFriendWidgetState();
}

class _AddFriendWidgetState extends State<AddFriendWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        return Form(
          key: context.read<ContactsCubit>().formKey,
          child: AlertDialog(
            title: const Text('Add Contact'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _searchFriendTextFormField(context),
                const SizedBox(
                  height: 5,
                ),
                _errorText(context)
              ],
            ),
            actions: _actionButtons(context, widget.contacts),
          ),
        );
      },
    );
  }

  //Action Buttons

  List<Widget> _actionButtons(BuildContext context, List<Contacts> contacts) {
    return <Widget>[
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: const Text('Cancel'),
        onPressed: () {
          context.router.pop();
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        onPressed: () async {
          await context
              .read<ContactsCubit>()
              .addFriendMethod(context, contacts);
        },
        child: const Text('Add'),
      ),
    ];
  }

  //Error Text Widget

  _errorText(BuildContext context) {
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        return SizedBox(
            width: context.width,
            height: 50,
            child: state is ContactsError
                ? AutoSizeText(
                    state.searchError ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.red, fontSize: 13),
                  )
                : const SizedBox());
      },
    );
  }

  //Search Friend TextFormField Widget

  Container _searchFriendTextFormField(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: context.width / 50),
        child: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            return TextFormField(
              controller: context.read<ContactsCubit>().textEditingController,
              validator: (value) => context.emailValidator(value ?? ""),
              decoration: const InputDecoration()
                  .sendMessageStyle(
                      hintText: "search your contact with e-mail",
                      borderRadius: 10)
                  .copyWith(
                      suffixIcon: state is ContactsError
                          ? const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.done,
                              color: Colors.green,
                            )),
            );
          },
        ));
  }
}
