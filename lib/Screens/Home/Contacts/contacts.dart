library contacts.dart;

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/extansions/text_form_field_extensions.dart';
import 'package:chatly/Product/routes/app_router.dart';
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
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
          title: const AutoSizeText("Kişilerim"),
          centerTitle: false,
        ),
        body: SizedBox(
          width: context.width,
          height: context.height,
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                  alignment: Alignment.centerLeft,
                  child: const AutoSizeText("My Contacts")),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          context.router.push(const MessagesRoute());
                        },
                        title: const AutoSizeText("Ahmet Bey"),
                        leading: ClipOval(
                            child: Image.network(
                          "https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=2000&t=st=1677951687~exp=1677952287~hmac=491ed943f7e0e9032fde6666d377211514cec5884c62d3aedc25e8f1e51fdd28",
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        )),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
