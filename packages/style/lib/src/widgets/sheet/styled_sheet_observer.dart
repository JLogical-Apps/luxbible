import 'package:flutter/widgets.dart';

// Breadcrumbs change inside a single route, so navigator observers only see the first one.
class StyledSheetObserver extends InheritedWidget {
  final Function(String screenName) onScreenShown;

  const StyledSheetObserver({super.key, required this.onScreenShown, required super.child});

  static String? getScreenName(String? path) => path == null ? null : '/sheet$path';

  static StyledSheetObserver? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<StyledSheetObserver>();

  @override
  bool updateShouldNotify(StyledSheetObserver oldWidget) => false;
}
