import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:googleapis/storage/v1.dart' show DetailedApiRequestError, DownloadOptions, Media, StorageApi;
import 'package:googleapis_auth/auth_io.dart';
import 'package:lux/lux_core.dart';

import 'listings.dart' show iosBundleId;
import 'release_utils.dart';

/// Prints store listing traffic and conversion from App Store Connect and Google Play.
///
/// Usage:
///   dart run tool/release/store_stats.dart               # both stores, last 28 days
///   dart run tool/release/store_stats.dart --days 90
///   dart run tool/release/store_stats.dart --ios         # App Store only
///   dart run tool/release/store_stats.dart --android     # Google Play only
///
/// The App Store side reads Apple's analytics reports. The first run requests them, which needs an Admin
/// API key, and Apple takes a day or two to generate the first ones. The Google Play side reads the
/// monthly CSVs that Play Console exports to PLAY_REPORTS_BUCKET.
Future<void> main(List<String> args) async {
  final daysIndex = args.indexOf('--days');
  final unknown = args.whereIndexed(
    (index, arg) => !['--ios', '--android', '--days'].contains(arg) && (daysIndex == -1 || index != daysIndex + 1),
  );
  if (unknown.isNotEmpty) {
    fail('Unknown argument(s): ${unknown.join(', ')}. Use --days <count>, --ios, and/or --android.');
  }

  final days = daysIndex == -1
      ? 28
      : int.tryParse(args.elementAtOrNull(daysIndex + 1) ?? '') ?? fail('--days needs a number, like --days 90.');
  final includesIos = args.has('--ios') || !args.has('--android');
  final includesAndroid = args.has('--android') || !args.has('--ios');

  final env = loadReleaseEnv();
  final since = DateTime.now().subtract(Duration(days: days)).isoDate;

  if (includesIos) {
    printSection('App Store since $since');
    await printAppStoreStats(env, since: since);
  }

  if (includesAndroid) {
    printSection('Google Play since $since');
    await printPlayStats(env, since: since);
  }
}

typedef Row = Map<String, String>;

// ---------------------------------------------------------------------------
// App Store
// ---------------------------------------------------------------------------

typedef AppStoreFunnel = ({num impressions, num pageViews, num downloads});

enum AppStoreReport {
  engagement,
  engagementDetailed,
  downloads,
  downloadsDetailed;

  String get category => switch (this) {
    engagement || engagementDetailed => 'APP_STORE_ENGAGEMENT',
    downloads || downloadsDetailed => 'COMMERCE',
  };

  String get nameFragment => switch (this) {
    engagement || engagementDetailed => 'Discovery and Engagement',
    downloads || downloadsDetailed => 'Download',
  };

  bool get isDetailed => this == engagementDetailed || this == downloadsDetailed;

  List<String> get columns => [
    'date',
    'source type',
    'territory',
    ...switch (this) {
      engagement || engagementDetailed => ['event', 'page type', 'unique counts'],
      downloads || downloadsDetailed => ['download type', 'counts'],
    },
    if (isDetailed) 'campaign',
  ];

  bool matches(String name) => name.contains(nameFragment) && name.endsWith(isDetailed ? 'Detailed' : 'Standard');
}

Future<void> printAppStoreStats(Map<String, String> env, {required String since}) async {
  final api = AppStoreConnect(
    keyId: getReportsSetting(env, 'ASC_REPORTS_KEY_ID', fallback: 'ASC_KEY_ID'),
    issuerId: env.require('ASC_ISSUER_ID'),
    privateKey: readFile(getReportsSetting(env, 'ASC_REPORTS_API_KEY_PATH', fallback: 'ASC_API_KEY_PATH')),
  );

  try {
    final apps = await api.getAll('/v1/apps?filter[bundleId]=$iosBundleId');
    final appId = apps.firstOrNull?['id'] as String? ?? fail('No App Store app found for $iosBundleId.');
    final requests = await getReportRequests(api, appId);
    final reports = await AppStoreReport.values
        .map((report) async => MapEntry(report, await getAppStoreRows(api, requests, report, since: since)))
        .waitToMap;

    if (reports.values.every((rows) => rows.isEmpty)) {
      stdout.writeln('Apple has no reports for this period yet. They usually appear a day or two after the first run.');
      return;
    }

    final daily = getAppStoreFunnels(
      'date',
      engagement: reports[AppStoreReport.engagement]!,
      downloads: reports[AppStoreReport.downloads]!,
    );
    printAppStoreTable('Daily', daily.sortedBy((date, _) => date), showsTotal: true);
    printAppStoreTable(
      'By source',
      getAppStoreFunnels(
        'source type',
        engagement: reports[AppStoreReport.engagement]!,
        downloads: reports[AppStoreReport.downloads]!,
      ).sortedByDescending((_, funnel) => funnel.impressions),
    );
    printAppStoreTable(
      'Top storefronts',
      Map.fromEntries(
        getAppStoreFunnels(
          'territory',
          engagement: reports[AppStoreReport.engagement]!,
          downloads: reports[AppStoreReport.downloads]!,
        ).sortedByDescending((_, funnel) => funnel.impressions).entries.take(10),
      ),
    );
    printAppStoreTable(
      'By campaign (Apple hides rows from fewer than 5 devices, so these undercount)',
      Map.fromEntries(
        getAppStoreFunnels(
          'campaign',
          engagement: reports[AppStoreReport.engagementDetailed]!,
          downloads: reports[AppStoreReport.downloadsDetailed]!,
        ).entries.where((entry) => entry.key.isNotEmpty),
      ).sortedByDescending((_, funnel) => funnel.pageViews),
    );
  } finally {
    api.client.close();
  }
}

