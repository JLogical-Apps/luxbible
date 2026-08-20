import 'package:flutter/services.dart';

extension TextSelectionExtensions on TextSelection {
  bool isFullySelected(String text) => baseOffset == 0 && extentOffset == text.length;
}
