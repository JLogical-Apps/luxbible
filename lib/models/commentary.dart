import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'commentary.freezed.dart';
part 'commentary.g.dart';

@freezed
sealed class Commentary with _$Commentary {
  const Commentary._();

  const factory Commentary({
    @JsonKey(name: 'n') required String name,
    @JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson) required Map<VerseSelection, String> notes,
  }) = _Commentary;

  factory Commentary.fromJson(Map<String, dynamic> json) => _$CommentaryFromJson(json);

  Map<VerseSelection, String> getNotesFor(VerseSelection verseSelection) =>
      notes.where((vs, note) => vs.references.containsAny(verseSelection.references));
}

Map<String, dynamic> _notesToJson(Map<VerseSelection, String> notes) =>
    notes.map((ref, note) => MapEntry(ref.toJson(), note));

Map<VerseSelection, String> _notesFromJson(Map<String, dynamic> notes) =>
    notes.map((ref, note) => MapEntry(VerseSelection.fromJson(ref), note));
