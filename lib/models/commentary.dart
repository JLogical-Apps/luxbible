import 'package:bible/models/passage.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';

class Commentary {
  final String name;
  final Map<Passage, String> notes;

  const Commentary({required this.name, required this.notes});

  Map<Passage, String> getNotesFor(Passage passage) =>
      notes.where((p, note) => p.references.containsAny(passage.references));
}
