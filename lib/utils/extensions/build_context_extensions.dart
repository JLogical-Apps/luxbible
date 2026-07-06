import 'package:flutter/material.dart';
import 'package:utils_core/utils_core.dart';

extension BuildContextExtensions on BuildContext {
  BuildContext get rootContext => Navigator.of(this, rootNavigator: true).context;

  Future<void> go(Widget page) =>
      Navigator.of(this).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => page), (_) => false);

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
