import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/validator.dart';
import 'package:chatly/Product/models/chat_messages_model.dart';
import 'package:chatly/Product/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  bool checkMessageGroup(
      int index, ChatMessages prevChtMsg, ChatMessages dataChtMsg) {
    final DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(dataChtMsg.timestamp));

    if (index == 0) {
      return false;
    } else {
      final DateTime prevDate =
          DateTime.fromMillisecondsSinceEpoch(int.parse(prevChtMsg.timestamp));
      return isSameDate(date, prevDate);
    }
  }

  bool isSameDate(DateTime data, DateTime prevData) {
    return data.year == prevData.year &&
        data.month == prevData.month &&
        data.day == prevData.day;
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date =
        DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000, isUtc: false);
    var time = '';

    if (now.day == date.day &&
        now.month == date.month &&
        now.year == date.year) {
      time = "Bugün";
    } else {
      if (now.subtract(const Duration(days: 1)).day == date.day &&
          now.month == date.month &&
          now.year == date.year) {
        time = 'Dün';
      } else {
        time = DateFormat('dd.MM.yyyy').format(date);
      }
    }

    return time;
  }

  menuBuilder(BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editable(
      anchors: editableTextState.contextMenuAnchors,
      clipboardStatus: ClipboardStatus.pasteable,
      // to apply the normal behavior when click on copy (copy in clipboard close toolbar)
      // use an empty function `() {}` to hide this option from the toolbar
      onCopy: () =>
          editableTextState.copySelection(SelectionChangedCause.toolbar),
      // to apply the normal behavior when click on cut
      onCut: () =>
          editableTextState.cutSelection(SelectionChangedCause.toolbar),
      onPaste: () {
        // HERE will be called when the paste button is clicked in the toolbar
        // apply your own logic here

        // to apply the normal behavior when click on paste (add in input and close toolbar)
        editableTextState.pasteText(SelectionChangedCause.toolbar);
      },
      // to apply the normal behavior when click on select all
      onSelectAll: () =>
          editableTextState.selectAll(SelectionChangedCause.toolbar),
    );
  }

  showClockFromDatetime(String dateString) {
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(dateString) * 1000,
        isUtc: false);

    return format.format(date);
  }

  //Scaffold messenger
  buildScaffoldMessenger(BuildContext context, {String? text, int? seconds}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: seconds ?? 0),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const AppColors().cerulean,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: AutoSizeText(text ?? "")));

  String getorCreateGroupChatId(String userA, String userB) {
    final userIds = [userA, userB];
    userIds.sort();
    return userIds[0] + userIds[1];
  }
}
