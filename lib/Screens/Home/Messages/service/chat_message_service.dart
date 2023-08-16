import 'package:chatly/Product/constants/firebase_firestore_const.dart';
import 'package:chatly/Product/extansions/firebase_extansion.dart';
import 'package:chatly/Product/notification_service/firebase_msg.dart';
import 'package:chatly/Product/models/chat_ids_model.dart';
import 'package:chatly/Product/models/chat_messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class IChatMessageService {
  Future<void> sendMessage(
      {required String content,
      required String currentUserId,
      required String peerId,
      required String groupChatId,
      required bool isFirstMessage,
      required bool isFromContactsPage,
      required String peerPhotourl,
      required String peerDisplayName,
      required bool msgRead,
      required String currentUserDisplayName,
      required int type});
  Stream<QuerySnapshot> getChatMessage(
      {required String groupChatId, required int limit});
}

class ChatMessageService extends IChatMessageService {
  final firebaseFirestore = FirebaseFirestore.instance;
  final _msgClc = FirebaseCollections.messages;
  final _usrClc = FirebaseCollections.users;
  final firebaseAuth = FirebaseAuth.instance;

  ChatMessageService._init();
  static ChatMessageService? _instance;
  factory ChatMessageService() => _instance ??= ChatMessageService._init();

//*********** SEND MESSAGE METHOD ************\\
  @override
  Future<void> sendMessage({
    required String content,
    required String currentUserId,
    required bool isFromContactsPage,
    required String peerId,
    required bool isFirstMessage,
    required String groupChatId,
    required String peerPhotourl,
    required String currentUserDisplayName,
    required String peerDisplayName,
    required bool msgRead,
    required int type,
  }) async {
    try {
      //İSTENILEN GROUPCHAT'IN DOC REF'INI GETIRME
      DocumentReference documentReference = _msgClc
          .referenceWithId(groupChatId)
          .doc(Timestamp.now().millisecondsSinceEpoch.toString());

      //MEVCUT SOHBETTEKI VERILERI MODELE ÇEVIRME
      ChatMessages chatMessages = ChatMessages(
          idFrom: currentUserId,
          idTo: peerId,
          msgRead: msgRead,
          timestamp: Timestamp.now().millisecondsSinceEpoch.toString(),
          content: content,
          type: type);

      //ILGILI CHAT'IN VERILERINI FIREBASE'E KAYDETME ISLEMI
      await firebaseFirestore
          .runTransaction((transaction) async => transaction.set(
                documentReference,
                chatMessages.toJson(),
              ));
      DocumentSnapshot response =
          await _usrClc.reference.doc(currentUserId).get();
      if (isFirstMessage) {
        //CURRENT USER MODEL
        ChatIdsModel currentUserChatIdsModel = ChatIdsModel(
            id: groupChatId,
            photoUrl: response.get(FirestoreConst.photoUrl),
            displayName: response.get(FirestoreConst.displayName));

        //PEER USER MODEL
        ChatIdsModel peerChatIdsModel = ChatIdsModel(
            id: groupChatId,
            photoUrl: peerPhotourl,
            displayName: peerDisplayName);

        _usrClc.reference.doc(peerId).update({
          FirestoreConst.chatIdsModel:
              FieldValue.arrayUnion([currentUserChatIdsModel.toMap()])
        });

        _usrClc.reference.doc(currentUserId).update({
          FirestoreConst.chatIdsModel:
              FieldValue.arrayUnion([peerChatIdsModel.toMap()])
        });
      }
      debugPrint("current id: $currentUserId");
      debugPrint("peer id: $peerId");

      //KARŞIDAKI KULLANICIN PUSH TOKEN'I ALMA ISLEMI
      final doc = await _usrClc.reference.doc(peerId).get();
      final token = doc[FirestoreConst.pushToken] ?? "";
      debugPrint("peer token: $token");

      //FCM ILE BILDIRIM GONDERME ISLEMI
      FirebaseMessagingService().sendNotification(currentUserDisplayName,
          content, token, response.get(FirestoreConst.photoUrl));
    } on FirebaseException catch (e) {
      debugPrint("Mesaj Gönderilirken hata oluştu: ${e.message}");
    }
  }

  // ********** GET MESSAGE METHOD ************ \\
  @override
  Stream<QuerySnapshot> getChatMessage(
      {required String groupChatId, required int limit}) {
    return _msgClc
        .referenceWithId(groupChatId)
        .orderBy(FirestoreConst.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }
}
