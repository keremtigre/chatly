import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/constants/firebase_firestore_const.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/extansions/firebase_extansion.dart';
import 'package:chatly/Product/models/chat_ids_model.dart';
import 'package:chatly/Product/models/chat_messages_model.dart';
import 'package:chatly/Product/models/chat_user_model.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Product/theme/colors.dart';
import 'package:chatly/Screens/Home/Chats/cubit/chats_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final firebaseAuth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: FirebaseCollections.users.reference
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, chatsSnapshots) {
        List<ChatIdsModel> chatIdsModel = [];
        String currentUserDisplayName = "";
        if (chatsSnapshots.hasData) {
          ChatUser chatUser = ChatUser.fromMap(chatsSnapshots.data!.data()!);
          chatIdsModel = chatUser.chatIdsModel ?? [];
          currentUserDisplayName = chatUser.displayName ?? "";
        }
        return chatIdsModel.isNotEmpty
            ? ListView.builder(
                itemCount: chatIdsModel.length,
                itemBuilder: (context, index) {
                  return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseCollections.messages.reference
                          .doc(chatIdsModel[index].id)
                          .collection(chatIdsModel[index].id ?? "")
                          .orderBy(FirestoreConst.timestamp, descending: true)
                          .limit(1)
                          .snapshots(),
                      builder: (context, messageSnapshot) {
                        return BlocProvider(
                          create: (context) => ChatsCubit(),
                          child: BlocConsumer(
                            bloc: ChatsCubit()
                              ..fetchData(messageSnapshot, chatIdsModel, index),
                            listener: (context, state) {
                              if (state is ChatsInitial) {}
                            },
                            builder: (context, state) {
                              return state is ChatsComplated
                                  ? _ChatUserCard(
                                      unrdMsgLst: state.unrdMsgCnt ?? [],
                                      chatIdsModel: chatIdsModel[index],
                                      index: index,
                                      msgRead: state.chatMessages!.msgRead,
                                      peerId: state.chatMessages!.idTo,
                                      currentUserDisplayName:
                                          currentUserDisplayName,
                                      isMessageFromCurrentuser:
                                          state.isMessageFromCurrentuser ??
                                              false,
                                      chatMessages: state.chatMessages)
                                  : Shimmer.fromColors(
                                      baseColor: Colors.white,
                                      highlightColor:
                                          Colors.grey.withOpacity(0.2),
                                      child: const Card(
                                        child: ListTile(),
                                      ),
                                    );
                            },
                          ),
                        );
                      });
                },
              )
            : Container(
                alignment: Alignment.center,
                padding: context.paddingAllLow5,
                child: const AutoSizeText(
                  "Henüz bir sohbetiniz bulunmadı. Yeni bir sohbet oluşturabilrisiniz",
                  textAlign: TextAlign.center,
                ),
              );
      },
    );
  }
}

class _ChatUserCard extends StatelessWidget {
  const _ChatUserCard({
    Key? key,
    required this.chatIdsModel,
    required this.peerId,
    required this.msgRead,
    required this.unrdMsgLst,
    required this.index,
    required this.isMessageFromCurrentuser,
    required this.currentUserDisplayName,
    required this.chatMessages,
  }) : super(key: key);

  final ChatIdsModel chatIdsModel;
  final String peerId;
  final List<int> unrdMsgLst;
  final bool msgRead;
  final int index;
  final String currentUserDisplayName;
  final bool isMessageFromCurrentuser;
  final ChatMessages? chatMessages;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          if (isMessageFromCurrentuser) {
            context.router.push(MessagesRoute(
                userId: peerId,
                groupChatId: chatIdsModel.id,
                currentUserDisplayName: currentUserDisplayName,
                isFromContactsPage: false,
                msgRead: msgRead,
                userName: chatIdsModel.displayName,
                userPhotoUrl: chatIdsModel.photoUrl ?? ""));
          } else {
            await context.read<ChatsCubit>().msgReadUpdate(chatIdsModel).then(
                (value) => context.router.push(MessagesRoute(
                    userId: peerId,
                    groupChatId: chatIdsModel.id,
                    currentUserDisplayName: currentUserDisplayName,
                    isFromContactsPage: false,
                    msgRead: msgRead,
                    userName: chatIdsModel.displayName,
                    userPhotoUrl: chatIdsModel.photoUrl ?? "")));
          }
        },
        title: AutoSizeText(chatIdsModel.displayName ?? ""),
        subtitle: Row(
          children: [
            isMessageFromCurrentuser
                ? Icon(
                    Icons.done_all,
                    color: msgRead ? Colors.blue : Colors.grey,
                  )
                : const SizedBox(),
            isMessageFromCurrentuser
                ? SizedBox(width: context.width / 100)
                : const SizedBox(),
            Expanded(
              child: AutoSizeText(chatMessages?.content ?? "",
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        leading: (chatIdsModel.photoUrl ?? "").isNotEmpty
            ? ClipOval(
                child: Image.network(
                chatIdsModel.photoUrl ?? "",
                fit: BoxFit.cover,
                width: 50.0,
                height: 50.0,
              ))
            : CircleAvatar(
                radius: 25,
                backgroundColor: const AppColors().platinium,
                child: AutoSizeText(
                  chatIdsModel.displayName?.substring(0, 1) ?? "",
                  textAlign: TextAlign.center,
                ),
              ),
        trailing: Column(
          children: [
            AutoSizeText(
                context.readTimestamp(int.parse(chatMessages!.timestamp)),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 15,
                      color: Colors.black87,
                    )),
            const SizedBox(
              height: 10,
            ),
            isMessageFromCurrentuser
                ? const SizedBox()
                : msgRead
                    ? const SizedBox()
                    : CircleAvatar(
                        radius: 13,
                        backgroundColor: const AppColors().berkeleyBlue,
                        child: AutoSizeText(unrdMsgLst[index].toString()),
                      )
          ],
        ),
      ),
    );
  }
}
