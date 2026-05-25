import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:utils_core/utils_core.dart';

class VerseFragment {
  final String text;
  final VerseFragmentStudy? study;

  const VerseFragment({required this.text, this.study});

  String get displayText => text.replaceAll(RegExp(r'[\[\]]'), '').replaceAll(RegExp(r'[{}]'), '');
  bool get isEmptyText =>
      ['-', 'vvv', '. . .'].containsAny([text.trim(), text.trim().trimTrailingPunctuation()]) ||
      text.trimPunctuation().isBlank;
}

class VerseFragmentStudy {
  final int originalPosition;
  final String? inflection;
  final String? strongId;
  final String? morphology;

  const VerseFragmentStudy({required this.originalPosition, required this.inflection, this.strongId, this.morphology});
}
