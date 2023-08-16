import 'package:chatly/Product/constants/firebase_firestore_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  bool msgRead;
  int type;

  ChatMessages(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.msgRead,
      required this.content,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConst.idFrom: idFrom,
      FirestoreConst.idTo: idTo,
      FirestoreConst.msgRead: msgRead,
      FirestoreConst.timestamp: timestamp,
      FirestoreConst.content: content,
      FirestoreConst.type: type,
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get(FirestoreConst.idFrom);
    String idTo = documentSnapshot.get(FirestoreConst.idTo);
    bool msgRead =
        documentSnapshot.data().toString().contains(FirestoreConst.msgRead)
            ? documentSnapshot.get(FirestoreConst.msgRead)
            : false;
    String timestamp = documentSnapshot.get(FirestoreConst.timestamp);
    String content = documentSnapshot.get(FirestoreConst.content);
    int type = documentSnapshot.get(FirestoreConst.type);

    return ChatMessages(
        idFrom: idFrom,
        idTo: idTo,
        msgRead: msgRead,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}
