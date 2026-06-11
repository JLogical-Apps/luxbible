import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/utils/comparable_operators.dart';
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
    required DateTime createdAt,
  }) = _Annotation;

  factory Annotation.fromJson(Map<String, dynamic> json) => _$AnnotationFromJson(json);

  VerseSelection? get verseSelection => selection.as<VersesAnnotationSelection>()?.verseSelection;
  BibleTextSelection? get textSelection => selection.as<TextAnnotationSelection>()?.textSelection;

  String formatLocation() => switch (selection) {
    VersesAnnotationSelection s => s.verseSelection.format(),
    TextAnnotationSelection s => 'Text in ${s.textSelection.toVerseSelection().format()}',
  };
}

@freezed
sealed class AnnotationSelection with _$AnnotationSelection, ComparableOperators<AnnotationSelection> {
  const AnnotationSelection._();

  const factory AnnotationSelection.verses({required VerseSelection verseSelection}) = VersesAnnotationSelection;
  const factory AnnotationSelection.text({required BibleTextSelection textSelection}) = TextAnnotationSelection;

  factory AnnotationSelection.fromJson(Map<String, dynamic> json) => _$AnnotationSelectionFromJson(json);

  Reference get startingReference => switch (this) {
    VersesAnnotationSelection(:final verseSelection) => verseSelection.references.first,
    TextAnnotationSelection(:final textSelection) => textSelection.toVerseSelection().references.first,
  };

  List<Reference> get allReferences => switch (this) {
    VersesAnnotationSelection(:final verseSelection) => verseSelection.references,
    TextAnnotationSelection(:final textSelection) => textSelection.toVerseSelection().references,
  };

  @override
  int compareTo(AnnotationSelection other) => startingReference.compareTo(other.startingReference);
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
