library contacts.dart;

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/extansions/text_form_field_extensions.dart';
import 'package:chatly/Product/models/contacts.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Home/Contacts/cubit/contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'Parts/add_friends_show_dialog.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<ContactsCubit>().getContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // FOR ADD FRIEND
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return const AddFriendWidget();
              },
            );
          },
          child: const Icon(Icons.person_add),
        ),
        appBar: AppBar(
          title: const AutoSizeText("Contacts"),
          centerTitle: false,
        ),
        body: _contactsList());
  }

  // CONTACT LIST WIDGET

  BlocBuilder<ContactsCubit, ContactsState> _contactsList() {
    final contactsCubit = context.read<ContactsCubit>();
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        return contactsCubit.contacts != null &&
                (contactsCubit.contacts?.length ?? 0) > 0
            ? Column(
                children: [
                  Container(
                      padding: context.paddingAllLow10,
                      alignment: Alignment.centerLeft,
                      child: const AutoSizeText("My Contacts")),
                  Expanded(
                      child: ListView.builder(
                    itemCount: contactsCubit.contacts?.length ?? 0,
                    itemBuilder: (context, index) {
                      final Contacts? contacts = contactsCubit.contacts?[index];
                      return _UserCard(contacts: contacts);
                    },
                  )),
                ],
              )
            : const Center(
                child:
                    AutoSizeText("Kişi listenizde henüz bir arkadışınız yok."));
      },
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
        child: ListTile(
          onTap: () {
            context.router.push(const MessagesRoute());
          },
          title: AutoSizeText(contacts?.displayName ?? ""),
          leading: ClipOval(
              child: contacts?.photoUrl != ""
                  ? Image.network(
                      "${contacts?.photoUrl}",
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                    )
                  : CircleAvatar(
                      child: AutoSizeText(
                          "${contacts?.displayName}".substring(0, 1)),
                    )),
        ),
      ),
    );
  }
}
