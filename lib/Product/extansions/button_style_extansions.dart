import 'package:chatly/Product/theme/colors.dart';
import 'package:flutter/material.dart';

extension ButtonStyleExtansions on ButtonStyle {
  ButtonStyle sendMessageButtonStyle(BuildContext context) {
    return ButtonStyle(
      shape: MaterialStateProperty.all(const CircleBorder()),
      padding: MaterialStateProperty.all(
          const EdgeInsets.all(17)), // <-- Button color
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return const AppColors().nonPhotoBlue;
        }
        return null; // <-- Splash color
      }),
    );
  }
}
