import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/extansions/context_extensions.dart';
import 'package:flutter/material.dart';

class UserProfilePhotoWidget extends StatelessWidget {
  const UserProfilePhotoWidget({Key? key, this.photoUrl = "", this.displayName})
      : super(key: key);

  final String? photoUrl;
  final String? displayName;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: context.paddingAllLow5,
        alignment: Alignment.center,
        width: 70.0,
        height: 90.0,
        decoration: BoxDecoration(
            color: photoUrl == ""
                ? Theme.of(context).primaryColor.withOpacity(0.6)
                : Colors.transparent,
            shape: BoxShape.circle,
            image: photoUrl != ""
                ? DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(photoUrl ?? ""))
                : null),
        child: photoUrl == ""
            ? AutoSizeText("${displayName?.toUpperCase()}".substring(0, 1))
            : const SizedBox());
  }
}
