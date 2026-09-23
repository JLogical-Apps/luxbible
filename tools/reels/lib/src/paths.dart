import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:reels/src/model/video.dart';

Directory get projectRoot {
  for (var dir = Directory.current.absolute; ; dir = dir.parent) {
    if (File(p.join(dir.path, 'pubspec.yaml')).existsSync()) return dir;
    if (dir.path == dir.parent.path) throw StateError('Could not locate the reels project root.');
  }
}

String expandHome(String path) =>
    path.startsWith('~/') ? p.join(Platform.environment['HOME']!, path.substring(2)) : path;

File clipsFileFor(Video video) => File(p.join(projectRoot.path, 'lib', 'videos', '${video.name}.clips.json'));

Directory cacheDirFor(Video video) => Directory(p.join(projectRoot.path, '.cache', video.name));

// Existence is the only freshness check, so an interrupted job must never leave a file at the target path. The pid
// keeps the CLI and the app from writing the same partial file when both build the same artifact.
Future<File> cached(File target, Future<void> Function(File partial) create) async {
  if (!target.existsSync()) {
    final partial = File(
      p.join(target.parent.path, '${p.basenameWithoutExtension(target.path)}.partial-$pid${p.extension(target.path)}'),
    );
    await create(partial);
    partial.renameSync(target.path);
  }
  return target;
}
