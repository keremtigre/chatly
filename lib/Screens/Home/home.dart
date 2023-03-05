import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/models/contacts.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Authentication/Service/auth_service.dart';
import 'package:chatly/Screens/Home/Chats/chats.dart';
import 'package:chatly/Screens/Home/Contacts/ContactsService/contacts_service.dart';
import 'package:chatly/Screens/Home/Stories/stories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _controller =
      TabController(length: 2, vsync: this, initialIndex: 0);
  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      List<Contacts> contacts = await ContactsService().getContacts() ?? [];
      debugPrint(
          "user 1: ${contacts[0].displayName},${contacts[0].emailAddress}, ${contacts[0].id} ");
      debugPrint(
          "user 1: ${contacts[1].displayName},${contacts[1].emailAddress}, ${contacts[1].id} ");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: TabBarView(
        controller: _controller,
        children: const [ChatsPage(), StoriesPage()],
      ),
    );
  }

  PreferredSizeWidget homeAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () async {
              await FirebaseAuthService().signOut();
              context.router
                  .pushAndPopUntil(LoginRoute(), predicate: (route) => false);
            },
            icon: const Icon(Icons.more_vert))
      ],
      centerTitle: false,
      title: const AutoSizeText(
        "Chatly",
      ),
      bottom: TabBar(controller: _controller, tabs: const [
        Tab(
          child: AutoSizeText("Messages"),
        ),
        Tab(
          child: Text("Stories"),
        ),
      ]),
    );
  }
}
