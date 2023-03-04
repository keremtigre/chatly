import 'package:flutter/material.dart';

extension ButtonStyleExtansions on ButtonStyle {
  ButtonStyle sendMessageButtonStyle(BuildContext context) {
    return ButtonStyle(
      shape: MaterialStateProperty.all(const CircleBorder()),
      padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
      backgroundColor: MaterialStateProperty.all(
          Theme.of(context).primaryColor.withOpacity(0.8)), // <-- Button color
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.red;
        }
        return null; // <-- Splash color
      }),
    );
  }
}
