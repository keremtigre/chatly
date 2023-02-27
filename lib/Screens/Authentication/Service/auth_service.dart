import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class IFirebaseAuthService {
  Future<String?> signUpWithEmailAndPassword(
      {String name, String? email, String? password});
  Future<String?> loginWithEmailAndPassword({String? email, String? password});
}

class FirebaseAuthService extends IFirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  User? _user;
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
  }

  @override
  Future<String?> loginWithEmailAndPassword(
      {String? email, String? password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        if (value != null) {
          return null;
        }
      });
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
