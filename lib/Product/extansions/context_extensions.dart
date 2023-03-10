import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/validator.dart';
import 'package:flutter/material.dart';

extension ContextExtansions on BuildContext {
  //mediaquery size
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.height;
  EdgeInsets get paddingAllLow5 => const EdgeInsets.all(5);
  EdgeInsets get paddingAllLow8 => const EdgeInsets.all(8);
  EdgeInsets get paddingAllLow10 => const EdgeInsets.all(10);
  EdgeInsets get paddingAllLow13 => const EdgeInsets.all(13);
  EdgeInsets get paddingAllMedium15 => const EdgeInsets.all(15);
  EdgeInsets get paddingAllMedium20 => const EdgeInsets.all(20);
  EdgeInsets get paddingAllMedium25 => const EdgeInsets.all(25);
  EdgeInsets get paddingAllMedium30 => const EdgeInsets.all(30);

  //valdiator methods
  String? emailValidator(String value) {
    if (value.isEmpty) return "Bu alan boş bırakılamaz";
    if (!value.isValidEmail) return "Geçerli bir mail adresi giriniz";
    return null;
  }

  String? nameValidator(String value) {
    if (value.isEmpty) return "Bu alan boş bırakılamaz";
    final regExp = RegExp("  ");
    if (regExp.allMatches(value).isNotEmpty || value == " ") {
      return "İsimlerin arasında en fazla 1 boşluk olabilir";
    }
    if (value.endsWith(" ")) return "İsminizin sonundaki boşluğu kaldırın";
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "Bu alan boş bırakılamaz";
    } else if (!value.isValidPassword) {
      return "Parolanız en az 8 haneli olmalı ve şunlardan oluşmalı: En az bir büyük harf, bir küçük harf, bir rakam";
    }
    return null;
  }

  //Scaffold messenger
  buildScaffoldMessenger(BuildContext context, {String? text, int? seconds}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: seconds ?? 0),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
          content: AutoSizeText(text ?? "")));
}
