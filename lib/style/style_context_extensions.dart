import 'package:bible/style/color_library.dart';
import 'package:bible/style/text_style_library.dart';
import 'package:flutter/material.dart';

extension StyleContextExtensions on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  ColorLibrary get colors => ColorLibrary(brightness: brightness);

  TextStyleLibrary get textStyle => TextStyleLibrary(colorLibrary: colors);

  Future<T?> showStyledSheet<T>(Widget sheet) async {
    final rootContext = ScaffoldMessenger.of(this).context;
    return await showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      enableDrag: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(this).width,
        maxHeight: MediaQuery.sizeOf(rootContext).height - MediaQuery.paddingOf(rootContext).top - 8,
      ),
      useRootNavigator: true,
      builder: (context) => sheet,
    );
  }
}
