import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../lib/google.dart';
import '../lib/repository.dart';

const appPlatforms = {'iOS', 'Android'};
const automaticEvents = {'screen_view', 'session_start', 'user_engagement', 'app_update', 'os_update', '(not set)', ''};
const retentionDays = [1, 3, 7, 14, 28];

void main(List<String> args) {
  final parser = getParser();
  final options = parser.parse(args);
  if (options.flag('help')) {
    stdout.writeln('From tools/stats: dart run bin/summary.dart [options]\n${parser.usage}');
    return;
  }

  final weeks =
      int.tryParse(options.option('weeks')!) ?? (throw FormatException('--weeks needs a number, like --weeks 8'));
  final repository = getRepository();
  final snapshot = getSnapshot(repository, options.option('date'));
  stdout.writeln('Summary of ${p.relative(snapshot.path, from: repository.path)}');

  if (readSnapshot(snapshot, 'analytics.json')?['reports'] case final Map<String, dynamic> reports) {
    printAppUsage(reports.getRows('appDaily'), weeks);
    printEvents(reports.getRows('appEvents'), weeks);
    printRetention(reports.getRows('appCohorts'), weeks);
  }
  if (readSnapshot(snapshot, 'app-store.json')?['appStore'] case final Map<String, dynamic> appStore) {
    printAppStore(appStore, weeks);
  }
  if (readSnapshot(snapshot, 'google-play.json')?['googlePlay'] case final Map<String, dynamic> googlePlay) {
    printGooglePlay(googlePlay, weeks);
  }
}

void printAppUsage(List<Map<String, dynamic>> daily, int weeks) => printTable(
  'App usage by week (GA, iOS and Android)',
  ['Week', 'Days', 'DAU', 'iOS DAU', 'Android DAU', 'New', 'iOS new', 'Android new', 'Sessions/day'],
  groupRecentWeeks(daily.where(isAppRow), (row) => row.getDate('date'), weeks).entries.map((entry) {
    final days = entry.value.dayCount;
    final ios = entry.value.whereValue('platform', 'iOS');
    final android = entry.value.whereValue('platform', 'Android');
    return [
      entry.key.label,
      days,
      getAverage(entry.value.sumOf('activeUsers'), days),
      getAverage(ios.sumOf('activeUsers'), days),
      getAverage(android.sumOf('activeUsers'), days),
      entry.value.sumOf('newUsers'),
      ios.sumOf('newUsers'),
      android.sumOf('newUsers'),
      getAverage(entry.value.sumOf('sessions'), days),
    ];
  }),
);

void printEvents(List<Map<String, dynamic>> events, int weeks) {
  final usersByWeek = groupRecentWeeks(events.where(isAppRow), (row) => row.getDate('date'), weeks).map(
    (week, rows) => MapEntry(
      week,
      groupBy(rows, (row) => row['eventName'] as String).map((name, rows) => MapEntry(name, rows.sumOf('totalUsers'))),
    ),
  );
  final names = usersByWeek.values
      .expand((users) => users.keys)
      .toSet()
      .whereNot(automaticEvents.contains)
      .sortedBy<num>((name) => -usersByWeek.values.map((users) => users[name] ?? 0).sum);
  printTable('Event users by week (GA, iOS and Android, daily users summed over the week)', [
    'Event',
    ...usersByWeek.keys.map((week) => week.label.substring(5)),
  ], names.map((name) => [name, ...usersByWeek.values.map((users) => users[name] ?? 0)]));
}

