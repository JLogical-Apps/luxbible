import 'package:flutter/material.dart';

class SheetNavigationContext {
  final List<SheetNavigationBreadcrumb> breadcrumbs;

  const SheetNavigationContext({required this.breadcrumbs});

  SheetNavigationContext withBreadcrumb(SheetNavigationBreadcrumb breadcrumb) =>
      SheetNavigationContext(breadcrumbs: [...breadcrumbs, breadcrumb]);
}

class SheetNavigationBreadcrumb {
  final String text;
  final Widget Function(BuildContext) sheetBuilder;

  const SheetNavigationBreadcrumb({required this.text, required this.sheetBuilder});
}

class SheetNavigationContextProvider extends InheritedWidget {
  final SheetNavigationContext context;

  const SheetNavigationContextProvider({super.key, required super.child, required this.context});

  static SheetNavigationContextProvider? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SheetNavigationContextProvider>();

  @override
  bool updateShouldNotify(SheetNavigationContextProvider old) => old.context != context;
}
