import 'package:flutter/material.dart';
import 'package:lux/src/models/time.dart';
import 'package:utils_core/utils_core.dart';

extension BuildContextExtensions on BuildContext {
  BuildContext get rootContext => Navigator.of(this, rootNavigator: true).context;
  double get textScaling => MediaQuery.textScalerOf(this).scale(20) / 20;
  TimeFormat get timeFormat => MediaQuery.alwaysUse24HourFormatOf(this) ? .twentyFourHour : .amPm;

  Future<void> go(Widget page) =>
      Navigator.of(this).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => page), (_) => false);

  void goToStack(List<Widget> pages, {Function(BuildContext)? onLoaded}) {
    if (pages.isEmpty) throw ArgumentError.value(pages, 'pages', 'must not be empty');

    final navigator = Navigator.of(this);
    navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (_) => pages.first), (_) => false);
    pages.skip(1).forEach((page) => navigator.push(MaterialPageRoute(builder: (_) => page)));
    if (onLoaded != null) WidgetsBinding.instance.addPostFrameCallback((_) => onLoaded(navigator.context));
  }

  Future<T?> push<T>(Widget page) => Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  Future<T?> pushReplacement<T>(Widget page) =>
      Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushDialog<T>(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => page, fullscreenDialog: true));

  void maybePop<T>([T? result]) => Navigator.of(this).maybePop(result);
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  String? getValidationError(Object? error) => switch (error) {
    IsNotBlankValidationError() => 'Cannot be blank',
    null => null,
    _ => error.toString(),
  };
}
