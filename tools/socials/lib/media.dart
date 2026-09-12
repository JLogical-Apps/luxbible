import 'dart:convert';
import 'dart:io' hide Platform;
import 'package:path/path.dart' as p;
import 'post.dart';

class MediaInfo {
  final File file;
  final int bytes;
  final List<Map<String, dynamic>> streams;
  Map<String, dynamic> get stream =>
      streams.firstWhere((s) => s['codec_type'] == 'video');
  final Map<String, dynamic> format;
  MediaInfo(this.file, this.bytes, this.streams, this.format);
  int get width => (stream['width'] as num).toInt();
  int get height => (stream['height'] as num).toInt();
  double get ratio => width / height;
  double get duration => double.tryParse('${format['duration']}') ?? 0;
  String get codec => '${stream['codec_name']}';
  String? get audioCodec =>
      streams
              .where((s) => s['codec_type'] == 'audio')
              .firstOrNull?['codec_name']
          as String?;
  double get frameRate {
    final parts = '${stream['avg_frame_rate']}'.split('/');
    return parts.length == 2 && (double.tryParse(parts.last) ?? 0) > 0
        ? (double.tryParse(parts.first) ?? 0) / double.parse(parts.last)
        : 0;
  }

  num get rotation =>
      (stream['side_data_list'] as List? ?? [])
          .whereType<Map>()
          .map((s) => s['rotation'])
          .whereType<num>()
          .firstOrNull ??
      0;
  String get extension =>
      p.extension(file.path).replaceFirst('.', '').toLowerCase();
  String get mime => switch (extension) {
    'jpg' || 'jpeg' => 'image/jpeg',
    'png' => 'image/png',
    'webp' => 'image/webp',
    'mp4' => 'video/mp4',
    'mov' => 'video/quicktime',
    'webm' => 'video/webm',
    _ => throw FormatException('Unsupported local file type: $extension'),
  };
  String get summary =>
      '${file.path}: $width x $height, $codec, audio ${audioCodec ?? 'none'}, ${frameRate.toStringAsFixed(2)} fps, rotation $rotation, ${duration.toStringAsFixed(2)}s, ${(bytes / 1000000).toStringAsFixed(2)} MB';

  static Future<MediaInfo> read(File file) async {
    final result = await Process.run('ffprobe', [
      '-v',
      'error',
      '-show_streams',
      '-show_format',
      '-of',
      'json',
      file.path,
    ]).timeout(Duration(seconds: 30));
    if (result.exitCode != 0)
      throw FormatException('ffprobe could not read ${file.path}');
    final data = getObject(jsonDecode(result.stdout as String), 'ffprobe');
    final streams = (data['streams'] as List).cast<Map<String, dynamic>>();
    final visual = streams.where((s) => s['codec_type'] == 'video').firstOrNull;
    if (visual == null || visual['width'] == null || visual['height'] == null)
      throw FormatException('No visual media in ${file.path}');
    return MediaInfo(
      file,
      await file.length(),
      streams,
      getObject(data['format'], 'format'),
    );
  }
}

class Validation {
  final List<String> errors;
  final List<String> warnings;
  Validation(this.errors, this.warnings);
}

