import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:chatly/Product/extansions/text_form_field_extensions.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Home/Contacts/ContactsService/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _dialogBuilder(context);
/*             showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  width: context.width,
                  child: AlertDialog(
                    title: AutoSizeText("Add Contact"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.width / 50),
                            child: TextFormField(
                              decoration: InputDecoration().sendMessageStyle(
                                  hintText: "search your contact with e-mail",
                                  borderRadius: 10),
                            ))
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: null,
                        child: AutoSizeText("Cancel"),
                      ),
                      TextButton(onPressed: null, child: AutoSizeText("Add")),
                    ],
                  ),
                );
              },
            ); */
          },
          child: Icon(Icons.person_add),
        ),
        appBar: AppBar(
          title: AutoSizeText("Kişilerim"),
          centerTitle: false,
        ),
        body: SizedBox(
          width: context.width,
          height: context.height,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                  alignment: Alignment.centerLeft,
                  child: const AutoSizeText("My Contacts")),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          context.router.push(MessagesRoute());
                        },
                        title: AutoSizeText("Ahmet Bey"),
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

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: context.width / 50),
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration().sendMessageStyle(
                        hintText: "search your contact with e-mail",
                        borderRadius: 10),
                  ))
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                context.router.pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add'),
              onPressed: () async {
                await ContactsService()
                    .addContact(value: _textEditingController.text);
              },
            ),
          ],
        );
      },
    );
  }
}
