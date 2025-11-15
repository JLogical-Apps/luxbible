import 'package:another_flushbar/flushbar.dart';
import 'package:bible/style/color_library.dart';
import 'package:bible/style/text_style_library.dart';
import 'package:bible/style/widgets/component_size.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

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

  void showStyledSnackbar({required String messageText}) async {
    Flushbar(
      messageText: StyledListItem(
        size: ComponentSize.sm,
        title: Text(messageText, style: textStyle.paragraphMd.copyWith(color: colors.contentPrimaryInverse)),
        leading: SizedBox(
          width: 64,
          height: 64,
          child: Center(child: Icon(Symbols.check_circle, size: 24, color: colors.contentPrimaryInverse)),
        ),
      ),
      duration: Duration(seconds: 3),
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.zero,
      backgroundColor: colors.inverted.surfacePrimary,
      borderRadius: BorderRadius.circular(12),
      shouldIconPulse: false,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      animationDuration: Duration(milliseconds: 300),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(Navigator.of(this, rootNavigator: true).context);
  }
}
