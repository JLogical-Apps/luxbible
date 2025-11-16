import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:port/port.dart';
import 'package:provider/provider.dart';

class StyledPortFieldBuilder<T> extends StatelessWidget {
  final String fieldPath;
  final Widget Function(BuildContext context, T value, String? errorText, Function(T) onChanged) builder;

  const StyledPortFieldBuilder({super.key, required this.fieldPath, required this.builder});

  @override
  Widget build(BuildContext context) {
    return PortFieldBuilder<T>(
      fieldPath: fieldPath,
      builder: (context, field, value, error) => builder(context, value, context.getValidationError(error), (newValue) {
        context.read<Port>().setValue(path: fieldPath, value: newValue);
        context.read<Port>().clearError(path: fieldPath);
      }),
    );
  }
}
