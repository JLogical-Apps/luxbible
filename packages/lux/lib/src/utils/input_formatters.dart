import 'package:flutter/services.dart';

class RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final int? newNumber = int.tryParse(newValue.text);
    if (newNumber != null && newNumber >= min && newNumber <= max) {
      return newValue;
    }
    return oldValue;
  }
}

class VerseRangeTextInputFormatter extends TextInputFormatter {
  final int max;

  VerseRangeTextInputFormatter({required this.max});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final parts = newValue.text.split('-');
    final isValid =
        RegExp(r'^\d+(?:-\d*)?$').hasMatch(newValue.text) &&
        parts.every((part) {
          if (part.isEmpty) return true;
          final number = int.parse(part);
          return number >= 1 && number <= max;
        });
    return isValid ? newValue : oldValue;
  }
}
