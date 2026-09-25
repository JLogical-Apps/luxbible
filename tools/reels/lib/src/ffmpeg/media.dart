import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/ffmpeg.dart';
import 'package:reels/src/ffmpeg/ingest.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/model/video.dart';
import 'package:reels/src/paths.dart';

const mediaExtensions = {'.mp4', '.mov', '.m4v'};

// Comfortably above the 1056 px the overlay is drawn at in the render.
const normalizedMediaHeight = 1280;
const previewMediaHeight = 960;

class MissingMediaFolderException implements Exception {
  const MissingMediaFolderException(this.path);

  final String path;

  @override
  String toString() => 'Media folder not found: $path';
}

/// Normalizes every video in the media folder, once per version of each file.
Future<MediaLibrary> ingestMedia(Video video, {IngestProgress? onProgress}) async {
  final folderPath = video.media;
  if (folderPath == null) return MediaLibrary.empty;

  final folder = Directory(expandHome(folderPath));
  if (!folder.existsSync()) throw MissingMediaFolderException(folder.path);

  final sources = folder
      .listSync()
      .whereType<File>()
      .where((f) => mediaExtensions.contains(p.extension(f.path).toLowerCase()))
      .sortedBy((f) => p.basename(f.path));
  final cache = Directory(p.join(cacheDirFor(video).path, 'media'))..createSync(recursive: true);

  Future<MediaFile> normalize(int index, File source) async {
    onProgress?.call('Preparing media', index / sources.length);
    // Keyed by the file's size and modification time, so re-recording it rebuilds only that file.
    final stat = source.statSync();
    final key = '${stat.size}-${stat.modified.millisecondsSinceEpoch}'.hashCode.toUnsigned(32);
    final base = p.join(cache.path, '${p.basenameWithoutExtension(source.path)}_$key');
    final normalized = await cached(File('$base.mov'), (partial) => normalizeMedia(source, output: partial));
    final preview = await cached(
      File('$base.mp4'),
      (partial) => runFfmpeg([
        '-i',
        normalized.path,
        '-vf',
        'scale=-2:$previewMediaHeight,format=yuv420p',
        '-an',
        '-c:v',
        'h264_videotoolbox',
        '-b:v',
        '4M',
        partial.path,
      ]),
    );
    final frames = await cached(
      File('$base.frames'),
      (partial) async => partial.writeAsStringSync(
        await runFfprobe([
          '-select_streams',
          'v:0',
          '-show_entries',
          'stream=nb_frames',
          '-of',
          'csv=p=0',
          normalized.path,
        ]),
      ),
    );
    return MediaFile(
      name: p.basename(source.path),
      normalized: normalized,
      preview: preview,
      frameCount: int.parse(frames.readAsStringSync().trim()),
    );
  }

  final files = [for (final (index, source) in sources.indexed) await normalize(index, source)];
  return MediaLibrary(files: files, tags: loadMediaTags(video));
}

// RocketSim records HEVC with alpha, whose alpha layer ffmpeg can't decode, so AVFoundation first converts it to ProRes
// 4444, keeping the transparency around the device. ffmpeg then fixes the frame rate, since simulator recordings are
// variable, and shrinks it.
Future<void> normalizeMedia(File source, {required File output}) async {
  final decoded = File(p.join(output.parent.path, '${p.basenameWithoutExtension(output.path)}.decoded.mov'));
  try {
    final args = ['-s', source.path, '-p', 'PresetAppleProRes4444LPCM', '-o', decoded.path, '--replace'];
    final result = await Process.run('avconvert', args);
    if (result.exitCode != 0) throw FfmpegException('avconvert', args, '${result.stdout}${result.stderr}');

    await runFfmpeg([
      '-i',
      decoded.path,
      '-vf',
      'fps=$outputFps,scale=-2:$normalizedMediaHeight',
      '-an',
      '-c:v',
      'prores_ks',
      '-profile:v',
      '4444',
      '-pix_fmt',
      'yuva444p10le',
      output.path,
    ]);
  } finally {
    if (decoded.existsSync()) decoded.deleteSync();
  }
}

Map<String, Map<String, int>> loadMediaTags(Video video) {
  final file = mediaTagsFileFor(video);
  if (!file.existsSync()) return {};
  return (jsonDecode(file.readAsStringSync()) as Map<String, dynamic>).map(
    (name, tags) => MapEntry(name, (tags as Map<String, dynamic>).map((tag, frame) => MapEntry(tag, frame as int))),
  );
}

void saveMediaTags(Video video, MediaLibrary library) => mediaTagsFileFor(video)
  ..createSync(recursive: true)
  ..writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(library.tags.map((name, tags) => MapEntry(name, Map.fromEntries(tags.entries.sortedBy<num>((t) => t.value)))))}\n',
  );