void printRetention(List<Map<String, dynamic>> cohorts, int weeks) {
  final appRows = cohorts.where(isAppRow);
  final lastDate = appRows.map((row) => row.getDate('date')).max;
  final usersByCohort = groupBy(appRows, (row) => row.getDate('firstSessionDate')).map(
    (firstDate, rows) => MapEntry(
      firstDate,
      groupBy(
        rows,
        (row) => row.getDate('date').difference(firstDate).inDays,
      ).map((offset, rows) => MapEntry(offset, rows.sumOf('activeUsers'))),
    ),
  );

  String getRetention(List<DateTime> firstDates, int offset) {
    final eligible = firstDates.where((date) => !date.add(Duration(days: offset)).isAfter(lastDate));
    final size = eligible.map((date) => usersByCohort[date]![0] ?? 0).sum;
    if (size == 0) return '-';
    final retention = getPercent(eligible.map((date) => usersByCohort[date]![offset] ?? 0).sum, size);
    return eligible.length < firstDates.length ? '$retention of $size' : retention;
  }

  printTable(
    'Retention by weekly cohort (GA, iOS and Android; "of N" means only N users are old enough so far)',
    ['First week', 'Users', ...retentionDays.map((offset) => 'D$offset')],
    groupRecentWeeks(usersByCohort.keys, (date) => date, weeks).entries.map(
      (entry) => [
        entry.key.label,
        entry.value.map((date) => usersByCohort[date]![0] ?? 0).sum,
        ...retentionDays.map((offset) => getRetention(entry.value, offset)),
      ],
    ),
  );
}

void printAppStore(Map<String, dynamic> appStore, int weeks) {
  final engagement = appStore.getRows('engagement');
  final downloads = appStore.getRows('downloads');
  final engagementByWeek = groupBy(engagement, (row) => row.getDate('date').week);
  printTable(
    'App Store funnel by week (engagement can lag downloads by a few days)',
    [
      'Week',
      'Days',
      'Impressions',
      'Page views',
      'First downloads',
      'Redownloads',
      'View → download',
      'Impr. → download',
    ],
    groupRecentWeeks(downloads, (row) => row.getDate('date'), weeks).entries.map((entry) {
      final views = engagementByWeek[entry.key] ?? [];
      final impressions = views.whereValue('event', 'Impression').sumOf('unique counts');
      final pageViews = views.whereValue('event', 'Page view').sumOf('unique counts');
      final firstDownloads = entry.value.whereValue('download type', 'First-time download').sumOf('counts');
      return [
        entry.key.label,
        entry.value.dayCount,
        impressions,
        pageViews,
        firstDownloads,
        entry.value.whereValue('download type', 'Redownload').sumOf('counts'),
        getPercent(firstDownloads, pageViews),
        getPercent(firstDownloads, impressions),
      ];
    }),
  );

  final start = downloads.map((row) => row.getDate('date')).max.subtract(Duration(days: 27));
  final recentEngagement = engagement.where((row) => !row.getDate('date').isBefore(start));
  final recentDownloads = downloads
      .where((row) => !row.getDate('date').isBefore(start))
      .whereValue('download type', 'First-time download');
  final sources = [...recentEngagement, ...recentDownloads].map((row) => row['source type'] as String).toSet();
  printTable(
    'App Store by source, last 28 days',
    ['Source', 'Impressions', 'Page views', 'First downloads', 'View → download'],
    sources
        .map((source) {
          final views = recentEngagement.whereValue('source type', source);
          final pageViews = views.whereValue('event', 'Page view').sumOf('unique counts');
          final firstDownloads = recentDownloads.whereValue('source type', source).sumOf('counts');
          return [
            source,
            views.whereValue('event', 'Impression').sumOf('unique counts'),
            pageViews,
            firstDownloads,
            getPercent(firstDownloads, pageViews),
          ];
        })
        .where((row) => row.skip(1).take(3).any((count) => count != 0))
        .sortedBy<num>((row) => -(row[3] as num)),
  );
}

