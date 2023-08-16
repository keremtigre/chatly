import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:chatly/Product/theme/colors.dart';
import 'package:flutter/material.dart';

class UserProfilePhotoWidget extends StatelessWidget {
  const UserProfilePhotoWidget(
      {Key? key,
      this.photoUrl = "",
      this.displayName,
      this.file,
      this.isImageTypeFile = false})
      : super(key: key);

  final String? photoUrl;
  final File? file;
  final bool isImageTypeFile;
  final String? displayName;

  @override
  Widget build(BuildContext context) {
    return (photoUrl ?? "").isNotEmpty || isImageTypeFile
        ? ClipOval(
            child: isImageTypeFile
                ? Image.file(
                    file!,
                    fit: BoxFit.cover,
                    width: isImageTypeFile ? 100 : 50.0,
                    height: isImageTypeFile ? 100 : 50.0,
                  )
                : Image.network(
                    photoUrl ?? "",
                    fit: BoxFit.cover,
                    width: 50.0,
                    height: 50.0,
                  ))
        : CircleAvatar(
            radius: 25,
            backgroundColor: const AppColors().platinium,
            child: AutoSizeText(
              displayName?.substring(0, 1) ?? "",
              textAlign: TextAlign.center,
            ),
          );
  }
}
