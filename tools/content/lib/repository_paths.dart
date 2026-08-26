import 'dart:convert';
import 'dart:io';

import 'package:lux/lux_core.dart';
import 'package:utils_core/utils_core.dart';

final repositoryRoot = findRepositoryRoot(File.fromUri(Platform.script).parent);

File sourceFile(String path) => File.fromUri(repositoryRoot.uri.resolve('content/sources/$path'));

Directory sourceDirectory(String path) => Directory.fromUri(repositoryRoot.uri.resolve('content/sources/$path'));

File appAssetFile(String path, {required LuxApp app}) =>
    File.fromUri(repositoryRoot.uri.resolve('apps/${app.name}/assets/$path'));

Directory appAssetDirectory(String path, {required LuxApp app}) =>
    Directory.fromUri(repositoryRoot.uri.resolve('apps/${app.name}/assets/$path'));

void writeBibleBooks({required String translation, required LuxApp app, required Iterable<Book> books}) {
  final directory = appAssetDirectory('translations/$translation', app: app)..createSync(recursive: true);
  books.forEach(
    (book) =>
        (directory - '${book.bookType.usxCode()}.json').writeAsStringSync(jsonEncode(book.toJson().withRemoved('b'))),
  );
}

Directory findRepositoryRoot(Directory start) {
  var directory = start;

  while (true) {
    if (File.fromUri(directory.uri.resolve('apps/bible/pubspec.yaml')).existsSync()) return directory;

    final parent = directory.parent;
    if (parent.path == directory.path) {
      throw StateError('Could not find the Lux repository root from ${start.path}.');
    }
    directory = parent;
  }
}
