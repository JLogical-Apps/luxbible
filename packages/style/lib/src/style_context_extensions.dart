import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Provider;
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:style/src/color_library.dart';
import 'package:style/src/styled_text_action.dart';
import 'package:style/src/text_style_library.dart';
import 'package:style/src/widgets/dialog/styled_dialog.dart';
import 'package:style/src/widgets/sheet/styled_sheet.dart';
import 'package:style/src/widgets/sheet/styled_sheet_navigation_context.dart';
import 'package:style/src/widgets/styled_list_item.dart';
import 'package:style/src/widgets/styled_pill_button.dart';
import 'package:toastification/toastification.dart';

extension StyleContextExtensions on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  ColorLibrary get colors => ColorLibrary(brightness: brightness);

  TextStyleLibrary get textStyle => TextStyleLibrary(colorLibrary: colors);

  Future<T?> showStyledDialog<T>(
    StyledDialog<T> Function(BuildContext context) dialogBuilder, {
    bool isDismissible = true,
  }) => showModalBottomSheet(
    context: this,
    isScrollControlled: true,
    isDismissible: isDismissible,
    shape: RoundedRectangleBorder(borderRadius: .circular(16)),
    enableDrag: false,
    backgroundColor: Colors.transparent,
    useRootNavigator: true,
    constraints: BoxConstraints(
      maxWidth: MediaQuery.sizeOf(rootContext).width - 32,
      maxHeight: MediaQuery.sizeOf(rootContext).height - MediaQuery.viewPaddingOf(rootContext).top - 16,
    ),
    builder: (context) => PopScope(
      canPop: isDismissible,
      child: SafeArea(top: false, bottom: false, child: dialogBuilder(context)),
    ),
  );

  Future<T?> showStyledSheet<T>(
    StyledSheet<T> Function(BuildContext, WidgetRef) sheetBuilder, {
    Widget Function(StyledSheet Function(BuildContext, WidgetRef) sheetBuilder)? wrapper,
  }) => showMaterialModalBottomSheet(
    context: this,
    expand: false,
    isDismissible: true,
    shape: RoundedRectangleBorder(borderRadius: .circular(16)),
    enableDrag: true,
    backgroundColor: Colors.transparent,
    useRootNavigator: true,
    builder: (context) => ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - MediaQuery.viewPaddingOf(context).top - 8,
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: wrapper == null ? HookConsumerBuilder(builder: sheetBuilder) : wrapper(sheetBuilder),
      ),
    ),
  );

  Future<T?> showStyledSheetWithBreadcrumbs<T>(
    StyledSheet<T> Function(BuildContext, WidgetRef) sheetBuilder, {
    required String breadcrumbText,
  }) async {
    final sheetContext = read<SheetNavigationBreadcrumbContext?>() ?? SheetNavigationBreadcrumbContext(breadcrumbs: []);
    return await showMaterialModalBottomSheet(
      context: this,
      expand: false,
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: .circular(16)),
      enableDrag: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      builder: (context) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height - MediaQuery.viewPaddingOf(context).top - 8,
        ),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Provider(
            create: (_) => sheetContext.withBreadcrumb(
              SheetNavigationBreadcrumb(text: breadcrumbText, sheetBuilder: sheetBuilder),
            ),
            child: HookConsumerBuilder(builder: sheetBuilder),
          ),
        ),
      ),
    );
  }

  void showStyledSnackbar({
    required Widget message,
    StyledTextAction? action,
    Duration duration = const Duration(seconds: 3),
  }) {
    toastification.showCustom(
      context: rootContext,
      alignment: .topCenter,
      autoCloseDuration: duration,
      animationDuration: Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) => SlideTransition(
        position: Tween(
          begin: Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic)),
        child: child,
      ),
      builder: (context, toast) => Padding(
        padding: .symmetric(horizontal: 12),
        child: Dismissible(
          key: ValueKey(toast.id),
          direction: .up,
          onDismissed: (_) => toastification.dismiss(toast, showRemoveAnimation: false),
          child: DecoratedBox(
            decoration: BoxDecoration(borderRadius: .circular(12), color: context.colors.inverted.surfacePrimary),
            child: StyledListItem(
              size: .sm,
              title: DefaultTextStyle(
                style: context.textStyle.paragraphMd.copyWith(color: context.colors.contentPrimaryInverse),
                child: message,
              ),
              leading: SizedBox.square(
                dimension: 64,
                child: Center(child: Icon(Symbols.check_circle, size: 24, color: context.colors.contentPrimaryInverse)),
              ),
              trailing: action == null
                  ? null
                  : StyledPillButton.md(
                      label: action.label,
                      colorBuilder: .surfacePrimaryInverted,
                      onPressed: () {
                        toastification.dismiss(toast);
                        action.onPressed();
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
