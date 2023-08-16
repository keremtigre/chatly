part of 'chats_cubit.dart';

@immutable
abstract class ChatsState {}

class ChatsInitial extends ChatsState {
  ChatsInitial();
}

class ChatsComplated extends ChatsState {
  ChatsComplated(this.chatMessages, this.unrdMsgCnt,
      this.isMessageFromCurrentuser, this.listMessages);
  final ChatMessages? chatMessages;
  final List<int>? unrdMsgCnt;
  final bool? isMessageFromCurrentuser;
  final List<QueryDocumentSnapshot<Object?>>? listMessages;
}
