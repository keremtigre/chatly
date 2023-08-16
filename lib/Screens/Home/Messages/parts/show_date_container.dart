part of messages.dart;

class _ShowDateContainer extends StatelessWidget {
  const _ShowDateContainer({
    required this.chatMessages,
  });

  final ChatMessages chatMessages;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: context.width / 5,
      padding: context.paddingAllLow10,
      decoration: BoxDecoration(
          color: const AppColors().nonPhotoBlue,
          borderRadius: BorderRadius.circular(20)),
      child: Text(context.readTimestamp(int.parse(chatMessages.timestamp))),
    );
  }
}
