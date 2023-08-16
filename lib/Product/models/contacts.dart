class Contacts {
  String? id;
  String? photoUrl;
  String? displayName;
  String? emailAddress;
  String? errorMessage;
  Contacts.withError({this.errorMessage});
  Contacts(
      {required this.id,
      required this.emailAddress,
      required this.photoUrl,
      required this.displayName});

  static Contacts fromMap(Map<String, dynamic> data) {
    return Contacts(
        id: data["id"] ?? "",
        emailAddress: data["emailAddress"] ?? "",
        photoUrl: data["photoUrl"] ?? "",
        displayName: data["displayName"] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'emailAddress': emailAddress,
    };
  }
}
