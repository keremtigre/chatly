import 'package:chatly/Product/models/contacts.dart';

class ChatUser {
  final String id;
  final String photoUrl;
  final String displayName;
  final String emailAddress;
  final String aboutMe;
  final List<Contacts> contacts;

  const ChatUser(
      {required this.id,
      required this.emailAddress,
      required this.photoUrl,
      required this.displayName,
      required this.contacts,
      required this.aboutMe});
}
