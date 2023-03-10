import 'package:auto_route/auto_route.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/models/contacts.dart';
import 'package:chatly/Screens/Home/Contacts/ContactsService/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());

  String searchedFriendError = "";
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  List<Contacts>? contacts;

  setSearchedFriendError(String? errorMessage) {
    searchedFriendError = errorMessage ?? "";
    debugPrint("errorMessage: $errorMessage");
  }

  getContacts() async {
    await ContactsService().getContactsFromService().then((value) {
      contacts = value;
    });
    contacts?.sort(
      (a, b) =>
          a.displayName!.toLowerCase().compareTo(b.displayName!.toLowerCase()),
    );
    emit(ContactsInitial());
  }

  pageOnWillPop() {
    formKey.currentState?.reset();
    textEditingController.clear();
    searchedFriendError = "";
  }

  deleteFriendMethod(Contacts? deletedContacts) async {
    final isDeleted =
        await ContactsService().deleteFriend(deletedContacts) ?? false;
    if (isDeleted) {
      contacts?.remove(deletedContacts);
    }
    emit(ContactsInitial());
  }

  addFriendMethod(BuildContext context) async {
    bool userExist = false;
    setSearchedFriendError("");
    if (formKey.currentState!.validate()) {
      contacts?.forEach((element) {
        if (element.emailAddress?.toLowerCase() ==
            textEditingController.text.toLowerCase()) {
          userExist = true;
        }
      });
      if (userExist) {
        searchedFriendError = "User already exist";
      } else {
        await ContactsService()
            .searchFriend(email: textEditingController.text)
            .then((value) {
          if (value.emailAddress?.isEmpty ?? value.errorMessage!.isNotEmpty) {
            setSearchedFriendError(value.errorMessage);
          } else {
            if (value.emailAddress ==
                FirebaseAuth.instance.currentUser?.email) {
              setSearchedFriendError("You cannot add your own e-mail address.");
            } else {
              ContactsService()
                  .addContact(value: value)
                  ?.whenComplete(() async {
                context.buildScaffoldMessenger(context,
                    seconds: 3, text: "The user has been successfully added.");
                await getContacts();
                context.router.pop();
              });
            }
          }
        });
      }
    }
  }
}
