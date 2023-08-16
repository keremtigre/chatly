import 'package:chatly/Product/models/chat_ids_model.dart';
import 'package:chatly/Product/models/contacts.dart';

class ChatUser {
  String? id;
  String? photoUrl;
  String? displayName;
  String? emailAddress;
  String? pushToken;
  String? aboutMe;
  List<Contacts>? contacts;
  List<ChatIdsModel>? chatIdsModel;

  ChatUser(
      {required this.id,
      required this.emailAddress,
      required this.photoUrl,
      required this.pushToken,
      required this.displayName,
      required this.chatIdsModel,
      required this.contacts,
      required this.aboutMe});

  static ChatUser fromMap(Map<String, dynamic> data) {
    return ChatUser(
        id: data["id"],
        pushToken: data["pushToken"],
        chatIdsModel: data["chatIdsModel"] != null
            ? List<ChatIdsModel>.from(data["chatIdsModel"].map((item) {
                return ChatIdsModel(
                    id: item["id"],
                    photoUrl: item["photoUrl"],
                    displayName: item["displayName"]);
              }))
            : [],
        emailAddress: data["emailAddress"] ?? "",
        photoUrl: data["photoUrl"] ?? "",
        displayName: data["displayName"] ?? "",
        contacts: data["contacts"] != null
            ? List<Contacts>.from(data["contacts"].map((item) {
                return Contacts(
                    displayName: item["displayName"],
                    emailAddress: item["emailAddress"],
                    id: item["id"],
                    photoUrl: item["photoUrl"]);
              }))
            : [],
        aboutMe: data["aboutMe"] ?? "");
  }
}
