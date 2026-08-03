import 'package:lux/lux.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'commentary.freezed.dart';
part 'commentary.g.dart';

@freezed
sealed class Commentary with _$Commentary {
  const Commentary._();

  const factory Commentary({
    @JsonKey(name: 'v', toJson: _notesToJson, fromJson: _notesFromJson) required Map<VerseSelection, Markdown> notes,
  }) = _Commentary;

  factory Commentary.fromJson(Map<String, dynamic> json) => _$CommentaryFromJson(json);

  Map<VerseSelection, Markdown> getNotesFor(VerseSelection verseSelection) {
    final references = verseSelection.references.expand(
      (reference) => [
        if (reference.chapterNum == 1 && reference.verseNum == 1)
          Reference(book: reference.book, chapterNum: 1, verseNum: 0),
        reference,
      ],
    );
    return notes.where((vs, note) => vs.references.containsAny(references));
  }
}

Map<String, dynamic> _notesToJson(Map<VerseSelection, Markdown> notes) =>
    notes.map((ref, note) => MapEntry(ref.toJson(), note.text));

Map<VerseSelection, Markdown> _notesFromJson(Map<String, dynamic> notes) =>
    notes.map((ref, note) => MapEntry(VerseSelection.fromJson(ref), Markdown(note)));
