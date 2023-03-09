part of contacts.dart;

class AddFriendWidget extends StatefulWidget {
  const AddFriendWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddFriendWidget> createState() => _AddFriendWidgetState();
}

class _AddFriendWidgetState extends State<AddFriendWidget> {
  bool? _isLoading;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<ContactsCubit>().pageOnWillPop();
        setState(() {});
        return Future.value(true);
      },
      child: Form(
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
          actions: _actionButtons(context),
        ),
      ),
    );
  }

  //Action Buttons

  List<Widget> _actionButtons(BuildContext context) {
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
        onPressed: _isLoading ?? false
            ? null
            : () async {
                _isLoading = true;
                setState(() {});
                await context.read<ContactsCubit>().addFriendMethod(context);
                _isLoading = false;
                setState(() {});
              },
        child: _isLoading ?? false
            ? const CircularProgressIndicator()
            : const Text('Add'),
      ),
    ];
  }

  //Error Text Widget

  SizedBox _errorText(BuildContext context) {
    return SizedBox(
        width: context.width,
        height: 50,
        child: context.read<ContactsCubit>().searchedFriendError.isNotEmpty
            ? AutoSizeText(
                context.watch<ContactsCubit>().searchedFriendError,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.red, fontSize: 13),
              )
            : const SizedBox());
  }

  //Search Friend TextFormField Widget

  Container _searchFriendTextFormField(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: context.width / 50),
        child: TextFormField(
          controller: context.read<ContactsCubit>().textEditingController,
          validator: (value) => context.emailValidator(value ?? ""),
          decoration: const InputDecoration()
              .sendMessageStyle(
                  hintText: "search your contact with e-mail", borderRadius: 10)
              .copyWith(
                  suffixIcon: _isLoading == null
                      ? const SizedBox()
                      : _isLoading ?? false
                          ? const SizedBox()
                          : context
                                  .read<ContactsCubit>()
                                  .searchedFriendError
                                  .isNotEmpty
                              ? const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )),
        ));
  }
}
