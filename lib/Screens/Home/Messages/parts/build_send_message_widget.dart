part of messages.dart;

class _BuildSendMessageWidget extends StatelessWidget {
  const _BuildSendMessageWidget({
    Key? key,
    required this.widget,
    required this.listChatMessages,
  }) : super(key: key);

  final MessagesPage widget;
  final List<ChatMessages> listChatMessages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.only(left: 10, bottom: context.height / 60),
            width: context.width / 2.4,
            child: TextFormField(
              minLines: 1,
              maxLines: 10,
              contextMenuBuilder: (context, editableTextState) {
                return context.menuBuilder(context, editableTextState);
              },
              maxLength: 5000,
              controller: context.read<MessagesCubit>().textEditingController,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 17,
                    color: Colors.white,
                  ),
              decoration:
                  const InputDecoration().sendMessageStyle(borderRadius: 25),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(bottom: context.height / 22),
            child: BlocBuilder<MessagesCubit, MessagesState>(
              builder: (context, state) {
                return ElevatedButton(
                    style: const ButtonStyle().sendMessageButtonStyle(context),
                    onPressed: () {
                      context.read<MessagesCubit>().onSendMessage(
                          context,
                          widget.isFromContactsPage ?? false,
                          0,
                          widget.userId ?? "",
                          widget.groupChatId ?? "",
                          widget.userPhotoUrl ?? "",
                          widget.userName ?? "",
                          widget.currentUserDisplayName ?? "",
                          false,
                          widget.pushToken ?? "",
                          listChatMessages.isEmpty ? true : false);
                    },
                    child: const Icon(Icons.send));
              },
            ),
          ),
        ),
      ],
    );
  }
}