Future<List<Map<String, dynamic>>> getReportRequests(AppStoreConnect api, String appId) async {
  final existing = await api.getAll('/v1/apps/$appId/analyticsReportRequests');
  final missing = ['ONGOING', 'ONE_TIME_SNAPSHOT'].whereNot(
    (accessType) => existing.any(
      (request) =>
          request['attributes']['accessType'] == accessType && request['attributes']['stoppedDueToInactivity'] != true,
    ),
  );
  final created = await Future.wait(
    missing.map(
      (accessType) async =>
          (await api.send(
                'POST',
                '/v1/analyticsReportRequests',
                body: {
                  'data': {
                    'type': 'analyticsReportRequests',
                    'attributes': {'accessType': accessType},
                    'relationships': {
                      'app': {
                        'data': {'type': 'apps', 'id': appId},
                      },
                    },
                  },
                },
              ))['data']
              as Map<String, dynamic>,
    ),
  );
  if (created.isNotEmpty) {
    stdout.writeln('Requested ${missing.join(' and ')} analytics reports from Apple.');
  }
  return [...existing, ...created].sortedBy<num>((request) => request['attributes']['accessType'] == 'ONGOING' ? 0 : 1);
}

Future<List<Row>> getAppStoreRows(
  AppStoreConnect api,
  List<Map<String, dynamic>> requests,
  AppStoreReport report, {
  required String since,
}) async {
  final rowsByRequest = await Future.wait(
    requests.map((request) => getRequestRows(api, request['id'] as String, report, since: since)),
  );

  // Ongoing and snapshot requests overlap, so each date comes from the first request that has it.
  final rowsByDate = <String, List<Row>>{};
  for (final rows in rowsByRequest) {
    groupRows(rows, 'date').forEach((date, dateRows) => rowsByDate.putIfAbsent(date, () => dateRows));
  }
  return rowsByDate.values.flattened.toList();
}

Future<List<Row>> getRequestRows(
  AppStoreConnect api,
  String requestId,
  AppStoreReport report, {
  required String since,
}) async {
  final reports = await api.getAll(
    '/v1/analyticsReportRequests/$requestId/reports?filter[category]=${report.category}',
  );
  final instances = await Future.wait(
    reports
        .where((candidate) => report.matches(candidate['attributes']['name'] as String))
        .map((match) => api.getAll('/v1/analyticsReports/${match['id']}/instances?filter[granularity]=DAILY')),
  );
  final segments = await Future.wait(
    instances.flattened
        .where((instance) => (instance['attributes']['processingDate'] as String).compareTo(since) >= 0)
        .map((instance) => api.getAll('/v1/analyticsReportInstances/${instance['id']}/segments')),
  );
  final tables = await Future.wait(
    segments.flattened.map((segment) => api.download(segment['attributes']['url'] as String)),
  );
  return tables
      .map((bytes) => parseTable(utf8.decode(gzip.decode(bytes)), separator: '\t'))
      .map((rows) => requireColumns(rows, report.columns, report: report.name))
      .flattened
      .map(normalizeDate)
      .where((row) => row['date']!.compareTo(since) >= 0)
      .toList();
}

