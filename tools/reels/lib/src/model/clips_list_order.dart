import 'package:collection/collection.dart';
import 'package:reels/src/model/clips.dart';

// Keeps the video file's order, including manual reordering, and slots each newly ticked clip in after the nearest
// clip that precedes it in the recording.
List<String> getUpdatedClipsList({
  required List<String> current,
  required Set<String> selected,
  required Clips source,
}) {
  final recorded = source.clips.map((c) => c.name).toList();
  final added = recorded.where((name) => selected.contains(name) && !current.contains(name));

  return added.fold(current.where(selected.contains).toList(), (list, name) {
    final preceding = recorded.takeWhile((n) => n != name).lastWhereOrNull(list.contains);
    return list..insert(preceding == null ? 0 : list.indexOf(preceding) + 1, name);
  });
}
