import 'package:chatly/Product/theme/colors.dart';
import 'package:flutter/material.dart';

extension InputDecorationExtansion on InputDecoration {
  InputDecoration sendMessageStyle({
    String? hintText,
    bool? filled,
    double? borderRadius,
  }) {
    return copyWith(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(
          borderRadius ?? 20.0,
        ),
      ),
      filled: filled ?? true,
      hintStyle: const TextStyle(color: Colors.white54),
      hintText: hintText ?? "Type in your message",
      fillColor: const AppColors().berkeleyBlue,
    );
  }
}