Map<String, AppStoreFunnel> getAppStoreFunnels(
  String column, {
  required List<Row> engagement,
  required List<Row> downloads,
}) {
  final engagementGroups = groupRows(engagement, column);
  final downloadGroups = groupRows(downloads, column);
  return {
    for (final key in {...engagementGroups.keys, ...downloadGroups.keys})
      key: getAppStoreFunnel(engagementGroups[key] ?? [], downloadGroups[key] ?? []),
  };
}

AppStoreFunnel getAppStoreFunnel(Iterable<Row> engagement, Iterable<Row> downloads) => (
  impressions: sumColumn(engagement.where((row) => row['event'] == 'Impression'), 'unique counts'),
  pageViews: sumColumn(
    engagement.where((row) => row['event'] == 'Page view' && row['page type'] == 'Product page'),
    'unique counts',
  ),
  downloads: sumColumn(downloads.where((row) => row['download type'] == 'First-time download'), 'counts'),
);

void printAppStoreTable(String title, Map<String, AppStoreFunnel> funnels, {bool showsTotal = false}) {
  List<Object> getCells(String label, AppStoreFunnel funnel) => [
    label,
    funnel.impressions,
    funnel.pageViews,
    funnel.downloads,
    formatRate(funnel.downloads, funnel.impressions),
  ];

  final total = funnels.values.fold<AppStoreFunnel>(
    (impressions: 0, pageViews: 0, downloads: 0),
    (sum, funnel) => (
      impressions: sum.impressions + funnel.impressions,
      pageViews: sum.pageViews + funnel.pageViews,
      downloads: sum.downloads + funnel.downloads,
    ),
  );
  printTable(
    title,
    ['', 'Impressions', 'Page views', 'Downloads', 'Conversion'],
    [...funnels.entries.map((entry) => getCells(entry.key, entry.value)), if (showsTotal) getCells('Total', total)],
  );
}

class AppStoreConnect {
  AppStoreConnect({required this.keyId, required this.issuerId, required this.privateKey});

  final String keyId;
  final String issuerId;
  final String privateKey;
  final client = HttpClient();

  String get token => JWT(
    {'iss': issuerId, 'aud': 'appstoreconnect-v1'},
    header: {'kid': keyId},
  ).sign(ECPrivateKey(privateKey), algorithm: .ES256, expiresIn: Duration(minutes: 10));

  Future<Map<String, dynamic>> send(String method, String pathOrUrl, {Object? body}) async {
    final request = await client.openUrl(
      method,
      Uri.parse(pathOrUrl.startsWith('https://') ? pathOrUrl : 'https://api.appstoreconnect.apple.com$pathOrUrl'),
    );
    request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $token');
    if (body != null) {
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(body));
    }

    final response = await request.close();
    final text = await response.transform(utf8.decoder).join();
    if (response.statusCode >= 300) {
      final details = (jsonDecode(text)['errors'] as List?)?.map((error) => error['detail']).join(' ') ?? text;
      fail(
        'App Store Connect refused $method $pathOrUrl (${response.statusCode}): $details'
        '${response.statusCode == 403 ? '\nAnalytics reports need an Admin key the first time. Set ASC_REPORTS_KEY_ID '
                  'and ASC_REPORTS_API_KEY_PATH in tool/release/.env.' : ''}',
      );
    }
    return jsonDecode(text) as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getAll(String pathOrUrl) async {
    final page = await send('GET', pathOrUrl);
    final data = (page['data'] as List).cast<Map<String, dynamic>>();
    return switch (page['links']?['next']) {
      final String next => [...data, ...await getAll(next)],
      _ => data,
    };
  }

  // Segment URLs are presigned, so they are fetched without the API token.
  Future<List<int>> download(String url) async {
    final response = await (await client.getUrl(Uri.parse(url))).close();
    if (response.statusCode >= 300) fail('Could not download an App Store report segment (${response.statusCode}).');
    return response.expand((chunk) => chunk).toList();
  }
}

String getReportsSetting(Map<String, String> env, String key, {required String fallback}) => switch (env[key]) {
  final value? when value.isNotEmpty => value,
  _ => env.require(fallback),
};

// ---------------------------------------------------------------------------
// Google Play
// ---------------------------------------------------------------------------

typedef PlayFunnel = ({num visitors, num acquisitions});

const playTrafficColumns = [
  'date',
  'traffic source',
  'search term',
  'utm campaign',
  'store listing visitors',
  'store listing acquisitions',
];
const playCountryColumns = ['date', 'store listing visitors', 'store listing acquisitions'];
const playInstallColumns = ['date', 'daily device installs', 'daily device uninstalls'];

