import 'package:chatly/Product/constants/firebase_firestore_const.dart';
import 'package:chatly/Product/models/chat_messages_model.dart';
import 'package:chatly/Product/models/chat_user_model.dart';
import 'package:chatly/Product/models/contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class IChatMessageService {
  Future<void> sendMessage(
      {required String content,
      required String currentUserId,
      required String peerId,
      required String groupChatId,
      required int type});
  Stream<QuerySnapshot> getChatMessage(
      {required String groupChatId, required int limit});
}

class ChatMessageService extends IChatMessageService {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  ChatMessageService._init();
  static ChatMessageService? _instance;
  factory ChatMessageService() => _instance ??= ChatMessageService._init();

//         SEND MESSAGE METHOD     \\

  @override
  Future<void> sendMessage({
    required String content,
    required String currentUserId,
    required String peerId,
    required String groupChatId,
    required int type,
  }) async {
    try {
      
      DocumentReference documentReference = firebaseFirestore
          .collection(FirestoreConst.collectionPathMessages)
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(Timestamp.now().millisecondsSinceEpoch.toString());
      ChatMessages chatMessages = ChatMessages(
          idFrom: currentUserId,
          idTo: peerId,
          timestamp: Timestamp.now().millisecondsSinceEpoch.toString(),
          content: content,
          type: type);
      await firebaseFirestore.runTransaction((transaction) async =>
          transaction.set(documentReference, chatMessages.toJson()));
    } on FirebaseException catch (e) {
      debugPrint("Mesaj Gönderilirken hata oluştu: ${e.message}");
    }
  }

  //         GET MESSAGE METHOD         \\

  @override
  Stream<QuerySnapshot> getChatMessage(
      {required String groupChatId, required int limit}) {
    return firebaseFirestore
        .collection(FirestoreConst.collectionPathMessages)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConst.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }
}
