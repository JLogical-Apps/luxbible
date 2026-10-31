import 'dart:io';

import 'package:path/path.dart' as p;

import 'google.dart';

Directory getRepository() {
  final directory = File.fromUri(Platform.script).parent.parent.parent.parent;
  if (!Directory(p.join(directory.path, 'context')).existsSync()) {
    throw StatsException('Could not locate the repository from ${Platform.script.toFilePath()}');
  }
  return directory;
}
