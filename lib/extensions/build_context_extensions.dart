import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  Future<T?> push<T>(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
}
