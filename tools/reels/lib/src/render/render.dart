import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/ingest.dart';
import 'package:reels/src/model/video.dart';
import 'package:reels/src/paths.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/stitch.dart';

Future<File> render(Video video, {String? output, IngestProgress? onProgress}) async {
  final artifacts = await ingest(video, onProgress: onProgress);
  final source = loadClips(video);
  final clips = video.resolve(source);
  final subtitles = await writeSubtitles(video, clips, artifacts: artifacts, fps: source.fps, onProgress: onProgress);

  final destination = File(output ?? p.join(projectRoot.path, 'out', '${video.name}.mp4'))
    ..parent.createSync(recursive: true);

  return stitch(
    source: artifacts.master,
    voice: artifacts.voice,
    clips: clips,
    fps: source.fps,
    output: destination,
    codec: StitchCodec.delivery,
    subtitles: subtitles,
    onProgress: (f) => onProgress?.call('Rendering ${clips.length} clips', f),
  );
}

Future<File> buildPreview(Video video, {IngestProgress? onProgress}) async {
  final artifacts = await ingest(video, onProgress: onProgress);
  final source = loadClips(video);
  final clips = video.resolve(source);
  final subtitles = await writeSubtitles(video, clips, artifacts: artifacts, fps: source.fps, onProgress: onProgress);

  final ranges = clips.map((c) => '${c.name}:${c.take.start}-${c.take.end}:${c.crop}').join('|');
  final key = '$ranges|${p.basename(subtitles.path)}|${p.basename(artifacts.voice.path)}'.hashCode.toUnsigned(32);
  return cached(
    File(p.join(cacheDirFor(video).path, 'preview_$key.mp4')),
    (partial) => stitch(
      source: artifacts.proxy,
      voice: artifacts.voice,
      clips: clips,
      fps: source.fps,
      output: partial,
      codec: StitchCodec.preview,
      subtitles: subtitles,
      onProgress: (f) => onProgress?.call('Building preview', f),
    ),
  );
}
