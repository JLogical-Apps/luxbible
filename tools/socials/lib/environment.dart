import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:path/path.dart' as p;

final environment = DotEnv(includePlatformEnvironment: true, quiet: true);

Directory getRepository() {
  var directory = File.fromUri(Platform.script).parent;
  while (!File(p.join(directory.path, 'AGENTS.md')).existsSync() ||
      !Directory(p.join(directory.path, 'context')).existsSync()) {
    final parent = directory.parent;
    if (parent.path == directory.path)
      throw FormatException('Could not locate repository from script path');
    directory = parent;
  }
  return directory;
}

void loadEnvironment(String path) => environment
  ..clear()
  ..load([path])
  ..addAll(Platform.environment);

String getEnvironment(String name) => environment[name]?.trim() ?? '';

String getRequiredEnvironment(String name) {
  final value = getEnvironment(name);
  if (value.isEmpty)
    throw FormatException(
      'Configure $name in tools/socials/.env or your environment',
    );
  return value;
}

Iterable<String> getSecrets() => [
  ...Platform.environment.entries
      .where(
        (entry) => RegExp(
          r'TOKEN|SECRET|KEY',
          caseSensitive: false,
        ).hasMatch(entry.key),
      )
      .map((entry) => entry.value),
  getEnvironment('ZERNIO_API_KEY'),
  getEnvironment('WOOPSOCIAL_API_KEY'),
  getEnvironment('META_ACCESS_TOKEN'),
].where((value) => value.isNotEmpty);
