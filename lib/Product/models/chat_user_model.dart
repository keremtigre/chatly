import 'package:chatly/Product/models/contacts.dart';

class ChatUser {
  String? id;
  String? photoUrl;
  String? displayName;
  String? emailAddress;
  String? aboutMe;
  List<Contacts>? contacts;

  ChatUser(
      {required this.id,
      required this.emailAddress,
      required this.photoUrl,
      required this.displayName,
      required this.contacts,
      required this.aboutMe});

  static ChatUser fromMap(Map<String, dynamic> data) {
    return ChatUser(
        id: data["id"],
        emailAddress: data["emailAddress"],
        photoUrl: data["photoUrl"],
        displayName: data["displayName"],
        contacts: List<Contacts>.from(data["contacts"].map((item) {
          return Contacts(
              displayName: item["displayName"],
              emailAddress: item["emailAddress"],
              id: item["id"],
              photoUrl: item["photoUrl"]);
        })),
        aboutMe: data["aboutMe"]);
  }
}
