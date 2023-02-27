import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:chatly/Product/constants/firebase_firestore_const.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Authentication/Service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final signUpFormKeyFormKey = GlobalKey<FormState>();
  final firebaseFirestore = FirebaseFirestore.instance;
  User? user;
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController signUpSurnameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  bool _signUpPasswordVisibility = false;
  bool _privacyPolicyAccepted = false;
  bool get privacyPolicyAccepted => _privacyPolicyAccepted;
  bool get signUpPasswordVisibility => _signUpPasswordVisibility;

  setPrivacyPolicyAcceptedChoose(bool value) {
    _privacyPolicyAccepted = value;
    emit(SignUpInitial());
  }

  setPasswordVisibility() {
    _signUpPasswordVisibility = !signUpPasswordVisibility;
    emit(SignUpInitial());
  }

  signUpWithEmailAndPassword(BuildContext context) async {
    //form validate
    if (signUpFormKeyFormKey.currentState!.validate() &&
        privacyPolicyAccepted) {
      emit(SignUpLoading());
      await Future.delayed(const Duration(milliseconds: 100));
      //call signupservice method
      await firebaseAuthService
          .signUpWithEmailAndPassword(
              email: signUpEmailController.text,
              name: signUpNameController.text,
              password: signUpPasswordController.text)
          .then((value) async {
        if (value == null) {
          emit(SignUpComplated());
          //if signup succesfull, save user data
          final _user = FirebaseAuth.instance.currentUser;
          firebaseFirestore
              .collection(FirestoreConst.collectionPathUser)
              .doc(_user?.uid)
              .set({
            FirestoreConst.displayName:
                "${signUpNameController.text} ${signUpSurnameController.text}",
            FirestoreConst.photoUrl: _user?.photoURL,
            FirestoreConst.id: _user?.uid,
            FirestoreConst.createdAt:
                DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConst.chattingWith: null
          });
          await Future.delayed(const Duration(milliseconds: 600));
          context.router.pushAndPopUntil(
            HomeRoute(),
            predicate: (route) => false,
          );
        }
        // if have signup error, show error message
        else {
          emit(SignUpError(errorMessage: value));
        }
      });
    }
  }
}
