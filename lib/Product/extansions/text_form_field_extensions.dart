import 'package:flutter/material.dart';

extension InputDecorationExtansion on InputDecoration {
  InputDecoration sendMessageStyle() {
    return copyWith(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: "Type in your message",
        fillColor: Colors.white70);
  }
}
