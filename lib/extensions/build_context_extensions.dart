import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  Future<T?> push<T>(Widget page, {bool isDialog = false}) => Navigator.of(
    this,
  ).push(MaterialPageRoute(builder: (_) => page, fullscreenDialog: isDialog));
}
