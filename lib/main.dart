import 'package:chatly/Product/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter _approuter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Chatly',
      theme: lightThemeData(context),
      routerDelegate: _approuter.delegate(),
      routeInformationParser: _approuter.defaultRouteParser(),
    );
  }

  ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 2,
        ),
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: MaterialColor(0xff0584FE, color),
        unselectedWidgetColor: Theme.of(context).primaryColor);
  }

  Map<int, Color> color = {
    50: const Color(0xff0584FE).withOpacity(.1),
    100: const Color(0xff0584FE).withOpacity(.2),
    200: const Color(0xff0584FE).withOpacity(.3),
    300: const Color(0xff0584FE).withOpacity(.4),
    400: const Color(0xff0584FE).withOpacity(.5),
    500: const Color(0xff0584FE).withOpacity(.6),
    600: const Color(0xff0584FE).withOpacity(.7),
    700: const Color(0xff0584FE).withOpacity(.8),
    800: const Color(0xff0584FE).withOpacity(.9),
    900: const Color(0xff0584FE),
  };
}