Validation getValidation(PreparedPost post, List<MediaInfo> info) {
  final media = info.take(post.media.length).toList();
  final errors = <String>[];
  final warnings = <String>[
    if (post.pinnedComment == null)
      'No discussion prompt supplied. Add pinnedComment to invite discussion on this post.',
  ];
  final platform = post.platform;
  void require(bool condition, String message) {
    if (!condition) errors.add(message);
  }

  void recommend(bool condition, String message) {
    if (!condition) warnings.add(message);
  }

  require(post.title.trim().isNotEmpty, 'Title cannot be empty');
  final limit = switch (platform) {
    .tiktok => post.isVideo ? 2200 : 4000,
    .youtube => 5000,
    .instagram => 2200,
    .facebook => 63206,
  };
  if (platform == .tiktok || platform == .youtube) {
    require(
      post.caption.runes.length <= limit,
      'Caption exceeds $limit characters, including hashtags',
    );
  } else {
    recommend(
      post.caption.runes.length <= limit,
      'Caption exceeds the common $limit character limit; WoopSocial validation must accept it',
    );
  }
  for (final item in info) {
    require(item.width > 0 && item.height > 0, 'Invalid media dimensions');
    item.mime;
  }
  for (final item in media) {
    require(
      post.isVideo
          ? {'mp4', 'mov', 'webm'}.contains(item.extension)
          : {'jpg', 'jpeg', 'png', 'webp'}.contains(item.extension),
      'Local tool supports MP4/MOV/WebM videos or JPEG/PNG/WebP images',
    );
    require(
      post.isVideo
          ? !{'mjpeg', 'png', 'webp'}.contains(item.codec)
          : {'mjpeg', 'png', 'webp'}.contains(item.codec),
      'File contents do not match video/image selection',
    );
    recommend(
      item.width == 1080 && item.height == 1920,
      'Recommended social video/photo dimensions: 1080 x 1920; source is ${item.width} x ${item.height}',
    );
    if (post.isVideo) {
      recommend(
        (item.frameRate - 30).abs() < .01,
        '30 fps recommended; source is ${item.frameRate.toStringAsFixed(2)} fps',
      );
      recommend(
        item.audioCodec == 'aac',
        'AAC audio recommended; source is ${item.audioCodec ?? 'silent'}',
      );
      recommend(
        item.rotation == 0,
        'Source uses rotation metadata; normalize rotation before delivery for predictable framing',
      );
    }
    if (post.isVideo)
      recommend(
        item.codec == 'h264',
        'H.264 recommended; source codec is ${item.codec}',
      );
  }
  if (post.cover case final cover?) {
    final item = info.last;
    require(
      {'jpg', 'jpeg', 'png', 'webp'}.contains(item.extension) &&
          {'mjpeg', 'png', 'webp'}.contains(item.codec),
      'Cover must be a JPEG/PNG/WebP image: ${cover.path}',
    );
  }
  if (post.coverTimestampMs case final timestamp?) {
    require(
      post.isVideo && timestamp < media.first.duration * 1000,
      'Cover timestamp must fall within the video',
    );
    if (platform == .youtube || platform == .facebook)
      warnings.add(
        '${platform.name} does not support a cover timestamp in this publishing flow; it will be ignored',
      );
  }
  switch (platform) {
    case .tiktok:
      require(
        post.isVideo || media.length <= 35,
        'TikTok permits at most 35 photos',
      );
      require(
        post.isVideo ||
            post.title.runes.length <= 90 &&
                !post.title.contains('#') &&
                !post.title.contains('://'),
        'TikTok photo title must be at most 90 characters without hashtags or URLs',
      );
      for (final item in media) {
        require(
          item.bytes <=
              (post.isVideo ? 4 * 1024 * 1024 * 1024 : 20 * 1024 * 1024),
          'TikTok media exceeds ${post.isVideo ? '4 GB' : '20 MB'}',
        );
        if (post.isVideo) {
          require(
            item.duration >= 3 && item.duration <= 600,
            'TikTok video must be 3 to 600 seconds',
          );
          require(item.codec == 'h264', 'TikTok documents H.264 encoding');
        }
      }
      if (!post.isVideo && post.settings['video_made_with_ai'] == true)
        warnings.add(
          'TikTok Business-app connections reject AI-disclosed direct photo posts. Creator dry run or downstream publishing may reject this; use a compatible destination or media.',
        );
      if (post.cover != null) {
        require(
          info.last.bytes <= 20 * 1024 * 1024,
          'TikTok cover exceeds 20 MB',
        );
        warnings.add(
          post.isVideo
              ? 'TikTok custom covers may insert a frame on older developer-app connections; Business-app connections use a separate cover URL.'
              : 'Separate cover ignored for TikTok photos; select photo_cover_index instead.',
        );
      }
      for (final key in [
        'privacy_level',
        'allow_comment',
        if (post.isVideo) ...['allow_duet', 'allow_stitch'],
        'commercialContentType',
        'video_made_with_ai',
      ]) {
        require(
          post.settings.containsKey(key),
          'TikTok requires an explicit $key setting',
        );
      }
      require(
        {
          'none',
          'brand_organic',
          'brand_content',
        }.contains(post.settings['commercialContentType']),
        'Select none, brand_organic, or brand_content disclosure',
      );
      require(
        post.settings['privacy_level'] is String,
        'Select a TikTok privacy level',
      );
      for (final key in [
        'allow_comment',
        if (post.isVideo) ...['allow_duet', 'allow_stitch'],
        'video_made_with_ai',
      ]) {
        require(post.settings[key] is bool, '$key must be a boolean');
      }
      if (post.settings['commercialContentType'] == 'brand_content')
        require(
          post.settings['privacy_level'] != 'SELF_ONLY',
          'Branded content cannot be private',
        );
      if (post.settings['photo_cover_index'] case final index?)
        require(
          index is int && index >= 0 && index < media.length && !post.isVideo,
          'photo_cover_index must select an image in this carousel',
        );
      if (post.settings['video_cover_timestamp_ms'] case final timestamp?)
        require(
          timestamp is num &&
              timestamp >= 0 &&
              post.isVideo &&
              timestamp < media.first.duration * 1000,
          'Cover timestamp must fall within the video',
        );
      warnings.add(
        'Confirm commercial and AI disclosures accurately describe this post. Lux promotion generally uses brand_organic. TikTok photo images may be downscaled to 1080 x 1920.',
      );
    case .youtube:
      require(
        post.isVideo,
        'YouTube Shorts requires a video. Skip YouTube for image carousels or prepare a separate video post',
      );
      require(
        post.pinnedComment == null || post.pinnedComment!.runes.length <= 10000,
        'YouTube comment exceeds 10,000 characters',
      );
      require(
        post.title.runes.length <= 100 && !RegExp(r'[<>]').hasMatch(post.title),
        'YouTube title must be at most 100 characters without angle brackets',
      );
      require(
        !RegExp(r'[<>]').hasMatch(post.caption),
        'YouTube strips angle brackets; remove them to preserve the caption',
      );
      if (post.isVideo) {
        require(
          media.first.duration >= 1 && media.first.duration <= 180,
          'This command publishes Shorts only: video must be 1 to 180 seconds',
        );
        require(
          (media.first.ratio - 9 / 16).abs() < .01,
          'Zernio documents 9:16 for Shorts; provide a vertical video',
        );
      }
      require(
        {'public', 'private', 'unlisted'}.contains(post.settings['visibility']),
        'Set youtube.settings.visibility',
      );
      require(
        post.settings['madeForKids'] is bool &&
            post.settings['containsSyntheticMedia'] is bool,
        'Set explicit madeForKids and containsSyntheticMedia booleans',
      );
      if (post.cover != null)
        warnings.add(
          'YouTube Shorts custom thumbnails are unsupported through Zernio. Cover will not be uploaded.',
        );
      if (post.pinnedComment != null && post.settings['madeForKids'] == true)
        errors.add(
          'Child-directed YouTube content disables comments; remove pinnedComment',
        );
    case .instagram:
      recommend(
        post.isVideo || media.length <= 10,
        'Instagram API carousel guidance commonly limits posts to 10 images; WoopSocial validation must accept this count',
      );
      for (final item in media) {
        recommend(
          post.isVideo
              ? item.duration >= 3 && item.duration <= 90
              : item.ratio >= .5625 && item.ratio <= 1.91,
          'Source falls outside Zernio’s Instagram reference envelope; WoopSocial may transform or reject it',
        );
        recommend(
          item.bytes <= (post.isVideo ? 300 : 8) * 1024 * 1024,
          'Source exceeds the reference ${post.isVideo ? 300 : 8} MB Instagram limit',
        );
        if (!post.isVideo)
          recommend(
            {'jpg', 'jpeg', 'png'}.contains(item.extension),
            'WebP is not in the Instagram reference formats',
          );
      }
      if (post.cover != null && !post.isVideo)
        warnings.add(
          'Separate cover ignored for Instagram carousel; the first image is the cover.',
        );
    case .facebook:
      for (final item in media) {
        recommend(
          post.isVideo
              ? item.duration >= 3 && item.duration <= 60
              : item.bytes <= 4 * 1024 * 1024,
          'Source falls outside the Facebook Reel/photo reference envelope; WoopSocial validation must accept it',
        );
      }
      if (post.cover != null)
        warnings.add(
          'WoopSocial exposes no Facebook Reel cover field. Cover will not be uploaded.',
        );
      if (!post.isVideo)
        warnings.add(
          'Facebook receives an ordered multi-image Page feed post. Its display is not guaranteed to match an Instagram swipe carousel.',
        );
  }
  if (platform == .instagram ||
      platform == .facebook ||
      platform == .tiktok && post.isVideo)
    warnings.add(
      'This platform has no separate published video/feed title in this request; title is a local label and caption is the published copy.',
    );
  if (platform == .instagram || platform == .facebook) {
    final uploaded = [
      ...media,
      if (platform == .instagram && post.isVideo && post.cover != null)
        info.last,
    ];
    require(
      uploaded.fold(0, (bytes, item) => bytes + item.bytes) <= 1000000000,
      'This destination’s source uploads exceed WoopSocial Free’s advertised 1 GB storage allowance. Reduce media size.',
    );
    warnings.add(
      'WoopSocial resizes and optimizes videos using FFmpeg. Its public API exposes no disable switch or exact output settings. Inspect the transformed delivery in the native app.',
    );
    warnings.add(
      'WoopSocial Free has 1 GB storage. Its media API exposes no byte usage. Check dashboard capacity before uploading; separate destination uploads use separate storage.',
    );
    if (post.pinnedComment != null)
      warnings.add(
        'WoopSocial exposes no comment creation/pinning API. After delivery, the command prints and copies the comment to your clipboard. Post it manually and pin in the native app where available.',
      );
  }
  require(
    info.every((m) => m.bytes <= 5 * 1024 * 1024 * 1024),
    'Provider upload API limit is 5 GB per file',
  );
  return Validation(errors, warnings.toSet().toList());
}

Future<File> getVideoCover(
  File video,
  int timestampMs,
  Directory directory,
) async {
  final cover = File('${directory.path}/cover.jpg');
  final result = await Process.run('ffmpeg', [
    '-hide_banner',
    '-loglevel',
    'error',
    '-nostdin',
    '-ss',
    (timestampMs / 1000).toString(),
    '-i',
    video.path,
    '-frames:v',
    '1',
    '-q:v',
    '2',
    cover.path,
  ]);
  if (result.exitCode != 0 ||
      !await cover.exists() ||
      await cover.length() == 0)
    throw FormatException('Could not extract cover frame: ${result.stderr}');
  return cover;
}
