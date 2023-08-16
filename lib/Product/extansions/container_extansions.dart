import 'package:flutter/material.dart';

extension ContainerExtansions on Container {
  Container messageBoxStyle(BuildContext context,
      {Widget? child,
      Color? color,
      double? borderRadius,
      double? maxWidth,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 9)),
      padding: padding ?? const EdgeInsets.all(10),
      margin: margin ?? const EdgeInsets.only(top: 20),
      child: child,
    );
  }
}
