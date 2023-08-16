library contacts.dart;

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/extansions/text_form_field_extensions.dart';
import 'package:chatly/Product/models/contacts.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Product/widgets/user_profile_photo_widget.dart';
import 'package:chatly/Screens/Home/Contacts/cubit/contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'Parts/add_friends_show_dialog.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AutoSizeText("Contacts"),
          centerTitle: false,
        ),
        body: _contactsList());
  }

  // CONTACT LIST WIDGET

  BlocProvider<ContactsCubit> _contactsList() {
    return BlocProvider(
      create: (context) => ContactsCubit(),
      child: BlocBuilder<ContactsCubit, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoaded) {
            if (context.read<ContactsCubit>().contacts != null &&
                context.read<ContactsCubit>().contacts!.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () async {
                      final _contacts =
                          context.read<ContactsCubit>().contacts ?? [];
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => ContactsCubit(),
                            child: AddFriendWidget(contacts: _contacts),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: context.paddingAllLow10,
                      child: Row(
                        children: const [
                          Icon(Icons.person_add),
                          SizedBox(
                            width: 10,
                          ),
                          AutoSizeText("Add new contact")
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await context.read<ContactsCubit>().getContacts();
                    },
                    child: Padding(
                      padding: context.paddingAllLow10,
                      child: Row(
                        children: const [
                          Icon(Icons.refresh),
                          SizedBox(
                            width: 10,
                          ),
                          AutoSizeText("Reload contacts")
                        ],
                      ),
                    ),
                  ),
                  Container(
                      padding: context.paddingAllMedium20,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        "My Contacts",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(),
                      )),
                  Expanded(
                      child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: context.read<ContactsCubit>().contacts?.length,
                    itemBuilder: (context, index) {
                      final Contacts? contacts =
                          context.read<ContactsCubit>().contacts?[index];
                      return _UserCard(contacts: contacts);
                    },
                  )),
                ],
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      "Kişi listenizde henüz bir arkadışınız yok.",
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return BlocProvider(
                                create: (context) => ContactsCubit(),
                                child: const AddFriendWidget(contacts: []),
                              );
                            },
                          );
                        },
                        child: const AutoSizeText("Add new contact")),
                    ElevatedButton(
                        onPressed: () async {
                          await context.read<ContactsCubit>().getContacts();
                        },
                        child: const AutoSizeText("Reload contacts"))
                  ],
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// USER CARD WIDGET

class _UserCard extends StatelessWidget {
  const _UserCard({
    Key? key,
    required this.contacts,
  }) : super(key: key);

  final Contacts? contacts;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) async {
        context.read<ContactsCubit>().deleteFriendMethod(contacts);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        padding: context.paddingAllLow10,
        alignment: Alignment.centerRight,
        child: AutoSizeText(
          "Delete",
          textAlign: TextAlign.end,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.red),
        ),
      ),
      key: UniqueKey(),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ListTile(
            onTap: () {
              context.router.push(MessagesRoute(
                  userId: contacts?.id,
                  isFromContactsPage: true,
                  currentUserDisplayName: contacts?.displayName,
                  userPhotoUrl: contacts?.photoUrl,
                  userName: contacts?.displayName));
            },
            title: AutoSizeText(contacts?.displayName ?? ""),
            subtitle: AutoSizeText(
              "Pili bitmek Üzere",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            ),
            leading: UserProfilePhotoWidget(
              displayName: contacts?.displayName,
              photoUrl: contacts?.photoUrl ?? "",
            )),
      ),
    );
  }
}
