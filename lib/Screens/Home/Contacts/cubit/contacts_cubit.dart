import 'package:auto_route/auto_route.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/models/contacts.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Home/Contacts/ContactsService/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsLoading()) {
    getContacts();
  }

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  List<Contacts>? contacts;

  Future<void> getContacts() async {
    await ContactsService().getContactsFromService().then((value) {
      contacts = value;
    });
    contacts?.sort(
      (a, b) =>
          a.displayName!.toLowerCase().compareTo(b.displayName!.toLowerCase()),
    );
    debugPrint("initial contacts leng: ${contacts?.length}");
    emit(ContactsLoaded());
  }

  pageOnWillPop(BuildContext context) {
    formKey.currentState?.reset();
    textEditingController.clear();
    context.router.pop();
    context.buildScaffoldMessenger(context,
        seconds: 3, text: "The user has been successfully added.");
  }

  deleteFriendMethod(Contacts? deletedContacts) async {
    final isDeleted =
        await ContactsService().deleteFriend(deletedContacts) ?? false;
    if (isDeleted) {
      contacts?.remove(deletedContacts);
    }
    emit(ContactsLoaded());
  }

  addFriendMethod(BuildContext context, List<Contacts> contactsData) async {
    if (formKey.currentState!.validate()) {
      debugPrint("add friend contacts leng: ${contactsData.length}");
      bool userExist = false;
      await Future.delayed(
        const Duration(milliseconds: 200),
        () {
          contactsData.forEach((element) {
            if (element.emailAddress?.toLowerCase() ==
                textEditingController.text.toLowerCase()) {
              userExist = true;
            }
          });
        },
      );
      if (userExist) {
        emit(ContactsError("User already exist"));
      } else {
        await ContactsService()
            .searchFriend(email: textEditingController.text)
            .then((value) async {
          if (value.emailAddress?.isEmpty ?? value.errorMessage!.isNotEmpty) {
            emit(ContactsError(value.errorMessage));
          } else {
            if (value.emailAddress ==
                FirebaseAuth.instance.currentUser?.email) {
              emit(ContactsError("You cannot add your own e-mail address."));
            } else {
              contacts = [];
              await ContactsService().addContact(value: value)?.then((value) {
                pageOnWillPop(context);
              });
            }
          }
        });
      }
    }
  }
}
