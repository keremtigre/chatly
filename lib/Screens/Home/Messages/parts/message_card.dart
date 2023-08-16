part of messages.dart;

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    required this.isMessageFromCurrentuser,
    required this.chatMessages,
  });

  final bool isMessageFromCurrentuser;
  final ChatMessages chatMessages;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(
            text:
                "message: ${chatMessages.content}\n message Date: ${DateTime.fromMillisecondsSinceEpoch(int.parse(chatMessages.timestamp))}"));
        context.buildScaffoldMessenger(context,
            seconds: 2, text: "The message has been copied to the clipboard.");
      },
      child: Container(
        padding: EdgeInsets.only(
            left: isMessageFromCurrentuser ? context.width * 0.09 : 14,
            right: !isMessageFromCurrentuser ? context.width * 0.09 : 14,
            top: 10,
            bottom: 10),
        child: Align(
          alignment: (isMessageFromCurrentuser
              ? Alignment.topRight
              : Alignment.topLeft),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (!isMessageFromCurrentuser
                  ? const AppColors().platinium
                  : const AppColors().berkeleyBlue),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AutoSizeText(
                  chatMessages.content,
                  style: isMessageFromCurrentuser
                      ? const TextStyle(color: Colors.white)
                      : null,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AutoSizeText(
                      context.showClockFromDatetime((chatMessages.timestamp)),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: !isMessageFromCurrentuser
                              ? Colors.black
                              : Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    !isMessageFromCurrentuser
                        ? const SizedBox()
                        : Icon(Icons.done_all,
                            color: chatMessages.msgRead
                                ? Colors.blue
                                : Colors.white)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
