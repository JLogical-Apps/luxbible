import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import '../lib/analytics.dart';
import '../lib/crashlytics.dart';
import '../lib/google.dart';

enum Source {
  socials,
  appStore,
  googlePlay,
  analytics,
  crashlytics;

  String get fileName => switch (this) {
    socials => 'socials.json',
    appStore => 'app-store.json',
    googlePlay => 'google-play.json',
    analytics => 'analytics.json',
    crashlytics => 'crashlytics.json',
  };

  Future<Map<String, dynamic>> collect(Directory repository, {required int days}) => switch (this) {
    socials => runJsonScript(p.join(repository.path, 'tools', 'socials'), [
      'bin/stats.dart',
      '--days',
      '$days',
      '--json',
    ]),
    appStore => runJsonScript(p.join(repository.path, 'apps', 'bible'), [
      'tool/release/store_stats.dart',
      '--days',
      '$days',
      '--ios',
      '--json',
    ]),
    googlePlay => runJsonScript(p.join(repository.path, 'apps', 'bible'), [
      'tool/release/store_stats.dart',
      '--days',
      '$days',
      '--android',
      '--json',
    ]),
    analytics => useGoogle((google) => getAnalyticsReports(google, days: days)),
    crashlytics => useGoogle((google) => getCrashlyticsReports(google, days: days)),
  };

  String? getProblem(Map<String, dynamic> data) => switch (this) {
    socials when (data['failures'] as List).isNotEmpty => (data['failures'] as List).join('; '),
    _ => null,
  };
}

Future<void> main(List<String> args) async {
  final parser = getParser();
  final options = parser.parse(args);
  if (options.flag('help')) {
    stdout.writeln('From tools/stats: dart run bin/collect.dart [options]\n${parser.usage}');
    return;
  }

  final days =
      int.tryParse(options.option('days')!) ?? (throw FormatException('--days needs a number, like --days 90'));
  final repository = getRepository();
  final date = DateTime.now().toIso8601String().substring(0, 10);
  final directory = Directory(p.join(repository.path, 'stats', date))..createSync(recursive: true);
  final sources = options.multiOption('source').map(Source.values.byName);

  stdout.writeln('Collecting $days days of stats into ${p.relative(directory.path, from: repository.path)}');
  final statuses = await Future.wait(
    sources.map((source) async {
      try {
        final data = await source.collect(repository, days: days);
        File(p.join(directory.path, source.fileName)).writeAsStringSync(jsonEncode(data));
        final problem = source.getProblem(data);
        stdout.writeln(problem == null ? 'Saved ${source.fileName}' : 'Partly saved ${source.fileName}: $problem');
        return MapEntry(source.name, {'collectedAt': DateTime.now().toIso8601String(), 'problem': ?problem});
      } catch (error) {
        stdout.writeln('Failed ${source.name}: $error');
        return MapEntry(source.name, {'failedAt': DateTime.now().toIso8601String(), 'error': '$error'});
      }
    }),
  );

  final manifest = File(p.join(directory.path, 'collection.json'));
  final previous = manifest.existsSync() ? jsonDecode(manifest.readAsStringSync()) as Map<String, dynamic> : {};
  manifest.writeAsStringSync(
    JsonEncoder.withIndent('  ').convert({
      'days': days,
      'sources': {...?previous['sources'] as Map<String, dynamic>?, ...Map.fromEntries(statuses)},
    }),
  );
  if (statuses.any((status) => status.value.containsKey('error'))) exitCode = 1;
}

Future<Map<String, dynamic>> runJsonScript(String workingDirectory, List<String> args) async {
  final result = await Process.run(Platform.resolvedExecutable, ['run', ...args], workingDirectory: workingDirectory);
  try {
    return jsonDecode(result.stdout as String) as Map<String, dynamic>;
  } on FormatException {
    final message = (result.stderr as String).trim().replaceFirst(RegExp(r'^Error: '), '');
    throw StatsException(message.isEmpty ? 'exited with code ${result.exitCode}' : message);
  }
}

Future<Map<String, dynamic>> useGoogle(Future<Map<String, dynamic>> Function(GoogleApi google) run) async {
  final google = await GoogleApi.connect();
  try {
    return await run(google);
  } finally {
    google.close();
  }
}

Directory getRepository() {
  final directory = File.fromUri(Platform.script).parent.parent.parent.parent;
  if (!Directory(p.join(directory.path, 'context')).existsSync()) {
    throw StatsException('Could not locate the repository from ${Platform.script.toFilePath()}');
  }
  return directory;
}

ArgParser getParser() => ArgParser()
  ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage.')
  ..addOption('days', defaultsTo: '90', help: 'Collect this many past days.')
  ..addMultiOption(
    'source',
    allowed: Source.values.map((source) => source.name),
    defaultsTo: Source.values.map((source) => source.name),
    help: 'Sources to collect, separated by commas. Others keep their earlier file from the same day.',
  );
