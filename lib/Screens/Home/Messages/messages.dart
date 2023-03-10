import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/button_style_extansions.dart';
import 'package:chatly/Product/extansions/container_extansions.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/extansions/text_form_field_extensions.dart';
import 'package:chatly/Screens/Home/Messages/cubit/messages_cubit.dart';
import 'package:chatly/Screens/Home/Messages/service/chat_message_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesPage extends StatefulWidget {
  final String? userId;
  final String? userName;
  final String? userPhotoUrl;
  const MessagesPage(
      {super.key, this.userId, this.userName, this.userPhotoUrl});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  bool isVisible = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesCubit(),
      child: Scaffold(
          appBar: AppBar(
            leadingWidth: context.width / 30,
            titleSpacing: 0.0,
            centerTitle: false,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
            title: Row(
              children: [
                widget.userPhotoUrl != ""
                    ? ClipOval(
                        child: Image.network(
                        "${widget.userPhotoUrl}",
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                      ))
                    : CircleAvatar(
                        child: AutoSizeText(
                            widget.userName?.substring(0, 1).toUpperCase() ??
                                ""),
                      ),
                SizedBox(
                  width: context.width / 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<MessagesCubit, MessagesState>(
                      builder: (context, state) {
                        return AutoSizeText(
                          widget.userName ?? "",
                          maxLines: 1,
                        );
                      },
                    ),
                    isVisible
                        ? AutoSizeText(
                            "çevrimiçi",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 14, color: Colors.white),
                          )
                        : const SizedBox()
                  ],
                )
              ],
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: ChatMessageService().getChatMessage(
                  groupChatId: widget.userId.toString() +
                      firebaseAuth.currentUser!.uid.toString(),
                  limit: 10),
              builder: (context, snapshot) {
                if (snapshot.hasData || snapshot != null) {
                  return Column(
                    children: [
                      Flexible(
                        child: ListView.builder(
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                index % 2 == 0
                                    ? const SizedBox(width: 10)
                                    : const Spacer(),
                                Expanded(
                                    child: Container().messageBoxStyle(
                                  context,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        messageList[index],
                                        textAlign: TextAlign.start,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: AutoSizeText(
                                              "12:04",
                                              textAlign: TextAlign.end,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.done_all,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                                index % 2 == 1
                                    ? const SizedBox(width: 10)
                                    : const Spacer(),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: context.height / 40,
                            horizontal: context.width / 60),
                        width: context.width,
                        height: context.height / 10,
                        child: Row(
                          children: [
                            SizedBox(
                              width: context.width / 3,
                              child: TextFormField(
                                controller: context
                                    .read<MessagesCubit>()
                                    .textEditingController,
                                decoration:
                                    const InputDecoration().sendMessageStyle(),
                              ),
                            ),
                            const Spacer(),
                            BlocBuilder<MessagesCubit, MessagesState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                    style: const ButtonStyle()
                                        .sendMessageButtonStyle(context),
                                    onPressed: () {
                                      context
                                          .read<MessagesCubit>()
                                          .onSendMessage(
                                              context, 0, widget.userId ?? "");
                                    },
                                    child: const Icon(Icons.send));
                              },
                            ),
                            const Spacer()
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })),
    );
  }

  List<String> messageList = [
    "günaydınn",
    "günaydınn",
    "akşam 8'de yemek "
    /*  "Selam Kerem!",
    "Selam Buse!",
    "Nasılsın?",
    "iyiyim, sen nasılsın?",
    "bende iyiyim",
    "seni seviyorum demek için mesaj attım, ayrıdca çoook ama çook",
    "bende seni seviyorum canımm <333" */
  ];
}
