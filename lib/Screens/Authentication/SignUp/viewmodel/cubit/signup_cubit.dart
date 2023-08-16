import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:chatly/Product/helper/image_selector.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Authentication/Service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final signUpFormKeyFormKey = GlobalKey<FormState>();
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController signUpSurnameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  bool _signUpPasswordVisibility = false;
  bool _privacyPolicyAccepted = false;
  bool get privacyPolicyAccepted => _privacyPolicyAccepted;
  bool get signUpPasswordVisibility => _signUpPasswordVisibility;
  late ImageSelector _imageSelector;
  File? file;
  setPrivacyPolicyAcceptedChoose(bool value) {
    _privacyPolicyAccepted = value;
    emit(SignUpInitial());
  }

  setPasswordVisibility() {
    _signUpPasswordVisibility = !signUpPasswordVisibility;
    emit(SignUpInitial());
  }

  selectProfilePhoto() async {
    _imageSelector = ImageSelector.getInstance();
    file = await _imageSelector.pickImageFromGallery();
    emit(SignUpInitial());
  }

  signUpWithEmailAndPassword(BuildContext context) async {
    bool response = false;
    //form validate
    if (signUpFormKeyFormKey.currentState!.validate() &&
        privacyPolicyAccepted) {
      emit(SignUpLoading());
      //call signupservice method
      firebaseAuthService
          .signUpWithEmailAndPassword(
              email: signUpEmailController.text,
              name: signUpNameController.text,
              password: signUpPasswordController.text)
          .then((value) async {
        if (value == null) {
          Uint8List? fileBytes = file?.readAsBytesSync();
          response = await firebaseAuthService.saveUserDataToService(context,
              name: signUpNameController.text,
              filePath: fileBytes,
              fileName: file?.path,
              surname: signUpSurnameController.text);

          emit(SignUpComplated());
        }
        // if have signup error, show error message
        else {
          emit(SignUpError(errorMessage: value));
        }
        Future.delayed(const Duration(milliseconds: 100)).then((value) {
          if (response) {
            context.router.pushAndPopUntil(
              const HomeRoute(),
              predicate: (route) => false,
            );
          }
        });
      });
    }
  }
}
