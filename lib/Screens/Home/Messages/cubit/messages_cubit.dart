import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Screens/Home/Messages/service/chat_message_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());

  TextEditingController textEditingController = TextEditingController();
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid.toString();
  ScrollController scrollController = ScrollController();
  void onSendMessage(BuildContext context, int? type, String peerId) async {
    
    if (textEditingController.text.trim().isNotEmpty) {
      await ChatMessageService().sendMessage(
        type: 0,
        content: textEditingController.text,
        currentUserId: currentUserId ?? "",
        groupChatId: currentUserId.toString() + peerId.toString(),
        peerId: peerId,
      );
      textEditingController.clear();
      // scrollController.animateTo(0,
      //   duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      emit(MessagesInitial());
    } else {
      context.buildScaffoldMessenger(context,
          text: 'Nothing to send', seconds: 2);
    }
  }
}
