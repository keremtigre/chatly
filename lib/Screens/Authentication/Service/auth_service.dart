import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class IFirebaseAuthService {
  Future<String?> signUpWithEmailAndPassword(
      {String name, String? email, String? password});
  Future<String?> loginWithEmailAndPassword({String? email, String? password});
}

class FirebaseAuthService extends IFirebaseAuthService {
  //create FirebaseAuth instance
  final _firebaseAuth = FirebaseAuth.instance;

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
          .then((value) {
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
}