Future<void> printPlayStats(Map<String, String> env, {required String since}) async {
  final packageName = env.require('ANDROID_PACKAGE_NAME');
  final bucket = env.require('PLAY_REPORTS_BUCKET').replaceFirst('gs://', '').split('/').first;
  final credentials = ServiceAccountCredentials.fromJson(readFile(env.require('PLAY_SERVICE_ACCOUNT_JSON')));
  final client = await clientViaServiceAccount(credentials, [StorageApi.devstorageReadOnlyScope]);

  try {
    final storage = StorageApi(client);
    final months = getMonths(since);
    Future<List<Row>> getRows(String Function(String month) getPath, List<String> columns) =>
        getPlayRows(storage, bucket, months.map(getPath), columns, since: since);

    final traffic = await getRows(
      (month) => 'stats/store_performance/store_performance_${packageName}_${month}_traffic_source.csv',
      playTrafficColumns,
    );
    final countries = await getRows(
      (month) => 'stats/store_performance/store_performance_${packageName}_${month}_country.csv',
      playCountryColumns,
    );
    final installs = await getRows(
      (month) => 'stats/installs/installs_${packageName}_${month}_overview.csv',
      playInstallColumns,
    );

    if (traffic.isEmpty && installs.isEmpty) {
      stdout.writeln('Play Console has no reports for this period yet.');
      return;
    }

    final installsByDate = groupRows(installs, 'date');
    final dailyFunnels = getPlayFunnels('date', traffic);
    final dates = {...dailyFunnels.keys, ...installsByDate.keys}.sorted();
    List<Object> getDailyCells(String label, PlayFunnel funnel, List<Row> dateInstalls) => [
      ...getPlayCells(label, funnel),
      sumColumn(dateInstalls, 'daily device installs'),
      sumColumn(dateInstalls, 'daily device uninstalls'),
    ];
    printTable(
      'Daily',
      ['', 'Visitors', 'Acquisitions', 'Conversion', 'Installs', 'Uninstalls'],
      [
        ...dates.map(
          (date) =>
              getDailyCells(date, dailyFunnels[date] ?? (visitors: 0, acquisitions: 0), installsByDate[date] ?? []),
        ),
        getDailyCells('Total', getPlayFunnel(traffic), installs),
      ],
    );

    printPlayTable('By source', getPlayFunnels('traffic source', traffic));
    printPlayTable('Top search terms', getPlayFunnels('search term', traffic), limit: 15);
    printPlayTable('By UTM campaign', getPlayFunnels('utm campaign', traffic));
    if (countries.firstOrNull?.keys.firstWhereOrNull((column) => column.startsWith('country')) case final column?) {
      printPlayTable('Top countries', getPlayFunnels(column, countries), limit: 10);
    }
  } finally {
    client.close();
  }
}

Future<List<Row>> getPlayRows(
  StorageApi storage,
  String bucket,
  Iterable<String> paths,
  List<String> columns, {
  required String since,
}) async {
  final tables = await Future.wait(paths.map((path) => downloadPlayReport(storage, bucket, path)));
  return tables
      .mapIndexed((index, rows) => requireColumns(rows, columns, report: paths.elementAt(index)))
      .flattened
      .map(normalizeDate)
      .where((row) => row['date']!.compareTo(since) >= 0)
      .toList();
}

Future<List<Row>> downloadPlayReport(StorageApi storage, String bucket, String path) async {
  try {
    final media = await storage.objects.get(bucket, path, downloadOptions: DownloadOptions.fullMedia) as Media;
    return parseTable(decodeReport(await media.stream.expand((chunk) => chunk).toList()), separator: ',');
  } on DetailedApiRequestError catch (error) {
    return switch (error.status) {
      // A month's file only appears once Play Console has exported its first day.
      404 => [],
      403 => fail(
        'The Play service account cannot read gs://$bucket. In Play Console, open Users and permissions and give it '
        '"View app information and download bulk reports". The change can take up to a day to apply.\n'
        'Google said: ${error.message}',
      ),
      _ => throw error,
    };
  }
}

// Play Console exports its CSVs as UTF-16.
String decodeReport(List<int> bytes) => switch (bytes) {
  [0xFF, 0xFE, ...] => String.fromCharCodes(
    bytes.skip(2).slices(2).where((pair) => pair.length == 2).map((pair) => pair[0] | pair[1] << 8),
  ),
  _ => utf8.decode(bytes, allowMalformed: true),
};

