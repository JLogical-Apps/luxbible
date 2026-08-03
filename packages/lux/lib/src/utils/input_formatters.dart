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
