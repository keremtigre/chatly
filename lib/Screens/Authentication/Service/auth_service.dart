import 'dart:typed_data';

import 'package:chatly/Product/constants/firebase_firestore_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class IFirebaseAuthService {
  Future<String?> signUpWithEmailAndPassword({
    String name,
    String? email,
    String? password,
  });
  Future<String?> loginWithEmailAndPassword({
    String? email,
  });
}

class FirebaseAuthService extends IFirebaseAuthService {
  //create FirebaseAuth instance
  final _firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  //
  User? _user;

  //17-21 build singleton class
  FirebaseAuthService._initFirebaseAuthService();
  static FirebaseAuthService? _instance;
  factory FirebaseAuthService() =>
      _instance ??= FirebaseAuthService._initFirebaseAuthService();

//Firebase signup method
  @override
  Future<String?> signUpWithEmailAndPassword(
      {String? name, String? email, String? password}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        _user = value.user;
      });
      _user?.updateDisplayName(name);
      _user?.reload();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

//firebase login method
  @override
  Future<String?> loginWithEmailAndPassword(
      {String? email, String? password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection(FirestoreConst.collectionPathUser)
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .update({"pushToken": await FirebaseMessaging.instance.getToken()});
        return null;
      });
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<void> signOut({String? email, String? password}) async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //SIGNUP METHOD
  Future<bool> saveUserDataToService(BuildContext context,
      {String? name,
      String? surname,
      String? fileName,
      Uint8List? filePath}) async {
    String? photoUrl;
    try {
      if (filePath != null) {
        photoUrl = await uploadFile(filePath, fileName) ?? "";
        debugPrint("photoUrl: $photoUrl");
      }

      firebaseFirestore
          .collection(FirestoreConst.collectionPathUser)
          .doc(_firebaseAuth.currentUser?.uid)
          .set({
        FirestoreConst.displayName: "$name $surname",
        FirestoreConst.photoUrl: photoUrl,
        FirestoreConst.id: _firebaseAuth.currentUser?.uid,
        FirestoreConst.contacts: null,
        "chatIdsModel": [],
        "pushToken": await FirebaseMessaging.instance.getToken(),
        FirestoreConst.emailAddress: _firebaseAuth.currentUser?.email,
        FirestoreConst.createdAt:
            DateTime.now().millisecondsSinceEpoch.toString(),
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<String?> uploadFile(
    Uint8List? filePath,
    String? fileName,
  ) async {
    String? photoDownUrl;
    try {
      await FirebaseStorage.instance
          .ref()
          .child(fileName ?? "")
          .putData(filePath!)
          .then((p0) async {
        photoDownUrl = await p0.ref.getDownloadURL();
      });
      return photoDownUrl;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
