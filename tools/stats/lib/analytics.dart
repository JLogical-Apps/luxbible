import 'google.dart';

enum AnalyticsProperty {
  app,
  website;

  String get id => switch (this) {
    app => '525420474',
    website => '552974802',
  };
}

enum AnalyticsReport {
  appTotals,
  appDaily,
  appEvents,
  appEventUsers,
  appCohorts,
  appAcquisition,
  appScreens,
  appVersions,
  appCountries,
  appLanguages,
  websiteTotals,
  websiteDaily,
  websiteSources,
  websiteEvents,
  websiteLandingPages,
  websitePages,
  websiteStoreClicks,
  websiteCountries;

  AnalyticsProperty get property => switch (this) {
    appTotals ||
    appDaily ||
    appEvents ||
    appEventUsers ||
    appCohorts ||
    appAcquisition ||
    appScreens ||
    appVersions ||
    appCountries ||
    appLanguages => .app,
    _ => .website,
  };

  List<String> get dimensions => switch (this) {
    appTotals => ['platform'],
    appDaily => ['date', 'platform'],
    appEvents => ['date', 'platform', 'eventName'],
    appEventUsers => ['platform', 'eventName', 'newVsReturning'],
    appCohorts => ['firstSessionDate', 'date', 'platform'],
    appAcquisition => ['firstUserSource', 'firstUserMedium', 'firstUserCampaignName', 'platform'],
    appScreens => ['unifiedScreenName', 'platform'],
    appVersions => ['appVersion', 'platform'],
    appCountries => ['country', 'platform'],
    appLanguages => ['language', 'platform'],
    websiteTotals => [],
    websiteDaily => ['date'],
    websiteSources => ['date', 'sessionSource', 'sessionMedium', 'sessionCampaignName'],
    websiteEvents => ['date', 'sessionSource', 'sessionMedium', 'sessionCampaignName', 'eventName'],
    websiteLandingPages => ['landingPage', 'sessionSource', 'deviceCategory'],
    websitePages => ['pagePath'],
    websiteStoreClicks => ['pagePath', 'sessionSource', 'sessionMedium', 'sessionCampaignName'],
    websiteCountries => ['country', 'deviceCategory'],
  };

  List<String> get metrics => switch (this) {
    appTotals => ['activeUsers', 'newUsers', 'sessions', 'userEngagementDuration'],
    // dauPerMau and dauPerWau are only meaningful per date; without one, GA sums them and the user counts beside them.
    appDaily => [
      'activeUsers',
      'newUsers',
      'sessions',
      'engagedSessions',
      'userEngagementDuration',
      'screenPageViews',
      'dauPerMau',
      'dauPerWau',
    ],
    appEvents || appEventUsers || websiteEvents || websiteStoreClicks => ['eventCount', 'totalUsers'],
    appCohorts => ['activeUsers'],
    appAcquisition || appVersions || appLanguages => ['newUsers', 'activeUsers'],
    appScreens || websitePages => ['screenPageViews', 'activeUsers', 'userEngagementDuration'],
    appCountries => ['activeUsers', 'newUsers', 'userEngagementDuration'],
    websiteTotals ||
    websiteDaily => ['sessions', 'totalUsers', 'newUsers', 'engagedSessions', 'userEngagementDuration'],
    websiteSources || websiteLandingPages => ['sessions', 'engagedSessions', 'totalUsers', 'userEngagementDuration'],
    websiteCountries => ['sessions', 'totalUsers'],
  };

  Map<String, dynamic>? get dimensionFilter => switch (this) {
    websiteStoreClicks => {
      'filter': {
        'fieldName': 'eventName',
        'stringFilter': {'matchType': 'EXACT', 'value': 'store_navigation'},
      },
    },
    _ => null,
  };
}

Future<Map<String, dynamic>> getAnalyticsReports(GoogleApi google, {required int days}) async {
  // Reports run one at a time because GA limits concurrent requests per property.
  final entries = await Stream.fromIterable(
    AnalyticsReport.values,
  ).asyncMap((report) async => MapEntry(report.name, await getReportRows(google, report, days: days))).toList();
  return {
    'properties': {for (final property in AnalyticsProperty.values) property.name: property.id},
    'startDate': '${days}daysAgo',
    'endDate': 'yesterday',
    'reports': Map.fromEntries(entries),
  };
}

Future<List<Map<String, Object>>> getReportRows(GoogleApi google, AnalyticsReport report, {required int days}) async {
  final response = await google.send(
    Uri.parse('https://analyticsdata.googleapis.com/v1beta/properties/${report.property.id}:runReport'),
    body: {
      'dateRanges': [
        {'startDate': '${days}daysAgo', 'endDate': 'yesterday'},
      ],
      'dimensions': report.dimensions.map((name) => {'name': name}).toList(),
      'metrics': report.metrics.map((name) => {'name': name}).toList(),
      'dimensionFilter': ?report.dimensionFilter,
      'limit': 250000,
    },
  );
  final dimensions = (response['dimensionHeaders'] as List? ?? []).map((header) => header['name'] as String);
  final metrics = (response['metricHeaders'] as List? ?? []).map((header) => header['name'] as String);
  return (response['rows'] as List? ?? [])
      .map(
        (row) => <String, Object>{
          for (final (index, name) in dimensions.indexed) name: row['dimensionValues'][index]['value'],
          for (final (index, name) in metrics.indexed) name: num.parse(row['metricValues'][index]['value']),
        },
      )
      .toList();
}
