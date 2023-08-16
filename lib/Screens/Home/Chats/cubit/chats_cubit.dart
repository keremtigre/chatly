import 'package:chatly/Product/constants/firebase_firestore_const.dart';
import 'package:chatly/Product/extansions/firebase_extansion.dart';
import 'package:chatly/Product/models/chat_ids_model.dart';
import 'package:chatly/Product/models/chat_messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());
  late ChatMessages? chatMessages;
  late List<int> unrdMsgCnt;
  late bool isShow = false;
  late bool? isMessageFromCurrentuser;
  late List<QueryDocumentSnapshot<Object?>>? listMessages;
  final firebaseAuth = FirebaseAuth.instance.currentUser;
  getCurrentUserSnapshot() {
    return FirebaseCollections.users.reference
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }

  Future<void> fetchData(AsyncSnapshot<QuerySnapshot<Object?>> messageSnapshot,
      List<ChatIdsModel> chatIdsModel, int index) async {
    isShow = false;
    if (messageSnapshot.hasData) {
      listMessages = messageSnapshot.data?.docs;
      chatMessages = ChatMessages.fromDocument(listMessages!.first);

      isMessageFromCurrentuser = chatMessages?.idFrom == firebaseAuth?.uid;
      await calculateUnreadMsg(chatIdsModel, index);
      if (chatMessages != null &&
          listMessages != null &&
          unrdMsgCnt.isNotEmpty) {
        emit(ChatsComplated(
            chatMessages, unrdMsgCnt, isMessageFromCurrentuser, listMessages));
      }
    }
  }

  Future msgReadUpdate(ChatIdsModel chatIdsModel) async {
    try {
      final post = await FirebaseCollections.messages.reference
          .doc(chatIdsModel.id)
          .collection(chatIdsModel.id ?? "")
          .where('msgRead', isEqualTo: false)
          .get()
          .then((QuerySnapshot snapshot) {
        //Here we get the document reference and return to the post variable.
        return snapshot.docs;
      });

      var batch = FirebaseFirestore.instance.batch();
      //Updates the field value, using post as document reference
      for (var element in post) {
        batch.update(element.reference, {'msgRead': true});
      }

      batch.commit();
    } on FirebaseException catch (e) {
      debugPrint(e.message.toString());
    }
  }

  calculateUnreadMsg(List<ChatIdsModel> chatIdsModel, index) async {
    debugPrint("method çalıştı ");
    unrdMsgCnt = List.generate(chatIdsModel.length, (index) => 0);
    late CollectionReference messagesCol;
    messagesCol = FirebaseCollections.messages.reference
        .doc(chatIdsModel[index].id.toString())
        .collection(chatIdsModel[index].id.toString());
    await messagesCol.where('msgRead', isEqualTo: false).get().then((value) {
      return unrdMsgCnt[index] = value.size;
    });
  }

  getLastMessageSnapshot(ChatIdsModel chatIdsModel) {
    final messagesCol = FirebaseCollections.messages.reference
        .doc(chatIdsModel.id)
        .collection(chatIdsModel.id ?? "");
    return messagesCol
        .orderBy(FirestoreConst.timestamp, descending: true)
        .limit(1)
        .snapshots();
  }
}
