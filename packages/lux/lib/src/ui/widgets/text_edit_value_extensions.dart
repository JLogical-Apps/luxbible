import 'package:flutter/services.dart';
import 'package:lux/src/ui/widgets/text_selection_extensions.dart';

extension TextEditingValueExtensions on TextEditingValue {
  bool get isFullySelected => selection.isFullySelected(text);
}
