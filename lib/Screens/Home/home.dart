import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/helper/shared_pref_helper.dart';
import 'package:chatly/Product/notification_manager/ntf_manager.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Screens/Authentication/Service/auth_service.dart';
import 'package:chatly/Screens/Home/Chats/chats.dart';
import 'package:chatly/Screens/Home/Stories/stories.dart';
import 'package:chatly/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _controller =
      TabController(length: 2, vsync: this, initialIndex: 0);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    debugPrint(
        "Received message: ${message.data}"); // Gelen mesajı kontrol etmek için print ekleyin
    // ignore: unnecessary_null_comparison
    if (message != null) {
      debugPrint("Message is not null");
      await NotificationManager.showNotification(message.data);
    } else {
      debugPrint(
          "Message is null"); // Veri null olarak geliyorsa bu mesajı görüntüleyin
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          context.router.push(const ContactsRoute());
        },
      ),
      body: TabBarView(
        controller: _controller,
        children: const [ChatsPage(), StoriesPage()],
      ),
    );
  }

  PreferredSizeWidget homeAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
              await FirebaseAuthService().signOut().then((value) async {
                await PreferenceUtils.removeAll();
                await FirebaseMessaging.instance.deleteToken().then(
                    (value) => context.router.popAndPush(const LoginRoute()));
              });
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
