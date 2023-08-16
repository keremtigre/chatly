class ChatIdsModel {
  String? id;
  String? photoUrl;
  String? displayName;
  String? errorMessage;
  ChatIdsModel.withError({this.errorMessage});

  ChatIdsModel(
      {required this.id,
      required this.photoUrl,
      required this.displayName,});

  static ChatIdsModel fromMap(Map<String, dynamic> data) {
    return ChatIdsModel(
        id: data["id"] ?? "",
        photoUrl: data["photoUrl"] ?? "",
        displayName: data["displayName"] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'displayName': displayName,
    };
  }
}
