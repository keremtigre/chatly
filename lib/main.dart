import 'package:chatly/Product/helper/shared_pref_helper.dart';
import 'package:chatly/Product/notification_manager/ntf_manager.dart';
import 'package:chatly/Product/routes/app_router.dart';
import 'package:chatly/Product/theme/app_theme.dart';
import 'package:chatly/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  await PreferenceUtils.init();
  NotificationManager().initialize();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter _approuter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Chatly',
      theme: ChatAppTheme.define(),
      routerDelegate: _approuter.delegate(),
      routeInformationParser: _approuter.defaultRouteParser(),
    );
  }
}
