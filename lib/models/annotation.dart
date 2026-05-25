import 'package:bible/models/bible/display/bible.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'annotation.freezed.dart';
part 'annotation.g.dart';

@freezed
sealed class Annotation with _$Annotation {
  const Annotation._();

  const factory Annotation({
    @JsonKey(readValue: _annotationSelectionFromAnnotation) required AnnotationSelection selection,
    @Default(ColorEnum.stone) ColorEnum color,
    @Default('') String note,
  }) = _Annotation;

  factory Annotation.fromJson(Map<String, dynamic> json) => _$AnnotationFromJson(json);

  VerseSelection? get verseSelection => selection.as<VersesAnnotationSelection>()?.verseSelection;
  BibleTextSelection? get textSelection => selection.as<TextAnnotationSelection>()?.textSelection;

  String formatSelection(DisplayBible bible) => switch (selection) {
    VersesAnnotationSelection s => s.verseSelection.format(),
    TextAnnotationSelection s => s.textSelection.format(bible),
  };

  String formatLocation() => switch (selection) {
    VersesAnnotationSelection s => s.verseSelection.format(),
    TextAnnotationSelection s => s.textSelection.verseSelection.format(),
  };
}

@freezed
sealed class AnnotationSelection with _$AnnotationSelection {
  const AnnotationSelection._();

  const factory AnnotationSelection.verses({required VerseSelection verseSelection}) = VersesAnnotationSelection;
  const factory AnnotationSelection.text({required BibleTextSelection textSelection}) = TextAnnotationSelection;

  factory AnnotationSelection.fromJson(Map<String, dynamic> json) => _$AnnotationSelectionFromJson(json);
}

Map<String, dynamic> _annotationSelectionFromAnnotation(Map data, String key) {
  final selection = data['selection'];
  if (selection != null) {
    return selection;
  }

  final verseSelections = data['verseSelections'];
  if (verseSelections is List && verseSelections.isNotEmpty) {
    return AnnotationSelection.verses(verseSelection: VerseSelection.fromJson(verseSelections.first)).toJson();
  }

  final textSelections = data['textSelections'];
  if (textSelections is List && textSelections.isNotEmpty) {
    return AnnotationSelection.text(textSelection: BibleTextSelection.fromJson(textSelections.first)).toJson();
  }

  throw ArgumentError('Invalid Annotation parsing: $data');
}
