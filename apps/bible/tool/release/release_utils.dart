import 'dart:io';

Map<String, String> loadReleaseEnv() {
  final file = File('tool/release/.env');
  if (!file.existsSync()) {
    fail('Missing tool/release/.env. Copy tool/release/.env.example and fill it in.');
  }
  return Map.fromEntries(
    file
        .readAsLinesSync()
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty && !line.startsWith('#') && line.contains('='))
        .map((line) {
          final separator = line.indexOf('=');
          return MapEntry(line.substring(0, separator).trim(), unquote(line.substring(separator + 1).trim()));
        }),
  );
}

String unquote(String value) =>
    value.length >= 2 &&
        ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'")))
    ? value.substring(1, value.length - 1)
    : value;

void runCommand(String executable, List<String> args, {Map<String, String>? environment}) {
  stdout.writeln('\$ $executable ${args.join(' ')}');
  final result = Process.runSync(executable, args, runInShell: true, environment: environment);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  if (result.exitCode != 0) {
    fail('$executable exited with code ${result.exitCode}.');
  }
}

void printSection(String title) => stdout.writeln('\n=== $title ===');

Never fail(String message) {
  stderr.writeln('Error: $message');
  exit(1);
}

extension ReleaseEnv on Map<String, String> {
  String require(String key) {
    final value = this[key];
    if (value == null || value.isEmpty) {
      fail('Missing required value "$key" in tool/release/.env');
    }
    return value;
  }
}
