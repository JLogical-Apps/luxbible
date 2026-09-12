import 'dart:async';

import 'package:path/path.dart' as p;

import 'api.dart';
import 'media.dart';
import 'post.dart';

class Destination {
  final String id;
  final String username;
  final String externalId;
  Destination(this.id, this.username, this.externalId);
  String get summary => '$username (provider account $id, native ID $externalId)';
}

class Delivery {
  final String id;
  final String status;
  final String? url;
  final String? nativeId;
  final String? error;
  final Map<String, dynamic> entry;
  Delivery(this.id, this.status, this.url, this.nativeId, this.error, this.entry);
  bool get isSuccess => status.toLowerCase() == 'published';
  bool get isTerminal => isSuccess || {'failed', 'cancelled', 'canceled'}.contains(status.toLowerCase());
  String get summary =>
      '$status, provider post $id${url == null ? ', published URL not yet available' : ', $url'}${error == null ? '' : ', $error'}';
}

class CommentResult {
  final String summary;
  final String? textToCopy;
  CommentResult(this.summary, {this.textToCopy});
}

abstract class Provider {
  final Api api;
  final String accountId;
  final warnings = <String>[];
  Provider(this.api, this.accountId);
  Future<Destination> getDestination(PreparedPost post, List<MediaInfo> media);
  Future<Map<String, dynamic>> upload(PreparedPost post, List<MediaInfo> media);
  Future<Validation> validate(Map<String, dynamic> body);
  Future<Delivery> publish(Map<String, dynamic> body);
  Future<Delivery> getDelivery(String id);
  Future<CommentResult> finishComment(PreparedPost post, Delivery delivery);

  Future<Delivery> poll(
    Delivery initial, {
    Duration timeout = const Duration(minutes: 15),
    Duration interval = const Duration(seconds: 10),
  }) async {
    var delivery = initial;
    final clock = Stopwatch()..start();
    while (!delivery.isTerminal && clock.elapsed < timeout) {
      await Future<void>.delayed(interval);
      try {
        delivery = await getDelivery(initial.id);
      } on ApiFailure catch (error) {
        if (error.status != null && error.status != 429 && error.status! < 500) rethrow;
        warnings.add('Transient status read failed; polling continued: ${getSafeMessage(error)}');
      }
    }
    return delivery;
  }
}

class Zernio extends Provider {
  final Platform platform;
  Zernio(super.api, super.accountId, this.platform);

  @override
  Future<Destination> getDestination(PreparedPost post, List<MediaInfo> media) async {
    final result = getObject(await api.call('GET', 'accounts'), 'accounts');
    final accounts = (result['accounts'] as List).cast<Map<String, dynamic>>();
    final account = accounts.where((a) => a['_id'] == accountId && a['platform'] == platform.name).firstOrNull;
    if (account == null ||
        account['isActive'] == false ||
        account['needsReconnection'] == true ||
        account['enabled'] == false)
      throw FormatException(
        'Configured ${platform.name} account was not found or is inactive. Check ID and connection.',
      );
    if (platform == .tiktok) {
      final info = getObject(
        await api.call(
          'GET',
          'accounts/${Uri.encodeComponent(accountId)}/tiktok/creator-info?mediaType=${post.isVideo ? 'video' : 'photo'}',
        ),
        'creator info',
      );
      final levels = (info['privacyLevels'] as List).map((v) => v is Map ? v['value'] : v).toSet();
      if (!levels.contains(post.settings['privacy_level']))
        throw FormatException('TikTok privacy must be one of ${levels.join(', ')}');
      final creator = getObject(info['creator'], 'creator');
      if (creator['canPostMore'] == false)
        throw FormatException('TikTok creator cannot post more right now. Check daily posting limits.');
      final limits = getObject(info['postingLimits'], 'posting limits');
      if (post.isVideo && media.first.duration > (limits['maxVideoDurationSec'] as num))
        throw FormatException('Video exceeds this TikTok creator’s maximum duration');
      final interactions = getObject(limits['interactionSettings'], 'interaction settings');
      for (final key in [
        'allow_comment',
        if (post.isVideo) ...['allow_duet', 'allow_stitch'],
      ]) {
        final setting = getObject(interactions[key], key);
        if (setting['enabled'] == false && post.settings[key] == true)
          throw FormatException(
            'TikTok creator has disabled $key; this command enables comments, so use native publishing for this account',
          );
      }
      final commercial = (info['commercialContentTypes'] as List).map((v) => v['value']).toSet();
      if (!commercial.contains(post.settings['commercialContentType']))
        throw FormatException('TikTok disclosure unavailable; creator permits ${commercial.join(', ')}');
    }
    return Destination(
      accountId,
      '${account['username'] ?? account['displayName']}',
      '${account['platformAccountId'] ?? 'not returned'}',
    );
  }

