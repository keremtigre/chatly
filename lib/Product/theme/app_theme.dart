import 'package:chatly/Product/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatAppTheme {
  static const colors = AppColors();
  const ChatAppTheme._();

  static ThemeData define() {
    final defaulColor = colors.berkeleyBlue;
    return ThemeData(
        primaryColor: colors.berkeleyBlue,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(backgroundColor: defaulColor)),
        appBarTheme: AppBarTheme(
          backgroundColor: defaulColor,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 2,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: defaulColor,
        ),
        //fontFamily: 'Montserrat',
        textTheme: GoogleFonts.openSansTextTheme(),
        unselectedWidgetColor: defaulColor);
  }
}
