part of 'messages_cubit.dart';

abstract class MessagesState {
  MessagesState();
}

class MessagesInitial extends MessagesState {
  MessagesInitial();
}

class MessagesLoaded extends MessagesState {
  MessagesLoaded(this.listChatMessages);
  final List<ChatMessages> listChatMessages;
}
