import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  messages,
  users;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);

  CollectionReference referenceWithId(String id) =>
      FirebaseFirestore.instance.collection(name).doc(id).collection(id);
}
