import 'package:chatly/Product/extansions/validator.dart';
import 'package:flutter/material.dart';

extension ContextExtansions on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.height;

  String? emailValidator(String value) {
    if (value.isEmpty) return "Bu alan boş bırakılamaz";
    if (!value.isValidEmail) return "Geçerli bir mail adresi giriniz";
    return null;
  }

  String? nameValidator(String value) {
    if (value.isEmpty) return "Bu alan boş bırakılamaz";
    final _regExp = RegExp("  ");
    if (_regExp.allMatches(value).length >= 1 || value == " ") {
      return "İsimlerin arasında en fazla 1 boşluk olabil";
    }
    if (value.endsWith(" ")) return "İsminizin sonundaki boşluğu kaldırın";
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "Bu alan boş bırakılamaz";
    } else if (!value.isValidPassword) {
      return "Parolanız en az 8 haneli olmalı ve şunlardan oluşmalı: En az bir büyük harf, bir küçük harf, bir rakam";
    }
    return null;
  }
}
