import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:utils_core/utils_core.dart';

class Commentary {
  final String name;
  final Map<VerseSelection, String> notes;

  const Commentary({required this.name, required this.notes});

  Map<VerseSelection, String> getNotesFor(VerseSelection verseSelection) =>
      notes.where((vs, note) => vs.references.containsAny(verseSelection.references));
}
