import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:flutter/material.dart';

class SheetNavigationBreadcrumbContext {
  final List<SheetNavigationBreadcrumb> breadcrumbs;

  const SheetNavigationBreadcrumbContext({required this.breadcrumbs});

  SheetNavigationBreadcrumbContext withBreadcrumb(SheetNavigationBreadcrumb breadcrumb) =>
      SheetNavigationBreadcrumbContext(breadcrumbs: [...breadcrumbs, breadcrumb]);
}

class SheetNavigationBreadcrumb {
  final String text;
  final StyledSheet Function(BuildContext) sheetBuilder;

  const SheetNavigationBreadcrumb({required this.text, required this.sheetBuilder});
}