void printGooglePlay(Map<String, dynamic> googlePlay, int weeks) {
  final trafficByWeek = groupBy(googlePlay.getRows('traffic'), (row) => row.getDate('date').week);
  printTable(
    'Google Play funnel by week',
    ['Week', 'Days', 'Visitors', 'Acquisitions', 'Conversion', 'Installs', 'Uninstalls', 'Active devices'],
    groupRecentWeeks(googlePlay.getRows('installs'), (row) => row.getDate('date'), weeks).entries.map((entry) {
      final traffic = trafficByWeek[entry.key] ?? [];
      final visitors = traffic.sumOf('store listing visitors');
      final acquisitions = traffic.sumOf('store listing acquisitions');
      return [
        entry.key.label,
        entry.value.dayCount,
        visitors,
        acquisitions,
        getPercent(acquisitions, visitors),
        entry.value.sumOf('daily user installs'),
        entry.value.sumOf('daily user uninstalls'),
        entry.value.sortedBy<String>((row) => row['date']).last.getNumber('active device installs'),
      ];
    }),
  );
}

void printTable(String title, List<String> headers, Iterable<List<Object>> rows) {
  final cells = [headers, ...rows.map((row) => row.map((cell) => '$cell').toList())];
  final widths = headers.mapIndexed((column, _) => cells.map((row) => row[column].length).max).toList();
  String getLine(List<String> row) => row
      .mapIndexed((column, cell) => column == 0 ? cell.padRight(widths[column]) : cell.padLeft(widths[column]))
      .join('  ');

  stdout.writeln('\n$title');
  stdout.writeln(getLine(headers));
  stdout.writeln(widths.map((width) => '-' * width).join('  '));
  cells.skip(1).map(getLine).forEach(stdout.writeln);
}

Map<DateTime, List<T>> groupRecentWeeks<T>(Iterable<T> items, DateTime Function(T) getDate, int weeks) {
  final groups = groupBy(items, (item) => getDate(item).week);
  final recentWeeks = groups.keys.sorted().reversed.take(weeks).toList().reversed;
  return Map.fromEntries(recentWeeks.map((week) => MapEntry(week, groups[week]!)));
}

bool isAppRow(Map<String, dynamic> row) => appPlatforms.contains(row['platform']);

String getAverage(num total, int count) => (total / count).toStringAsFixed(1);

String getPercent(num part, num whole) => whole == 0 ? '-' : '${(part / whole * 100).round()}%';

Directory getSnapshot(Directory repository, String? date) {
  final stats = Directory(p.join(repository.path, 'stats'));
  final name =
      date ??
      (stats.existsSync() ? stats.listSync() : <FileSystemEntity>[])
          .whereType<Directory>()
          .map((directory) => p.basename(directory.path))
          .where(RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch)
          .maxOrNull ??
      (throw StatsException('No snapshots in stats/. Run bin/collect.dart first.'));
  final snapshot = Directory(p.join(stats.path, name));
  if (!snapshot.existsSync()) throw StatsException('No snapshot at stats/$name');
  return snapshot;
}

Map<String, dynamic>? readSnapshot(Directory snapshot, String fileName) {
  final file = File(p.join(snapshot.path, fileName));
  if (!file.existsSync()) {
    stdout.writeln('\nSkipped $fileName, which is not in this snapshot');
    return null;
  }
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

ArgParser getParser() => ArgParser()
  ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage.')
  ..addOption('date', help: 'Snapshot folder to summarize, like 2026-10-27. Defaults to the newest.')
  ..addOption('weeks', defaultsTo: '8', help: 'Show this many most recent weeks.');

extension on Map<String, dynamic> {
  num getNumber(String key) => switch (this[key]) {
    final num value => value,
    final String value => num.tryParse(value) ?? 0,
    _ => 0,
  };

  DateTime getDate(String key) => DateTime.parse('${this[key]}T00Z');

  List<Map<String, dynamic>> getRows(String key) => (this[key] as List? ?? []).cast<Map<String, dynamic>>();
}

extension on Iterable<Map<String, dynamic>> {
  num sumOf(String key) => map((row) => row.getNumber(key)).sum;

  Iterable<Map<String, dynamic>> whereValue(String key, Object value) => where((row) => row[key] == value);

  int get dayCount => map((row) => row['date']).toSet().length;
}

extension on DateTime {
  DateTime get week => subtract(Duration(days: weekday - 1));

  String get label => toIso8601String().substring(0, 10);
}
