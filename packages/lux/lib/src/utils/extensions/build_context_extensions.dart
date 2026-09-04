import 'package:flutter/material.dart';
import 'package:lux/src/models/time.dart';
import 'package:lux/src/ui/styled_route.dart';
import 'package:utils_core/utils_core.dart';

extension BuildContextExtensions on BuildContext {
  BuildContext get rootContext => Navigator.of(this, rootNavigator: true).context;
  double get textScaling => MediaQuery.textScalerOf(this).scale(20) / 20;
  TimeFormat get timeFormat => MediaQuery.alwaysUse24HourFormatOf(this) ? .twentyFourHour : .amPm;

  Future<T?> go<T>(StyledRoute<T> page) => Navigator.of(this).pushAndRemoveUntil(getStyledRoute(page), (_) => false);

  void goToStack(List<StyledRoute<dynamic>> pages, {Function(BuildContext)? onLoaded}) {
    if (pages.isEmpty) throw ArgumentError.value(pages, 'pages', 'must not be empty');

    final navigator = Navigator.of(this);
    navigator.pushAndRemoveUntil(getStyledRoute(pages.first), (_) => false);
    pages.skip(1).forEach((page) => navigator.push(getStyledRoute(page)));
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
