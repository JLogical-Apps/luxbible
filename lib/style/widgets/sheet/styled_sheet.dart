import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_sheet_navigation_context.dart';
import 'package:bible/style/widgets/styled_chip.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_divider.dart';
import 'package:bible/style/widgets/styled_dock.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intersperse/intersperse.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class StyledSheet<T> extends HookWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;

  final Widget? aboveDivider;
  final bool showDivider;

  final List<Widget> children;

  final Widget? aboveButtons;
  final List<Widget> Function(BuildContext)? buttonsBuilder;

  const StyledSheet({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.aboveDivider,
    this.showDivider = true,
    this.children = const [],
    this.aboveButtons,
    this.buttonsBuilder,
  });

  StyledSheet.child({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.aboveDivider,
    this.showDivider = true,
    required Widget child,
    this.aboveButtons,
    this.buttonsBuilder,
  }) : children = [child];

  @override
  Widget build(BuildContext context) {
    final sheetNavigationContext = context.watch<SheetNavigationBreadcrumbContext?>();

    void navigateToBreadcrumb({required int breadcrumbIndex}) {
      if (sheetNavigationContext == null) {
        return;
      }

      final breadcrumb = sheetNavigationContext.breadcrumbs[breadcrumbIndex];
      context.pop();
      context.showStyledSheet(
        (context) => breadcrumb.sheetBuilder(context),
        wrapper: (sheetBuilder) => Provider.value(
          value: SheetNavigationBreadcrumbContext(
            breadcrumbs: sheetNavigationContext.breadcrumbs.take(breadcrumbIndex + 1).toList(),
          ),
          child: HookBuilder(builder: sheetBuilder),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfacePrimary,
        borderRadius: .vertical(top: .circular(16)),
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          SizedBox(
            height: 12,
            child: Align(
              alignment: .bottomCenter,
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(borderRadius: .circular(999), color: context.colors.borderOpaque),
              ),
            ),
          ),
          gapH8,
          SizedBox(
            height: subtitle == null ? 48 : 52,
            child: Padding(
              padding: .symmetric(horizontal: 8),
              child: Row(
                spacing: 8,
                children: [
                  SizedBox(
                    width: 48,
                    child: Center(
                      child: sheetNavigationContext != null && sheetNavigationContext.breadcrumbs.length > 1
                          ? StyledCircleButton.lg(
                              child: Symbols.arrow_back.toIcon(),
                              onPressed: () =>
                                  navigateToBreadcrumb(breadcrumbIndex: sheetNavigationContext.breadcrumbs.length - 2),
                            )
                          : StyledCircleButton.lg(child: Symbols.close.toIcon(), onPressed: () => context.pop()),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        DefaultTextStyle(
                          style: context.textStyle.headingXs,
                          maxLines: 1,
                          overflow: .ellipsis,
                          child: title,
                        ),
                        if (subtitle case final subtitle?)
                          DefaultTextStyle(
                            style: context.textStyle.paragraphMd.subtle(context),
                            maxLines: 1,
                            overflow: .ellipsis,
                            child: subtitle,
                          ),
                      ],
                    ),
                  ),
                  if (trailing case final trailing?) SizedBox(width: 48, child: trailing) else gapW48,
                ],
              ),
            ),
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
              child: StyledDock(aboveButtons: aboveButtons, buttonsBuilder: buttonsBuilder, children: children),
            ),
          ),
        ],
      ),
    );
  }
}
