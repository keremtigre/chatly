part of messages.dart;

class _BuildMessagesListView extends StatefulWidget {
  const _BuildMessagesListView({
    Key? key,
    required this.listChatMessages,
    required this.firebaseAuth,
  }) : super(key: key);

  final List<ChatMessages> listChatMessages;
  final FirebaseAuth firebaseAuth;

  @override
  State<_BuildMessagesListView> createState() => _BuildMessagesListViewState();
}

class _BuildMessagesListViewState extends State<_BuildMessagesListView> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<MessagesCubit>().scrollDown();
    });
  }

  bool isSameDate = true;
  int cycle = 0;
  ChatMessages? prevChatMessages;
  ChatMessages? chatMessages;
  bool? isMessageFromCurrentuser;
  @override
  Widget build(BuildContext context) {
    return widget.listChatMessages.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              controller: context.read<MessagesCubit>().controller,
              itemCount: widget.listChatMessages.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                cycle++;
                debugPrint("cycle sayısı: $cycle");
                //group list by date and check is message from current user ?
                groupListByDate(index);
                //check messages group
                if (index == 0 || !(isSameDate)) {
                  return Column(
                    children: [
                      _ShowDateContainer(chatMessages: chatMessages!),
                      _MessageCard(
                          isMessageFromCurrentuser:
                              isMessageFromCurrentuser ?? false,
                          chatMessages: chatMessages!)
                    ],
                  );
                } else {
                  return _MessageCard(
                      isMessageFromCurrentuser:
                          isMessageFromCurrentuser ?? false,
                      chatMessages: chatMessages!);
                }
              },
            ),
          )
        : const Expanded(
            child: Center(
              child: AutoSizeText("Not Found Messages"),
            ),
          );
  }

  groupListByDate(int index) {
    isSameDate = true;

    if (index == 0) {
      prevChatMessages =
          widget.listChatMessages[widget.listChatMessages.length - index - 1];
    } else {
      prevChatMessages =
          widget.listChatMessages[widget.listChatMessages.length - index];
    }
    //sponse data convert -> ChatUserModel...
    chatMessages =
        widget.listChatMessages[widget.listChatMessages.length - index - 1];
    isSameDate =
        context.checkMessageGroup(index, prevChatMessages!, chatMessages!);
    //check is message from Current user
    isMessageFromCurrentuser =
        chatMessages?.idFrom == widget.firebaseAuth.currentUser?.uid;
  }
}