List<String> getMonths(String since) {
  final start = DateTime.parse(since);
  return Range.generate(0, start.getMonthsUntil(DateTime.now()))
      .map((offset) => DateTime(start.year, start.month + offset))
      .map((month) => '${month.year}${month.month.toString().padLeft(2, '0')}')
      .toList();
}

Map<String, PlayFunnel> getPlayFunnels(String column, List<Row> rows) =>
    groupRows(rows, column).map((key, group) => MapEntry(key, getPlayFunnel(group)));

PlayFunnel getPlayFunnel(Iterable<Row> rows) =>
    (visitors: sumColumn(rows, 'store listing visitors'), acquisitions: sumColumn(rows, 'store listing acquisitions'));

List<Object> getPlayCells(String label, PlayFunnel funnel) => [
  label,
  funnel.visitors,
  funnel.acquisitions,
  formatRate(funnel.acquisitions, funnel.visitors),
];

void printPlayTable(String title, Map<String, PlayFunnel> funnels, {int? limit}) => printTable(
  title,
  ['', 'Visitors', 'Acquisitions', 'Conversion'],
  funnels.entries
      .where((entry) => entry.key.isNotEmpty)
      .sortedByDescending((entry) => entry.value.visitors)
      .take(limit ?? funnels.length)
      .map((entry) => getPlayCells(entry.key, entry.value))
      .toList(),
);

// ---------------------------------------------------------------------------
// Tables
// ---------------------------------------------------------------------------

List<Row> parseTable(String text, {required String separator}) {
  final lines = LineSplitter.split(text.replaceFirst('﻿', '')).where((line) => line.trim().isNotEmpty).toList();
  if (lines.isEmpty) return [];

  final headers = splitRow(lines.first, separator).map((header) => header.trim().toLowerCase()).toList();
  return lines
      .skip(1)
      .map((line) => splitRow(line, separator))
      .map(
        (values) => Map.fromEntries(
          headers.mapIndexed((index, header) => MapEntry(header, values.elementAtOrNull(index)?.trim() ?? '')),
        ),
      )
      .toList();
}

List<String> splitRow(String line, String separator) {
  final escaped = RegExp.escape(separator);
  return RegExp('(?:^|$escaped)("(?:[^"]|"")*"|[^$escaped]*)')
      .allMatches(line)
      .map((match) => match.group(1)!)
      .map(
        (field) => field.length >= 2 && field.startsWith('"') && field.endsWith('"')
            ? field.substring(1, field.length - 1).replaceAll('""', '"')
            : field,
      )
      .toList();
}

List<Row> requireColumns(List<Row> rows, List<String> columns, {required String report}) {
  final missing = columns.whereNot((column) => rows.firstOrNull?.containsKey(column) ?? true);
  if (missing.isNotEmpty) {
    fail('$report has no ${missing.join(', ')} column. Its columns are: ${rows.first.keys.join(', ')}');
  }
  return rows;
}

Row normalizeDate(Row row) => {...row, 'date': DateTime.tryParse(row['date']!)?.isoDate ?? row['date']!};

Map<String, List<Row>> groupRows(Iterable<Row> rows, String column) => rows.groupListsBy((row) => row[column] ?? '');

num sumColumn(Iterable<Row> rows, String column) =>
    rows.map((row) => num.tryParse(row[column]?.replaceAll(',', '') ?? '') ?? 0).sum;

String formatRate(num part, num whole) => whole == 0 ? '-' : '${(part / whole * 100).toStringAsFixed(1)}%';

void printTable(String title, List<String> headers, List<List<Object>> rows) {
  if (rows.isEmpty) return;

  final cells = [
    headers,
    ...rows.map(
      (row) => row
          .map(
            (cell) => switch (cell) {
              final num number => number.round().toString(),
              '' => '(none)',
              _ => cell.toString(),
            },
          )
          .toList(),
    ),
  ];
  final widths = headers.mapIndexed((index, _) => cells.map((row) => row[index].length).max).toList();
  stdout.writeln('\n$title');
  stdout.writeln(
    cells
        .map(
          (row) => row
              .mapIndexed((index, cell) => index == 0 ? cell.padRight(widths[index]) : cell.padLeft(widths[index]))
              .join('  '),
        )
        .join('\n'),
  );
}

String readFile(String path) {
  final file = File(path);
  if (!file.existsSync()) fail('$path does not exist.');
  return file.readAsStringSync();
}
