import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

enum Platform { tiktok, youtube, instagram, facebook }

Map<String, dynamic> getObject(dynamic value, String label) =>
    value is Map && value.keys.every((key) => key is String)
    ? Map<String, dynamic>.from(value)
    : throw FormatException('$label must be an object');

void checkKeys(Map<String, dynamic> value, Set<String> keys, String label) {
  final unknown = value.keys.toSet().difference(keys);
  if (unknown.isNotEmpty)
    throw FormatException('$label: unknown fields ${unknown.join(', ')}');
}

String getText(dynamic value, String label) =>
    value is String ? value : throw FormatException('$label must be a string');

class Post {
  final Directory folder;
  final Map<String, dynamic> data;
  Post(this.folder, this.data);

  static Future<Post> load(Directory folder) async {
    final data = getObject(
      loadYaml(await File(p.join(folder.path, 'post.yaml')).readAsString()),
      'post',
    );
    checkKeys(data, {
      'title',
      'description',
      'hashtags',
      'media',
      'cover',
      'coverTimestampMs',
      'pinnedComment',
    }, 'post');
    return Post(folder, data);
  }

  Future<PreparedPost> prepare(Platform platform, {bool isAi = false}) async {
    final title = getText(data['title'], 'title');
    final description = getText(data['description'], 'description');
    final hashtags = data['hashtags'] ?? [];
    if (hashtags is! List ||
        hashtags.any(
          (v) =>
              v is! String ||
              !RegExp(r'^#?[\p{L}\p{N}_]+$', unicode: true).hasMatch(v),
        )) {
      throw FormatException(
        'hashtags must contain hashtag words without spaces',
      );
    }
    final media = getObject(data['media'], 'media');
    checkKeys(media, {'video', 'images'}, 'media');
    if (media.containsKey('video') == media.containsKey('images')) {
      throw FormatException('media requires either video or images');
    }
    final isVideo = media.containsKey('video');
    final paths = isVideo ? [media['video']] : media['images'];
    if (paths is! List || paths.isEmpty)
      throw FormatException('images must be a nonempty ordered list');
    final files = await Future.wait(paths.map((path) => getFile(path)));
    final cover = data['cover'] == null ? null : await getFile(data['cover']);
    final timestamp = data['coverTimestampMs'];
    if (timestamp != null && (timestamp is! int || timestamp < 0 || !isVideo))
      throw FormatException(
        'coverTimestampMs must be a nonnegative integer for a video',
      );
    if (cover != null && timestamp != null)
      throw FormatException('Use either cover or coverTimestampMs');
    final comment = data['pinnedComment'] == null
        ? null
        : getText(data['pinnedComment'], 'pinnedComment');
    if (comment != null && comment.trim().isEmpty) {
      throw FormatException(
        'pinnedComment must not be blank; use null to clear it',
      );
    }
    final caption = [
      description,
      if (platform == .tiktok && comment != null) comment,
      hashtags
          .map((v) => '#${(v as String).replaceFirst(RegExp(r'^#'), '')}')
          .join(' '),
    ].where((s) => s.isNotEmpty).join('\n\n');
    return PreparedPost(
      platform,
      title,
      platform == .tiktok ? caption.replaceAll('\n\n', '\n\u00A0\n') : caption,
      files,
      isVideo,
      cover,
      comment,
      isAi: isAi,
      coverTimestampMs: timestamp as int?,
    );
  }

  Future<File> getFile(dynamic path) async {
    final relative = getText(path, 'media path');
    if (relative.isEmpty ||
        p.isAbsolute(relative) ||
        p.split(relative).contains('..') ||
        relative.contains('\\')) {
      throw FormatException(
        'Media paths must stay relative to the post folder',
      );
    }
    final base = await folder.resolveSymbolicLinks();
    final file = File(p.join(base, relative));
    final resolved = await file.resolveSymbolicLinks();
    if (!p.isWithin(base, resolved))
      throw FormatException('Media symlink escapes post folder');
    if (await file.length() == 0)
      throw FormatException('Empty media: $relative');
    return File(resolved);
  }
}

class PreparedPost {
  final Platform platform;
  final String title;
  final String caption;
  final List<File> media;
  final bool isVideo;
  final File? cover;
  final String? pinnedComment;
  final bool isAi;
  final int? coverTimestampMs;
  PreparedPost(
    this.platform,
    this.title,
    this.caption,
    this.media,
    this.isVideo,
    this.cover,
    this.pinnedComment, {
    this.isAi = false,
    this.coverTimestampMs,
  });
  Map<String, dynamic> get settings => switch (platform) {
    .tiktok => {
      'privacy_level': 'PUBLIC_TO_EVERYONE',
      'allow_comment': true,
      if (isVideo) ...{'allow_duet': false, 'allow_stitch': false},
      'commercialContentType': 'brand_organic',
      'video_made_with_ai': isAi,
      if (coverTimestampMs case final timestamp? when isVideo)
        'video_cover_timestamp_ms': timestamp,
      'content_preview_confirmed': true,
      'express_consent_given': true,
    },
    .youtube => {
      'visibility': 'public',
      'madeForKids': false,
      'containsSyntheticMedia': isAi,
    },
    .instagram || .facebook => {},
  };
  PreparedPost getWithCover(File image) => PreparedPost(
    platform,
    title,
    caption,
    media,
    isVideo,
    image,
    pinnedComment,
    isAi: isAi,
    coverTimestampMs: coverTimestampMs,
  );
  List<File> get files => [...media, if (cover case final cover?) cover];
}
