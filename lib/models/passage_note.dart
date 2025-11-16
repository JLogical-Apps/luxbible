import 'package:freezed_annotation/freezed_annotation.dart';

part 'passage_note.freezed.dart';
part 'passage_note.g.dart';

@freezed
sealed class PassageNote with _$PassageNote {
  const PassageNote._();

  const factory PassageNote({required String passageKey, required String note}) = _PassageNote;

  factory PassageNote.fromJson(Map<String, dynamic> json) => _$PassageNoteFromJson(json);
}
