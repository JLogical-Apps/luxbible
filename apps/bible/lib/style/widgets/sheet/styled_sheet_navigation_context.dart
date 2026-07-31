import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:flutter/material.dart';

class SheetNavigationBreadcrumbContext {
  final List<SheetNavigationBreadcrumb> breadcrumbs;
  final Map<int, double> scrollOffsetByDepth;

  SheetNavigationBreadcrumbContext({required this.breadcrumbs, Map<int, double>? scrollOffsetByDepth})
    : scrollOffsetByDepth = scrollOffsetByDepth ?? {};

  SheetNavigationBreadcrumbContext withBreadcrumb(SheetNavigationBreadcrumb breadcrumb) =>
      SheetNavigationBreadcrumbContext(
        breadcrumbs: [...breadcrumbs, breadcrumb],
        scrollOffsetByDepth: scrollOffsetByDepth,
      );
}

class SheetNavigationBreadcrumb {
  final String text;
  final StyledSheet Function(BuildContext) sheetBuilder;

  const SheetNavigationBreadcrumb({required this.text, required this.sheetBuilder});
}
