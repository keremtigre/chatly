import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/models/chat_messages_model.dart';
import 'package:chatly/Screens/Home/Messages/messages.dart';
import 'package:chatly/Screens/Home/Messages/service/chat_message_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());
  TextEditingController textEditingController = TextEditingController();
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid.toString();
  final firebaseFirestore = FirebaseFirestore.instance;
  List<String> userIds = [];
  List<ChatMessages> listChatMessages = [];
  final ScrollController controller = ScrollController();

  Stream<QuerySnapshot<Object?>> getMessagesSnapshot(
      BuildContext context, MessagesPage widget,
      {int? msgLmt}) {
    return ChatMessageService().getChatMessage(
        groupChatId: (widget.isFromContactsPage ?? false)
            ? context.getorCreateGroupChatId(
                currentUserId ?? "", widget.userId ?? "")
            : widget.groupChatId ?? "",
        limit: 200);
  }

  initValue(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<ChatMessages> listChatMessages = snapshot.hasData
        ? snapshot.data!.docs
            .map((doc) => ChatMessages.fromDocument(doc))
            .toList()
        : [];

    emit(MessagesLoaded(listChatMessages));
  }

  void onSendMessage(
      BuildContext context,
      bool isFromContactsPage,
      int? type,
      String peerId,
      String groupChatId,
      String peerPhotoUrl,
      String peerDisplayName,
      String currentUserDisplayName,
      bool msgRead,
      String peerToken,
      bool isFirstMessage) async {
    if (textEditingController.text.trim().isNotEmpty) {
      await ChatMessageService().sendMessage(
        type: 0,
        isFromContactsPage: isFromContactsPage,
        peerDisplayName: peerDisplayName,
        peerPhotourl: peerPhotoUrl,
        content: textEditingController.text,
        currentUserDisplayName: currentUserDisplayName,
        currentUserId: currentUserId ?? "",
        isFirstMessage: isFirstMessage,
        msgRead: msgRead,
        groupChatId: isFromContactsPage
            ? context.getorCreateGroupChatId(currentUserId ?? "", peerId)
            : groupChatId,
        peerId: peerId,
      );

      textEditingController.clear();
      await scrollDown();

      // scrollController.animateTo(0,
      //   duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      emit(MessagesInitial());
    } else {
      context.buildScaffoldMessenger(context,
          text: 'Nothing to send', seconds: 1);
    }
  }

  Future<void> scrollDown() async {
    if (controller.hasClients) {
      await controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 10),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
