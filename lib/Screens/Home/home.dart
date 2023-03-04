import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Home/Chats/chats.dart';
import 'package:chatly/Screens/Home/Stories/stories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _controller =
      TabController(length: 2, vsync: this, initialIndex: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                context.router.pushAndPopUntil(
                  LoginRoute(),
                  predicate: (route) => false,
                );
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
      ),
      body: TabBarView(
        controller: _controller,
        children: [ChatsPage(), StoriesPage()],
      ),
    );
  }
}
