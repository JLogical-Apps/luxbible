import 'package:flutter/material.dart';

class StyledListItemContext extends InheritedWidget {
  final bool hideDivider;

  const StyledListItemContext({super.key, required this.hideDivider, required super.child});

  static StyledListItemContext? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StyledListItemContext>();

  static StyledListItemContext of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No StyledListItemContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(StyledListItemContext oldWidget) => oldWidget.hideDivider != hideDivider;
}
