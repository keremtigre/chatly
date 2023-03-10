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
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'Parts/add_friends_show_dialog.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool _isloadingPage = false;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      _isloadingPage = true;
      setState(() {});
      await context.read<ContactsCubit>().getContacts();
      _isloadingPage = false;
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
                      padding: context.paddingAllMedium20,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        "My Contacts",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(),
                      )),
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
            : _isloadingPage
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Center(
                    child: AutoSizeText(
                        "Kişi listenizde henüz bir arkadışınız yok."));
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
        elevation: 0,
        color: Colors.transparent,
        child: ListTile(
            onTap: () {
              context.router.push(MessagesRoute(
                  userId: contacts?.id,
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