  @override
  Future<Map<String, dynamic>> upload(PreparedPost post, List<MediaInfo> media) async {
    final urls = await getUploadedMedia(media.take(post.media.length), uploadFile);
    final tiktok = {...post.settings};
    if (platform == .tiktok && post.isVideo && post.cover != null)
      tiktok['video_cover_image_url'] = await uploadFile(media.last);
    return {
      'content': platform == .tiktok && !post.isVideo ? post.title : post.caption,
      'mediaItems': urls.map((url) => {'type': post.isVideo ? 'video' : 'image', 'url': url}).toList(),
      'platforms': [
        {
          'platform': platform.name,
          'accountId': accountId,
          if (platform == .youtube) 'platformSpecificData': {'title': post.title, ...post.settings},
        },
      ],
      'publishNow': true,
      if (platform == .tiktok)
        'tiktokSettings': {
          ...tiktok,
          'draft': false,
          if (!post.isVideo) ...{'media_type': 'photo', 'description': post.caption, 'auto_add_music': false},
        },
    };
  }

  Future<String> uploadFile(MediaInfo item) async {
    final data = getObject(
      await api.call(
        'POST',
        'media/presign',
        body: {'filename': p.basename(item.file.path), 'contentType': item.mime, 'size': item.bytes},
      ),
      'presign',
    );
    await api.putFile(getText(data['uploadUrl'], 'uploadUrl'), item.file, mime: item.mime);
    return getText(data['publicUrl'], 'publicUrl');
  }

  @override
  Future<Validation> validate(Map<String, dynamic> body) async {
    if (platform != .tiktok) return Validation([], []);
    final data = getObject(await api.call('POST', 'posts', body: {...body, 'dryRun': true}), 'dry run');
    return Validation(
      data['canPublish'] == true ? [] : ['TikTok dry run rejected direct posting: ${getSafeMessage(data)}'],
      [],
    );
  }

  @override
  Future<Delivery> publish(Map<String, dynamic> body) async {
    final requestId = getRequestId();

    final data = getObject(
      await api.call('POST', 'posts', body: body, headers: {'x-request-id': requestId}),
      'publish',
    );

    if (data['warnings'] case final messages?) warnings.add(getSafeMessage(messages));
    return getParsedDelivery(getObject(data['post'] ?? data['existingPost'], 'post'));
  }

  Delivery getParsedDelivery(Map<String, dynamic> post) {
    final entry = (post['platforms'] as List)
        .cast<Map<String, dynamic>>()
        .where(
          (p) =>
              p['platform'] == platform.name &&
              (p['accountId'] is Map ? p['accountId']['_id'] : p['accountId']) == accountId,
        )
        .firstOrNull;
    if (entry == null)
      throw FormatException(
        'Provider response did not contain the selected destination. Check provider dashboard before retrying.',
      );
    return Delivery(
      getText(post['_id'], 'post ID'),
      getText(entry['status'], 'delivery status'),
      entry['platformPostUrl'] as String?,
      entry['platformPostId'] as String?,
      entry['error'] == null ? null : getSafeMessage(entry['error']),
      entry,
    );
  }

  @override
  Future<Delivery> getDelivery(String id) async => getParsedDelivery(
    getObject(getObject(await api.call('GET', 'posts/${Uri.encodeComponent(id)}'), 'response')['post'], 'post'),
  );

  @override
  Future<CommentResult> finishComment(PreparedPost post, Delivery delivery) async {
    final comment = post.pinnedComment;
    if (comment == null) return CommentResult('No comment requested');
    if (platform == .tiktok) {
      return CommentResult('Discussion prompt included before hashtags in the TikTok description');
    }
    final key = getRequestId();
    try {
      final response = getObject(
        await api.call(
          'POST',
          'inbox/comments/${Uri.encodeComponent(delivery.id)}/reply',
          body: {'accountId': accountId, 'message': comment},
          headers: {'Idempotency-Key': key},
        ),
        'comment response',
      );
      if (response['success'] != true) {
        return CommentResult(
          'Comment creation unconfirmed. Check native comments before posting manually.',
          textToCopy: comment,
        );
      }
      final id = getText(getObject(response['data'], 'comment data')['commentId'], 'comment ID');
      return CommentResult('Comment created ($id). Pin manually in YouTube Studio; no supported YouTube pin endpoint.');
    } catch (error) {
      return CommentResult(
        'Comment creation not confirmed: ${getSafeMessage(error)}. Check native comments before posting manually; comment request key $key.',
        textToCopy: comment,
      );
    }
  }
}

class WoopSocial extends Provider {
  final String projectId;
  final Platform platform;
  WoopSocial(super.api, super.accountId, this.projectId, this.platform);

  @override
  Future<Destination> getDestination(PreparedPost post, List<MediaInfo> media) async {
    final data = await api.call('GET', 'social-accounts?projectId=${Uri.encodeQueryComponent(projectId)}');
    final account = (data as List)
        .cast<Map<String, dynamic>>()
        .where(
          (a) => a['id'] == accountId && a['platform'] == platform.name.toUpperCase() && a['status'] == 'CONNECTED',
        )
        .firstOrNull;
    if (account == null)
      throw FormatException('Configured ${platform.name} account not connected in the selected WoopSocial project');
    return Destination(
      accountId,
      getText(account['username'], 'username'),
      getText(account['externalAccountId'], 'native account ID'),
    );
  }

