import 'package:cloud_firestore/cloud_firestore.dart';

class Contacts {
  String? id;
  String? photoUrl;
  String? displayName;
  String? emailAddress;

  Contacts(
      {required this.id,
      required this.emailAddress,
      required this.photoUrl,
      required this.displayName});

  static Contacts fromDocuments(DocumentSnapshot data) {
    return Contacts(
        id: data["id"],
        emailAddress: data["emailAddress"],
        photoUrl: data["photoUrl"],
        displayName: data["displayName"]);
  }
}
