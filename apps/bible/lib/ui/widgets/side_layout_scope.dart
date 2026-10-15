import 'package:flutter/material.dart';

class SideLayoutScope extends StatelessWidget {
  final Widget child;

  const SideLayoutScope({super.key, required this.child});

  static bool isSideLayoutOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SideLayoutInheritedWidget>()?.isSideLayout ??
      _isSideLayoutForMediaQuery(context);

  static bool _isSideLayoutForMediaQuery(BuildContext context) =>
      MediaQuery.sizeOf(context).width - MediaQuery.viewPaddingOf(context).horizontal >= 700;

  @override
  Widget build(BuildContext context) =>
      SideLayoutInheritedWidget(isSideLayout: _isSideLayoutForMediaQuery(context), child: child);
}

class SideLayoutInheritedWidget extends InheritedWidget {
  final bool isSideLayout;

  const SideLayoutInheritedWidget({super.key, required this.isSideLayout, required super.child});

  @override
  bool updateShouldNotify(SideLayoutInheritedWidget oldWidget) => isSideLayout != oldWidget.isSideLayout;
}
