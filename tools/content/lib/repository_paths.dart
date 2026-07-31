import 'dart:io';

final repositoryRoot = findRepositoryRoot(File.fromUri(Platform.script).parent);

File sourceFile(String path) =>
    File.fromUri(repositoryRoot.uri.resolve('content/sources/$path'));

Directory sourceDirectory(String path) =>
    Directory.fromUri(repositoryRoot.uri.resolve('content/sources/$path'));

File appAssetFile(String path) =>
    File.fromUri(repositoryRoot.uri.resolve('apps/bible/assets/$path'));

Directory findRepositoryRoot(Directory start) {
  var directory = start;

  while (true) {
    if (File.fromUri(
      directory.uri.resolve('apps/bible/pubspec.yaml'),
    ).existsSync())
      return directory;

    final parent = directory.parent;
    if (parent.path == directory.path) {
      throw StateError(
        'Could not find the Lux repository root from ${start.path}.',
      );
    }
    directory = parent;
  }
}
