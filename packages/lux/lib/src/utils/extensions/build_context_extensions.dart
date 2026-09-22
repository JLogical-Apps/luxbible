import 'package:flutter/material.dart';
import 'package:lux/src/models/time.dart';
import 'package:lux/src/ui/styled_route.dart';
import 'package:utils_core/utils_core.dart';

extension BuildContextExtensions on BuildContext {
  BuildContext get rootContext => Navigator.of(this, rootNavigator: true).context;
  double get textScaling => MediaQuery.textScalerOf(this).scale(20) / 20;
  TimeFormat get timeFormat => MediaQuery.alwaysUse24HourFormatOf(this) ? .twentyFourHour : .amPm;

  // Pops back to the root instead of replacing it so its reading position and scroll survive.
  void goToRoot({List<StyledRoute<dynamic>> pages = const [], Function(BuildContext)? onLoaded}) {
    final navigator = Navigator.of(this);
    navigator.popUntil((route) => route.isFirst);
    pages.map(getStyledRoute).forEach(navigator.push);
    if (onLoaded != null) WidgetsBinding.instance.addPostFrameCallback((_) => onLoaded(navigator.context));
  }

  Future<T?> push<T>(StyledRoute<T> page) => Navigator.of(this).push(getStyledRoute(page));
  Future<T?> pushReplacement<T>(StyledRoute<T> page) => Navigator.of(this).pushReplacement(getStyledRoute(page));

  Future<T?> pushDialog<T>(StyledRoute<T> page) =>
      Navigator.of(this).push(getStyledRoute(page, isFullscreenDialog: true));

  void maybePop<T>([T? result]) => Navigator.of(this).maybePop(result);
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  String? getValidationError(Object? error) => switch (error) {
    IsNotBlankValidationError() => 'Cannot be blank',
    null => null,
    _ => error.toString(),
  };

  MaterialPageRoute<T> getStyledRoute<T>(StyledRoute<T> page, {bool isFullscreenDialog = false}) =>
      MaterialPageRoute<T>(
        settings: RouteSettings(name: page.path),
        builder: (context) => KeyedSubtree(key: ValueKey(Localizations.localeOf(context)), child: page),
        fullscreenDialog: isFullscreenDialog,
      );
}
