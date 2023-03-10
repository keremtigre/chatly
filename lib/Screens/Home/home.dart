import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Authentication/Service/auth_service.dart';
import 'package:chatly/Screens/Home/Chats/chats.dart';
import 'package:chatly/Screens/Home/Messages/service/chat_message_service.dart';
import 'package:chatly/Screens/Home/Stories/stories.dart';
import 'package:flutter/material.dart';

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
    super.initState();
    ChatMessageService().sendMessage(
        content: "kerem nasılsın",
        currentUserId: "A",
        peerId: "B",
        groupChatId: "AB",
        type: 0);
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
              context.router.pushAndPopUntil(const LoginRoute(),
                  predicate: (route) => false);
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
