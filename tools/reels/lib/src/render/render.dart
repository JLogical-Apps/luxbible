import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/ingest.dart';
import 'package:reels/src/ffmpeg/media.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/model/video.dart';
import 'package:reels/src/paths.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/captions.dart';
import 'package:reels/src/render/media.dart';
import 'package:reels/src/render/stitch.dart';

class StitchPlan {
  const StitchPlan({
    required this.artifacts,
    required this.fps,
    required this.clips,
    required this.subtitles,
    required this.library,
    required this.media,
  });

  final Ingest artifacts;
  final int fps;
  final List<ResolvedClip> clips;
  final File subtitles;
  final MediaLibrary library;
  final List<MediaSegment> media;

  Future<File> stitchFrom(
    File source, {
    required File output,
    required StitchCodec codec,
    void Function(double)? onProgress,
  }) => stitch(
    source: source,
    voice: artifacts.voice,
    clips: clips,
    fps: fps,
    output: output,
    codec: codec,
    subtitles: subtitles,
    media: media,
    onProgress: onProgress,
  );
}

Future<StitchPlan> getStitchPlan(Video video, {IngestProgress? onProgress}) async {
  final artifacts = await ingest(video, onProgress: onProgress);
  final library = await ingestMedia(video, onProgress: onProgress);
  final source = loadClips(video);
  final clips = video.resolve(source);
  final transcripts = await getTranscripts(video, clips, artifacts: artifacts, fps: source.fps, onProgress: onProgress);
  return StitchPlan(
    artifacts: artifacts,
    fps: source.fps,
    clips: clips,
    subtitles: await writeSubtitles(video, clips, transcripts: transcripts, fps: source.fps),
    library: library,
    media: getMediaSegments(clips, transcripts, library: library, fps: source.fps),
  );
}

Future<File> render(Video video, {String? output, IngestProgress? onProgress}) async {
  final plan = await getStitchPlan(video, onProgress: onProgress);
  final destination = File(output ?? p.join(projectRoot.path, 'out', '${video.name}.mp4'))
    ..parent.createSync(recursive: true);

  return plan.stitchFrom(
    plan.artifacts.master,
    output: destination,
    codec: StitchCodec.delivery,
    onProgress: (f) => onProgress?.call('Rendering ${plan.clips.length} clips', f),
  );
}

Future<File> buildPreview(Video video, {IngestProgress? onProgress}) async {
  final plan = await getStitchPlan(video, onProgress: onProgress);

  final ranges = plan.clips.map((c) => '${c.name}:${c.take.start}-${c.take.end}:${c.crop}').join('|');
  final key = [
    ranges,
    plan.media.join('|'),
    p.basename(plan.subtitles.path),
    p.basename(plan.artifacts.voice.path),
  ].join('|').hashCode.toUnsigned(32);
  return cached(
    File(p.join(cacheDirFor(video).path, 'preview_$key.mp4')),
    (partial) => plan.stitchFrom(
      plan.artifacts.proxy,
      output: partial,
      codec: StitchCodec.preview,
      onProgress: (f) => onProgress?.call('Building preview', f),
    ),
  );
}
