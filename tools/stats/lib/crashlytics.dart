import 'dart:math';

import 'google.dart';

const projectNumber = '365679413474';

enum CrashlyticsApp {
  ios,
  android;

  String get id => switch (this) {
    ios => '1:$projectNumber:ios:241c176505a41fedd2b6bb',
    android => '1:$projectNumber:android:5b19dac485b52fe1d2b6bb',
  };

  List<CrashlyticsErrorType> get errorTypes => switch (this) {
    ios => [.fatal, .nonFatal],
    android => CrashlyticsErrorType.values,
  };
}

enum CrashlyticsErrorType {
  fatal,
  nonFatal,
  anr;

  String get apiName => switch (this) {
    fatal => 'FATAL',
    nonFatal => 'NON_FATAL',
    anr => 'ANR',
  };
}

enum CrashlyticsReport { topIssues, topVersions }

Future<Map<String, dynamic>> getCrashlyticsReports(GoogleApi google, {required int days}) async {
  // Crashlytics rejects intervals that start more than 90 days ago.
  final start = DateTime.now().toUtc().subtract(Duration(days: min(days, 89)));
  final apps = await Future.wait(
    CrashlyticsApp.values.map((app) async => MapEntry(app.name, await getAppReports(google, app, start: start))),
  );
  return {'intervalStart': start.toIso8601String(), ...Map.fromEntries(apps)};
}

Future<Map<String, dynamic>> getAppReports(GoogleApi google, CrashlyticsApp app, {required DateTime start}) async => {
  'appId': app.id,
  for (final errorType in app.errorTypes)
    errorType.name: {
      for (final report in CrashlyticsReport.values)
        report.name: await getReport(google, app, report, errorType, start: start),
    },
};

Future<Map<String, dynamic>> getReport(
  GoogleApi google,
  CrashlyticsApp app,
  CrashlyticsReport report,
  CrashlyticsErrorType errorType, {
  required DateTime start,
}) => google.send(
  Uri.https(
    'firebasecrashlytics.googleapis.com',
    '/v1alpha/projects/$projectNumber/apps/${app.id}/reports/${report.name}',
    {
      'filter.interval.start_time': start.toIso8601String(),
      'filter.interval.end_time': DateTime.now().toUtc().toIso8601String(),
      'filter.issue.error_types': errorType.apiName,
      'page_size': '50',
    },
  ),
);