  @override
  Future<Map<String, dynamic>> upload(PreparedPost post, List<MediaInfo> media) async {
    final references = await getUploadedMedia(media.take(post.media.length), uploadFile);
    final cover = platform == .instagram && post.isVideo && post.cover != null ? await uploadFile(media.last) : null;
    return {
      'content': [
        {'text': post.caption, 'media': references},
      ],
      'schedule': {'type': 'PUBLISH_NOW'},
      'socialAccounts': [
        {
          'platform': platform.name.toUpperCase(),
          'socialAccountId': accountId,
          'postType': post.isVideo
              ? 'REEL'
              : platform == .instagram
              ? 'POST'
              : 'IMAGE',
          if (cover != null) 'cover': cover,
        },
      ],
      'autoDeleteMediaAfterPublish': true,
    };
  }

  Future<Map<String, dynamic>> uploadFile(MediaInfo item) async {
    final session = getObject(
      await api.call('POST', 'media/upload-sessions', body: {'projectId': projectId, 'fileSizeInBytes': item.bytes}),
      'upload session',
    );
    final id = getText(session['uploadSessionId'], 'upload session ID');

    final size = (session['partSizeInBytes'] as num).toInt();
    final parts = (session['parts'] as List).cast<Map<String, dynamic>>();
    if (parts.map((p) => p['partNumber']).toSet().length != parts.length)
      throw FormatException('Duplicate upload part numbers');
    if (size <= 0 || parts.length != session['partCount'] || parts.length != (item.bytes / size).ceil())
      throw FormatException('Invalid upload session part layout');
    for (final part in parts) {
      final start = ((part['partNumber'] as int) - 1) * size;
      if (start < 0 || start >= item.bytes) throw FormatException('Invalid upload part number');
      await api.putFile(
        getText(part['uploadUrl'], 'upload URL'),
        item.file,
        start: start,
        end: (start + size).clamp(0, item.bytes),
      );
    }
    var result = getObject(
      await api.call('POST', 'media/upload-sessions/${Uri.encodeComponent(id)}/complete'),
      'completion',
    );
    final clock = Stopwatch()..start();
    while (!{'READY', 'FAILED', 'ABORTED'}.contains(result['status']) && clock.elapsed < Duration(minutes: 10)) {
      await Future<void>.delayed(Duration(seconds: 5));
      result = getObject(await api.call('GET', 'media/upload-sessions/${Uri.encodeComponent(id)}'), 'upload status');
    }
    if (result['status'] != 'READY')
      throw FormatException(
        'Upload session $id ${result['status']}: ${getSafeMessage(result['failureMessage'])}. Check provider dashboard.',
      );
    final mediaId = getText(result['mediaId'], 'media ID');

    return {'type': 'MEDIA_LIBRARY', 'mediaId': mediaId};
  }

  @override
  Future<Validation> validate(Map<String, dynamic> body) async {
    final data = getObject(await api.call('POST', 'posts/validate', body: body), 'validation');
    final errors = (data['errors'] as List).map(getSafeMessage).toList();
    if (data['isValid'] != true && errors.isEmpty) errors.add('WoopSocial rejected validation');
    return Validation(errors, (data['warnings'] as List).map(getSafeMessage).toList());
  }

  @override
  Future<Delivery> publish(Map<String, dynamic> body) async =>
      getParsedDelivery(getObject(await api.call('POST', 'posts', body: body), 'post'));

  Delivery getParsedDelivery(Map<String, dynamic> post) {
    final entry = (post['socialAccountPosts'] as List)
        .cast<Map<String, dynamic>>()
        .where((p) => p['socialAccountId'] == accountId)
        .firstOrNull;
    if (entry == null) throw FormatException('Response omitted selected destination; check dashboard before retrying');
    return Delivery(
      getText(post['id'], 'post ID'),
      getText(entry['deliveryStatus'], 'status'),
      entry['externalPostUrl'] as String?,
      entry['externalPostId'] as String?,
      entry['errorMessage'] as String?,
      entry,
    );
  }

  @override
  Future<Delivery> getDelivery(String id) async =>
      getParsedDelivery(getObject(await api.call('GET', 'posts/${Uri.encodeComponent(id)}'), 'post'));

  @override
  Future<CommentResult> finishComment(PreparedPost post, Delivery delivery) async => post.pinnedComment == null
      ? CommentResult('No comment requested')
      : CommentResult(
          'Post this comment manually and pin it in the native app where available.',
          textToCopy: post.pinnedComment,
        );
}

Future<List<T>> getUploadedMedia<T>(Iterable<MediaInfo> media, Future<T> Function(MediaInfo) upload) =>
    media.fold(Future.value(<T>[]), (previous, item) async => [...await previous, await upload(item)]);
