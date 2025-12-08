import 'package:utils_core/utils_core.dart';

extension StringExtensions on String {
  String? get nullIfEmpty => isEmpty ? null : this;
  String? get nullIfBlank => isBlank ? null : this;
}
