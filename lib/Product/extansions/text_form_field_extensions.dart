import 'package:flutter/material.dart';

extension InputDecorationExtansion on InputDecoration {
  InputDecoration sendMessageStyle({
    String? hintText,
    bool? filled,
    double? borderRadius,
  }) {
    return copyWith(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
      ),
      filled: filled ?? true,
      hintStyle: TextStyle(color: Colors.grey[800]),
      hintText: hintText ?? "Type in your message",
      fillColor: Colors.white70,
    );
  }
}
