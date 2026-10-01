import 'dart:convert';
import 'dart:io' hide Platform;
import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import '../lib/api.dart';
import '../lib/environment.dart';
import '../lib/post.dart' show Platform;

const graphUrl = 'https://graph.facebook.com/v26.0';

class PostStats {
  final DateTime date;
  final String type;
  final String caption;
  final num? views;
  final num? reach;
  final num? likes;
  final num? comments;
  final num? shares;
  final num? saves;
  final num? averageWatchMs;

  PostStats({
    required this.date,
    required this.type,
    required this.caption,
    this.views,
    this.reach,
    this.likes,
    this.comments,
    this.shares,
    this.saves,
    this.averageWatchMs,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toUtc().toIso8601String(),
    'type': type,
    'caption': caption,
    'views': views,
    'reach': reach,
    'likes': likes,
    'comments': comments,
    'shares': shares,
    'saves': saves,
    'averageWatchMs': averageWatchMs,
  };
}

class AccountStats {
  final Platform platform;
  final String handle;
  final num followers;
  final num? gained;
  final List<PostStats> posts;

  AccountStats({
    required this.platform,
    required this.handle,
    required this.followers,
    this.gained,
    required this.posts,
  });

  Map<String, dynamic> toJson() => {
    'platform': platform.name,
    'handle': handle,
    'followers': followers,
    'gained': gained,
    'posts': posts.map((post) => post.toJson()).toList(),
  };
}

extension on Platform {
  String get label => switch (this) {
    .tiktok => 'TikTok',
    .youtube => 'YouTube',
    .instagram => 'Instagram',
    .facebook => 'Facebook',
  };
}

Future<void> main(List<String> args) async {
  try {
    final parser = getParser();
    final options = parser.parse(args);
    if (options.flag('help')) {
      stdout.writeln(
        'From tools/socials: dart run bin/stats.dart [options]\n${parser.usage}',
      );
      return;
    }
    final days =
        int.tryParse(options.option('days')!) ??
        (throw FormatException('--days needs a number, like --days 90'));
    loadEnvironment(p.join(getRepository().path, 'tools', 'socials', '.env'));
    final since = DateTime.now().subtract(Duration(days: days));
    final results = await Future.wait(
      options.multiOption('platform').map(Platform.values.byName).map((
        platform,
      ) async {
        try {
          return await getAccountStats(platform, since);
        } catch (error) {
          return '${platform.label}: ${getSafeMessage(error)}';
        }
      }),
    );
    final accounts = results.whereType<AccountStats>().toList();
    final failures = results.whereType<String>();
    if (options.flag('json')) {
      stdout.write(
        jsonEncode({
          'since': since.toUtc().toIso8601String(),
          'accounts': accounts.map((account) => account.toJson()).toList(),
          'failures': failures.toList(),
        }),
      );
    } else {
      accounts.forEach(printPosts);
      printSummary(accounts, since);
    }
    if (failures.isNotEmpty) {
      stderr.writeln('\nFailed:\n${failures.join('\n')}');
      exitCode = 1;
    }
  } catch (error) {
    stderr.writeln('Failed: ${getSafeMessage(error)}');
    exitCode = 1;
  }
}

Future<AccountStats> getAccountStats(Platform platform, DateTime since) =>
    switch (platform) {
      .tiktok || .youtube => useApi(
        Api(
          'https://zernio.com/api/v1',
          getRequiredEnvironment('ZERNIO_API_KEY'),
        ),
        (zernio) => getZernioStats(zernio, platform, since),
      ),
      .instagram => useApi(
        Api(graphUrl, getRequiredEnvironment('META_ACCESS_TOKEN')),
        (meta) => getInstagramStats(meta, since),
      ),
      .facebook => useApi(
        Api(graphUrl, getRequiredEnvironment('META_ACCESS_TOKEN')),
        (meta) => getFacebookStats(meta, since),
      ),
    };

Future<T> useApi<T>(Api api, Future<T> Function(Api api) run) async {
  try {
    return await run(api);
  } finally {
    api.close();
  }
}

// ---------------------------------------------------------------------------
// Meta
// ---------------------------------------------------------------------------

Future<Map<String, dynamic>> getPage(Api meta) async {
  final pages = await getGraphItems(meta, 'me/accounts', {
    'fields':
        'id,name,access_token,followers_count,'
        'instagram_business_account{id,username,followers_count}',
  });
  if (pages.length != 1)
    throw FormatException(
      'META_ACCESS_TOKEN must reach exactly one Facebook Page, found ${pages.length}',
    );
  return pages.single;
}

Future<AccountStats> getInstagramStats(Api meta, DateTime since) async {
  final account =
      (await getPage(meta))['instagram_business_account'] ??
      (throw FormatException(
        'The Facebook Page has no linked Instagram account',
      ));
  bool isPast(Map<String, dynamic> item) =>
      DateTime.parse(item['timestamp']).isBefore(since);

  // Graph lists media newest first and has no date filter, so paging stops at the first older post.
  final media = (await getGraphItems(meta, '${account['id']}/media', {
    'fields':
        'id,caption,media_type,media_product_type,timestamp,'
        'insights.metric(views,reach,likes,comments,shares,saved)',
    'limit': '50',
  }, isPast: isPast)).whereNot(isPast).toList();
  final watchTimes = Map.fromEntries(
    await Future.wait(
      media
          .where((item) => item['media_product_type'] == 'REELS')
          .map(
            (item) async => MapEntry(
              item['id'],
              getLifetimeValues(
                await meta.call(
                  'GET',
                  '${item['id']}/insights?metric=ig_reels_avg_watch_time',
                ),
              )['ig_reels_avg_watch_time'],
            ),
          ),
    ),
  );

  return AccountStats(
    platform: .instagram,
    handle: '@${account['username']}',
    followers: account['followers_count'],
    posts: media.map((item) {
      final values = getLifetimeValues(item['insights']);
      return PostStats(
        date: DateTime.parse(item['timestamp']),
        type: getInstagramType(item),
        caption: item['caption'] ?? '',
        views: values['views'],
        reach: values['reach'],
        likes: values['likes'],
        comments: values['comments'],
        shares: values['shares'],
        saves: values['saved'],
        averageWatchMs: watchTimes[item['id']],
      );
    }).toList(),
  );
}

String getInstagramType(Map<String, dynamic> item) =>
    switch ((item['media_product_type'], item['media_type'])) {
      ('REELS', _) => 'Reel',
      (_, 'CAROUSEL_ALBUM') => 'Carousel',
      (_, 'VIDEO') => 'Video',
      _ => 'Photo',
    };

Future<AccountStats> getFacebookStats(Api meta, DateTime since) async {
  final page = await getPage(meta);

  // Page insights only accept the Page's own token, not the system user token.
  return useApi(Api(graphUrl, page['access_token']), (pageApi) async {
    final posts = await getGraphItems(pageApi, '${page['id']}/posts', {
      'fields':
          'message,created_time,status_type,shares,'
          'insights.metric(post_media_view,post_total_media_view_unique,post_reactions_by_type_total)',
      'since': '${getUnixTime(since)}',
      'limit': '50',
    });
    return AccountStats(
      platform: .facebook,
      handle: page['name'],
      followers: page['followers_count'],
      gained: await getPageFollowerGain(pageApi, page['id'], since),
      posts: posts.map((item) {
        final values = getLifetimeValues(item['insights']);
        return PostStats(
          date: DateTime.parse(item['created_time']),
          type: switch (item['status_type']) {
            'added_video' => 'Video',
            'added_photos' => 'Photo',
            _ => 'Post',
          },
          caption: item['message'] ?? '',
          views: values['post_media_view'],
          reach: values['post_total_media_view_unique'],
          likes: (values['post_reactions_by_type_total'] as Map?)?.values
              .cast<num>()
              .sum,
          // Comment counts would need the pages_read_user_content permission.
          shares: item['shares']?['count'] ?? 0,
        );
      }).toList(),
    );
  });
}

Future<num> getPageFollowerGain(
  Api pageApi,
  String pageId,
  DateTime since,
) async {
  final now = DateTime.now();
  final windowLength = Duration(days: 90);

  // Page insights reject ranges longer than 93 days.
  final responses = await Future.wait(
    List.generate(
      (now.difference(since).inMinutes / windowLength.inMinutes).ceil(),
      (index) => since.add(windowLength * index),
    ).map(
      (start) => pageApi.call(
        'GET',
        Uri(
          path: '$pageId/insights',
          queryParameters: {
            'metric': 'page_daily_follows_unique,page_daily_unfollows_unique',
            'period': 'day',
            'since': '${getUnixTime(start)}',
            'until':
                '${getUnixTime(minBy([start.add(windowLength), now], (date) => date)!)}',
          },
        ).toString(),
      ),
    ),
  );
  num getTotal(String metric) => responses
      .expand((response) => response['data'] as List)
      .where((data) => data['name'] == metric)
      .expand((data) => data['values'] as List)
      .map((value) => value['value'] as num)
      .sum;
  return getTotal('page_daily_follows_unique') -
      getTotal('page_daily_unfollows_unique');
}

Future<List<Map<String, dynamic>>> getGraphItems(
  Api api,
  String path,
  Map<String, String> query, {
  bool Function(Map<String, dynamic> item)? isPast,
}) async {
  final page = await api.call(
    'GET',
    Uri(path: path, queryParameters: query).toString(),
  );
  final items = (page['data'] as List).cast<Map<String, dynamic>>();
  final hasMore =
      page['paging']?['next'] != null &&
      items.isNotEmpty &&
      !(isPast?.call(items.last) ?? false);
  return switch (page['paging']?['cursors']?['after']) {
    final String after when hasMore => [
      ...items,
      ...await getGraphItems(api, path, {
        ...query,
        'after': after,
      }, isPast: isPast),
    ],
    _ => items,
  };
}

Map<String, dynamic> getLifetimeValues(Map<String, dynamic>? insights) => {
  for (final metric in insights?['data'] as List? ?? [])
    if (metric['period'] == 'lifetime')
      metric['name'] as String: metric['values'][0]['value'],
};

int getUnixTime(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;

// ---------------------------------------------------------------------------
// Zernio
// ---------------------------------------------------------------------------

Future<AccountStats> getZernioStats(
  Api zernio,
  Platform platform,
  DateTime since,
) async {
  final accountId = getRequiredEnvironment(
    'ZERNIO_${platform.name.toUpperCase()}_ACCOUNT_ID',
  );
  final fromDate = getIsoDate(since);
  final followerStats = await zernio.call(
    'GET',
    'accounts/follower-stats?accountIds=$accountId&fromDate=$fromDate',
  );
  final account = (followerStats['accounts'] as List).singleWhere(
    (account) => account['_id'] == accountId,
  );
  final posts = await getZernioPosts(zernio, accountId, fromDate);
  final isTikTok = platform == .tiktok;

  return AccountStats(
    platform: platform,
    handle: '@${account['username']}',
    followers: account['currentFollowers'],
    gained: account['growth'],
    posts: posts.map((post) {
      final analytics =
          ((post['platforms'] as List).firstWhereOrNull(
            (target) => target['accountId'] == accountId,
          ) ??
          post)['analytics'];
      return PostStats(
        date: DateTime.parse(post['publishedAt']),
        type: switch (post['mediaType']) {
          final String type when type.isNotEmpty =>
            '${type[0].toUpperCase()}${type.substring(1)}',
          _ => 'Post',
        },
        caption: post['content'] ?? '',
        views: analytics['views'],
        likes: analytics['likes'],
        comments: analytics['comments'],
        // Zernio reports zeros for metrics YouTube doesn't provide, so they're hidden instead.
        reach: isTikTok ? analytics['reach'] : null,
        shares: isTikTok ? analytics['shares'] : null,
        saves: isTikTok ? analytics['saves'] : null,
        averageWatchMs: isTikTok ? analytics['igReelsAvgWatchTime'] : null,
      );
    }).toList(),
  );
}

Future<List<Map<String, dynamic>>> getZernioPosts(
  Api zernio,
  String accountId,
  String fromDate, {
  int page = 1,
}) async {
  final response = await zernio.call(
    'GET',
    'analytics?accountId=$accountId&fromDate=$fromDate&limit=100&page=$page',
  );
  final posts = (response['posts'] as List).cast<Map<String, dynamic>>();
  return page < (response['pagination']?['pages'] ?? 1)
      ? [
          ...posts,
          ...await getZernioPosts(zernio, accountId, fromDate, page: page + 1),
        ]
      : posts;
}

// ---------------------------------------------------------------------------
// Output
// ---------------------------------------------------------------------------

final postColumns = <(String, Object? Function(PostStats post))>[
  ('Views', (post) => post.views),
  ('Reach', (post) => post.reach),
  ('Likes', (post) => post.likes),
  ('Comments', (post) => post.comments),
  ('Shares', (post) => post.shares),
  ('Saves', (post) => post.saves),
  (
    'Avg watch',
    (post) => switch (post.averageWatchMs) {
      final ms? => Duration(milliseconds: ms.round()),
      _ => null,
    },
  ),
];

void printPosts(AccountStats account) {
  final columns = postColumns
      .where((column) => account.posts.any((post) => column.$2(post) != null))
      .toList();
  stdout.writeln(
    '\n${account.platform.label} ${account.handle}: ${account.followers} followers',
  );
  if (account.posts.isEmpty) {
    stdout.writeln('No posts in this period.');
    return;
  }
  printTable(
    ['Date', 'Type', ...columns.map((column) => column.$1), 'Caption'],
    account.posts
        .sortedByCompare((post) => post.date, (a, b) => b.compareTo(a))
        .map(
          (post) => [
            getIsoDate(post.date),
            post.type,
            ...columns.map((column) => column.$2(post)),
            getSnippet(post.caption),
          ],
        )
        .toList(),
  );
}

void printSummary(List<AccountStats> accounts, DateTime since) {
  if (accounts.isEmpty) return;
  stdout.writeln('\nSummary of posts since ${getIsoDate(since)}');
  printTable(
    [
      '',
      'Followers',
      'Gained',
      'Posts',
      'Views',
      'Avg views',
      'Likes',
      'Comments',
      'Shares',
    ],
    accounts.map((account) {
      final views = getTotal(account.posts.map((post) => post.views));
      return [
        account.platform.label,
        account.followers,
        account.gained,
        account.posts.length,
        views,
        views == null || account.posts.isEmpty
            ? null
            : views / account.posts.length,
        getTotal(account.posts.map((post) => post.likes)),
        getTotal(account.posts.map((post) => post.comments)),
        getTotal(account.posts.map((post) => post.shares)),
      ];
    }).toList(),
  );
}

void printTable(List<String> headers, List<List<Object?>> rows) {
  final isLeftAligned = headers
      .mapIndexed((index, _) => rows.every((row) => row[index] is String?))
      .toList();
  final cells = [
    headers,
    ...rows.map(
      (row) => row
          .map(
            (cell) => switch (cell) {
              null => '-',
              final num number => number.round().toString(),
              final Duration duration =>
                '${(duration.inMilliseconds / 1000).toStringAsFixed(1)}s',
              _ => cell.toString(),
            },
          )
          .toList(),
    ),
  ];
  final widths = headers
      .mapIndexed((index, _) => cells.map((row) => row[index].length).max)
      .toList();
  stdout.writeln(
    cells
        .map(
          (row) => row
              .mapIndexed(
                (index, cell) => isLeftAligned[index]
                    ? cell.padRight(widths[index])
                    : cell.padLeft(widths[index]),
              )
              .join('  ')
              .trimRight(),
        )
        .join('\n'),
  );
}

num? getTotal(Iterable<num?> values) =>
    values.nonNulls.isEmpty ? null : values.nonNulls.sum;

String getIsoDate(DateTime date) =>
    date.toLocal().toIso8601String().substring(0, 10);

String getSnippet(String text) {
  final line = text
      .split('\n')
      .map((line) => line.trim())
      .firstWhere((line) => line.isNotEmpty, orElse: () => '');
  return line.runes.length > 40
      ? '${String.fromCharCodes(line.runes.take(39))}…'
      : line;
}

ArgParser getParser() => ArgParser()
  ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage.')
  ..addFlag(
    'json',
    negatable: false,
    help: 'Print every account and post as JSON instead of tables.',
  )
  ..addOption(
    'days',
    defaultsTo: '28',
    help: 'Include posts published in this many past days.',
  )
  ..addMultiOption(
    'platform',
    allowed: Platform.values.map((platform) => platform.name),
    defaultsTo: Platform.values.map((platform) => platform.name),
    help: 'Platforms, separated by commas. Repeated options combine.',
  );
