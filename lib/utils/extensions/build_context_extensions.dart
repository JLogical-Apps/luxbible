import 'package:flutter/material.dart';
import 'package:utils_core/utils_core.dart';

extension BuildContextExtensions on BuildContext {
  Future<T?> push<T>(Widget page) => Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushDialog<T>(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => page, fullscreenDialog: true));

  void pop() => Navigator.of(this).pop();

  String? getValidationError(Object? error) => switch (error) {
    IsNotBlankValidationError() => 'Cannot be blank',
    _ => null,
  };
}
