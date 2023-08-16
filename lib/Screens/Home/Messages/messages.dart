library messages.dart;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/button_style_extansions.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/extansions/text_form_field_extensions.dart';
import 'package:chatly/Product/models/chat_messages_model.dart';
import 'package:chatly/Product/theme/colors.dart';
import 'package:chatly/Screens/Home/Messages/cubit/messages_cubit.dart';
import 'package:chatly/Screens/Home/Messages/service/chat_message_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
part 'parts/build_messages_list_view.dart';
part 'parts/build_send_message_widget.dart';
part 'parts/messages_app_bar.dart';
part 'parts/show_date_container.dart';
part 'parts/message_card.dart';

class MessagesPage extends StatefulWidget {
  final String? userId;
  final bool? msgRead;
  final String? groupChatId;
  final String? userName;
  final String? userPhotoUrl;
  final String? currentUserDisplayName;
  final String? pushToken;
  final bool? isFromContactsPage;
  const MessagesPage(
      {super.key,
      this.userId,
      this.msgRead,
      this.currentUserDisplayName,
      this.pushToken,
      this.groupChatId,
      this.isFromContactsPage,
      this.userName,
      this.userPhotoUrl});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesCubit(),
      child: Scaffold(
          appBar: _MessagesPageAppBar(widget: widget),
          body: StreamBuilder<QuerySnapshot>(
              stream: ChatMessageService().getChatMessage(
                  groupChatId: (widget.isFromContactsPage ?? false)
                      ? context.getorCreateGroupChatId(
                          firebaseAuth.currentUser?.uid ?? "",
                          widget.userId ?? "")
                      : widget.groupChatId ?? "",
                  limit: 20),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BlocBuilder<MessagesCubit, MessagesState>(
                    bloc: MessagesCubit()..initValue(snapshot),
                    builder: (context, state) {
                      return state is MessagesLoaded
                          ? Column(
                              children: [
                                _BuildMessagesListView(
                                    listChatMessages: state.listChatMessages,
                                    firebaseAuth: firebaseAuth),
                                _BuildSendMessageWidget(
                                    widget: widget,
                                    listChatMessages: state.listChatMessages)
                              ],
                            )
                          : const Center(child: CircularProgressIndicator());
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })),
    );
  }
}
