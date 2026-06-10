import 'package:another_flushbar/flushbar.dart';
import 'package:bible/style/color_library.dart';
import 'package:bible/style/text_style_library.dart';
import 'package:bible/style/widgets/component_size.dart';
import 'package:bible/style/widgets/dialog/styled_dialog.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/sheet/styled_sheet_navigation_context.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

extension StyleContextExtensions on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  ColorLibrary get colors => ColorLibrary(brightness: brightness);

  TextStyleLibrary get textStyle => TextStyleLibrary(colorLibrary: colors);

  Future<T?> showStyledDialog<T>(StyledDialog<T> Function(BuildContext context) dialogBuilder) async {
    return await showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: .circular(16)),
      enableDrag: false,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(this).width - 32,
        maxHeight: MediaQuery.sizeOf(this).height - 48,
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: dialogBuilder(context),
      ),
    );
  }

  Future<T?> showStyledSheet<T>(
    StyledSheet<T> Function(BuildContext context) sheetBuilder, {
    Widget Function(StyledSheet Function(BuildContext) sheetBuilder)? wrapper,
  }) async {
    final rootContext = ScaffoldMessenger.of(this).context;
    return await showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: .circular(16)),
      enableDrag: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(this).width,
        maxHeight: MediaQuery.sizeOf(rootContext).height - MediaQuery.paddingOf(rootContext).top - 8,
      ),
      useRootNavigator: true,
      builder: wrapper == null ? (context) => HookBuilder(builder: sheetBuilder) : (context) => wrapper(sheetBuilder),
    );
  }

  Future<T?> showStyledSheetWithBreadcrumbs<T>(
    StyledSheet<T> Function(BuildContext) sheetBuilder, {
    required String breadcrumbText,
  }) async {
    final rootContext = ScaffoldMessenger.of(this).context;
    final sheetContext = read<SheetNavigationBreadcrumbContext?>() ?? SheetNavigationBreadcrumbContext(breadcrumbs: []);

    return await showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: .circular(16)),
      enableDrag: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(this).width,
        maxHeight: MediaQuery.sizeOf(rootContext).height - MediaQuery.paddingOf(rootContext).top - 8,
      ),
      useRootNavigator: true,
      builder: (context) => Provider.value(
        value: sheetContext.withBreadcrumb(SheetNavigationBreadcrumb(text: breadcrumbText, sheetBuilder: sheetBuilder)),
        child: HookBuilder(builder: sheetBuilder),
      ),
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
      margin: .all(16),
      padding: .zero,
      backgroundColor: colors.inverted.surfacePrimary,
      borderRadius: .circular(12),
      shouldIconPulse: false,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      animationDuration: Duration(milliseconds: 300),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(Navigator.of(this, rootNavigator: true).context);
  }
}
