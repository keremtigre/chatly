import 'package:chatly/Product/constants/firebase_firestore_const.dart';
import 'package:chatly/Product/models/chat_user_model.dart';
import 'package:chatly/Product/models/contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class IContactsService {
  Future<List<Contacts>?> getContactsFromService();
  Future<bool>? addContact();
  Future<Contacts> searchFriend({required String email});
}

class ContactsService extends IContactsService {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  ContactsService._init();
  static ContactsService? _instance;
  factory ContactsService() => _instance ??= ContactsService._init();

  @override
  Future<bool>? addContact({Contacts? value}) async {
    try {
      final user = Contacts(
          displayName: value?.displayName ?? "",
          emailAddress: value?.emailAddress ?? "",
          id: value?.id ?? "",
          photoUrl: value?.photoUrl ?? "");
      await firebaseFirestore
          .collection(FirestoreConst.collectionPathUser)
          .doc(firebaseAuth.currentUser?.uid)
          .update({
        "contacts": FieldValue.arrayUnion([user.toMap()])
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.message.toString());
    }
    return Future.value(false);
  }

  @override
  Future<Contacts> searchFriend({required String email}) async {
    try {
      final response = await firebaseFirestore
          .collection(FirestoreConst.collectionPathUser)
          .where("emailAddress", isEqualTo: email)
          .get();
      if (response.size > 0) {
        debugPrint(
            "veri eşleşti: ${Contacts.fromMap(response.docs.first.data()).emailAddress}");
        return Contacts.fromMap(response.docs.first.data());
      } else {
        return Contacts.withError(
            errorMessage: "There is no user in this e-mail address.");
      }
    } on FirebaseException catch (e) {
      debugPrint("null error: ${e.message}");
      return Contacts.withError(
          errorMessage: "There is no user in this e-mail address.");
    }
  }

  Future<bool?> deleteFriend(Contacts? deletedFriend) async {
    try {
      await firebaseFirestore
          .collection(FirestoreConst.collectionPathUser)
          .doc(firebaseAuth.currentUser?.uid)
          .update({
        "contacts": FieldValue.arrayRemove([deletedFriend?.toMap()])
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.message.toString());
    }
    return Future.value(false);
  }

  @override
  Future<List<Contacts>?> getContactsFromService() async {
    try {
      final response = await firebaseFirestore
          .collection(FirestoreConst.collectionPathUser)
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      if (response.data()?["contacts"] != null) {
        final chatUser = ChatUser.fromMap(response.data()!);
        return chatUser.contacts;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message.toString());
      return null;
    }
  }
}
