import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intersperse/intersperse.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart' as provider;
import 'package:style/src/gap.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/widgets/sheet/styled_sheet_header.dart';
import 'package:style/src/widgets/sheet/styled_sheet_navigation_context.dart';
import 'package:style/src/widgets/styled_chip.dart';
import 'package:style/src/widgets/styled_circle_button.dart';
import 'package:style/src/widgets/styled_divider.dart';
import 'package:style/src/widgets/styled_dock.dart';

class StyledSheet<T> extends HookConsumerWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final Widget? aboveDivider;
  final bool showDivider;
  final bool showDragHandle;

  final Key? childrenKey;
  final List<Widget> Function(BuildContext, WidgetRef) childrenBuilder;
  final Widget Function(BuildContext, Widget child) childrenWrapper;

  final Widget? aboveButtons;
  final List<Widget> Function(BuildContext)? buttonsBuilder;

  final bool shrinkWrap;
  final bool forceHeight;
  final ScrollController? controller;

  StyledSheet({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.aboveDivider,
    this.showDivider = true,
    this.showDragHandle = true,
    this.childrenKey,
    List<Widget> children = const [],
    Widget Function(BuildContext, Widget child)? childrenWrapper,
    this.aboveButtons,
    this.buttonsBuilder,
    this.shrinkWrap = true,
    this.forceHeight = false,
    this.controller,
  }) : childrenBuilder = ((context, ref) => children),
       childrenWrapper = childrenWrapper ?? ((context, child) => child);

  StyledSheet.child({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.aboveDivider,
    this.showDivider = true,
    this.showDragHandle = true,
    this.childrenKey,
    required Widget child,
    Widget Function(BuildContext, Widget child)? childrenWrapper,
    this.aboveButtons,
    this.buttonsBuilder,
    this.shrinkWrap = true,
    this.forceHeight = false,
    this.controller,
  }) : childrenBuilder = ((context, ref) => [child]),
       childrenWrapper = childrenWrapper ?? ((context, child) => child);

  StyledSheet.builder({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.aboveDivider,
    this.showDivider = true,
    this.showDragHandle = true,
    this.childrenKey,
    required this.childrenBuilder,
    Widget Function(BuildContext, Widget child)? childrenWrapper,
    this.aboveButtons,
    this.buttonsBuilder,
    this.shrinkWrap = true,
    this.forceHeight = false,
    this.controller,
  }) : childrenWrapper = childrenWrapper ?? ((context, child) => child);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = childrenBuilder(context, ref);

    final sheetNavigationContext = context.watch<SheetNavigationBreadcrumbContext?>();

    final depth = (sheetNavigationContext?.breadcrumbs.length ?? 1) - 1;

    final scrollController = controller ?? ModalScrollController.of(context);

    useOnListenableChange(scrollController, () {
      if (scrollController != null && scrollController.hasClients && sheetNavigationContext != null) {
        sheetNavigationContext.scrollOffsetByDepth[depth] = scrollController.offset;
      }
    });

    useOneTimeEffect(() {
      final saved = sheetNavigationContext?.scrollOffsetByDepth[depth] ?? 0;
      if (saved > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController != null && scrollController.hasClients) {
            scrollController.jumpTo(saved);
          }
        });
      }
    });

    void navigateToBreadcrumb({required int breadcrumbIndex}) {
      if (sheetNavigationContext == null) {
        return;
      }

      final breadcrumb = sheetNavigationContext.breadcrumbs[breadcrumbIndex];
      context.pop();
      context.showStyledSheet(
        (context) => breadcrumb.sheetBuilder(context),
        wrapper: (sheetBuilder) => provider.Provider.value(
          value: SheetNavigationBreadcrumbContext(
            breadcrumbs: sheetNavigationContext.breadcrumbs.take(breadcrumbIndex + 1).toList(),
            scrollOffsetByDepth: sheetNavigationContext.scrollOffsetByDepth.withRemoved(depth),
          ),
          child: HookBuilder(builder: sheetBuilder),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfacePrimary,
        borderRadius: showDragHandle ? .vertical(top: .circular(16)) : .circular(16),
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          StyledSheetHeader(
            title: title,
            subtitle: subtitle,
            leading:
                leading ??
                SizedBox(
                  width: 48,
                  child: Center(
                    child: sheetNavigationContext != null && sheetNavigationContext.breadcrumbs.length > 1
                        ? StyledCircleButton.md(
                            child: Symbols.arrow_back.toIcon(),
                            onPressed: () =>
                                navigateToBreadcrumb(breadcrumbIndex: sheetNavigationContext.breadcrumbs.length - 2),
                          )
                        : StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: () => context.pop()),
                  ),
                ),
            trailing: trailing,
            showDragHandle: showDragHandle,
          ),
          gapH8,
          if (sheetNavigationContext != null && sheetNavigationContext.breadcrumbs.length > 1) ...[
            SingleChildScrollView(
              scrollDirection: .horizontal,
              padding: .symmetric(horizontal: 16),
              reverse: true,
              child: Row(
                spacing: 4,
                children: sheetNavigationContext.breadcrumbs
                    .mapIndexed<Widget>(
                      (i, breadcrumb) => StyledChip(
                        onPressed: i + 1 == sheetNavigationContext.breadcrumbs.length
                            ? null
                            : () => navigateToBreadcrumb(breadcrumbIndex: i),
                        child: Text(breadcrumb.text),
                      ),
                    )
                    .intersperse(Icon(Symbols.chevron_right, color: context.colors.contentTertiary, size: 16))
                    .toList(),
              ),
            ),
            gapH8,
          ],
          ?aboveDivider,
          if (showDivider) StyledDivider(height: 2),
          Flexible(
            child: DefaultTextStyle(
              style: context.textStyle.paragraphMd,
              child: childrenWrapper(
                context,
                StyledDock(
                  key: childrenKey,
                  controller: scrollController,
                  aboveButtons: aboveButtons,
                  buttonsBuilder: buttonsBuilder,
                  children: children,
                  shrinkWrap: shrinkWrap,
                  forceHeight: forceHeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
