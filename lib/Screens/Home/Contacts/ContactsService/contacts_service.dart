import 'dart:math';

import 'package:chatly/Product/constants/firebase_firestore_const.dart';
import 'package:chatly/Product/models/contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class IContactsService {
  Future<List<Contacts>>? getContacts();
  Future<bool>? addContact();
}

class ContactsService extends IContactsService {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  ContactsService._init();
  static ContactsService? _instance;
  factory ContactsService() => _instance ??= ContactsService._init();

  @override
  Future<bool>? addContact({String? value}) {
    try {
      firebaseFirestore
          .collection(FirestoreConst.collectionPathUser)
          .doc(firebaseAuth.currentUser?.uid)
          .update({
        "contacts": FieldValue.arrayUnion([
          {
            "name": value.toString(),
            "mail": "a@a.com",
          }
        ])
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      debugPrint(e.message.toString());
    }
    return null;
  }

  @override
  Future<List<Contacts>>? getContacts() async {
    try {
      final response = await firebaseFirestore
          .collection(FirestoreConst.collectionPathUser)
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      List<Contacts> contacts = [];
      return contacts;
    } on FirebaseException catch (e) {
      debugPrint(e.message.toString());
      return [];
    }
  }
}
