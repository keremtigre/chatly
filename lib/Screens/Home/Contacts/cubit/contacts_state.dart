part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState {}

class ContactsLoading extends ContactsState {
  ContactsLoading() {
    debugPrint("initial tetiklendi");
  }
}

class ContactsLoaded extends ContactsState {
  ContactsLoaded() {
    debugPrint("loaded tetiklendi");
  }
}

class ContactsError extends ContactsState {
  ContactsError(this.searchError);
  final String? searchError;
}
