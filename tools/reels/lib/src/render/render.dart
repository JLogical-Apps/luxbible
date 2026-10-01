import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/ffmpeg.dart';
import 'package:reels/src/ffmpeg/ingest.dart';
import 'package:reels/src/ffmpeg/media.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/framing.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/model/video.dart';
import 'package:reels/src/paths.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/audio.dart';
import 'package:reels/src/render/captions.dart';
import 'package:reels/src/render/media.dart';
import 'package:reels/src/render/scatter.dart';
import 'package:reels/src/render/stitch.dart';
import 'package:reels/src/render/zoom.dart';

class StitchPlan {
  const StitchPlan({
    required this.artifacts,
    required this.fps,
    required this.clips,
    required this.zooms,
    required this.subtitles,
    required this.library,
    required this.media,
    required this.scatter,
    required this.music,
    required this.sounds,
  });

  final Ingest artifacts;
  final int fps;
  final List<ResolvedClip> clips;
  final List<List<CropChange>> zooms;
  final File subtitles;
  final MediaLibrary library;
  final List<MediaSegment> media;
  final List<ScatterImage> scatter;
  final AudioCue? music;
  final List<AudioCue> sounds;

  Duration get duration => Duration(microseconds: clips.map((c) => c.take.frameCount).sum * 1000000 ~/ fps);

  List<String> getArgs(File source, {required StitchCodec codec}) => getStitchArgs(
    source: source,
    voice: artifacts.voice,
    clips: clips,
    zooms: zooms,
    fps: fps,
    codec: codec,
    subtitles: subtitles,
    media: media,
    scatter: scatter,
    music: music,
    sounds: sounds,
  );

  Future<File> stitchFrom(
    File source, {
    required File output,
    required StitchCodec codec,
    void Function(double)? onProgress,
  }) async {
    await runFfmpeg(
      [...getArgs(source, codec: codec), output.path],
      total: duration,
      onProgress: onProgress,
    );
    return output;
  }
}

Future<StitchPlan> getStitchPlan(Video video, {IngestProgress? onProgress}) async {
  final artifacts = await ingest(video, onProgress: onProgress);
  final library = await ingestMedia(video, onProgress: onProgress);
  final source = loadClips(video);
  final clips = video.resolve(source);
  final transcripts = await getTranscripts(video, clips, artifacts: artifacts, fps: source.fps, onProgress: onProgress);
  final scatter = await getScatterImages(video, clips, transcripts, fps: source.fps);
  return StitchPlan(
    artifacts: artifacts,
    fps: source.fps,
    clips: clips,
    zooms: clips.mapIndexed((index, clip) => getCropChanges(clip, transcripts[index], fps: source.fps)).toList(),
    subtitles: await writeSubtitles(video, clips, transcripts: transcripts, fps: source.fps),
    library: library,
    media: getMediaSegments(clips, transcripts, library: library, fps: source.fps),
    scatter: scatter,
    music: getMusicCue(video, clips, transcripts, fps: source.fps),
    sounds: getScatterSounds(video, scatter, fps: source.fps),
  );
}

Future<File> render(Video video, {String? output, IngestProgress? onProgress}) async {
  final plan = await getStitchPlan(video, onProgress: onProgress);
  final destination = File(output ?? p.join(projectRoot.path, 'out', '${video.name}.mp4'))
    ..parent.createSync(recursive: true);

  final file = await plan.stitchFrom(
    plan.artifacts.master,
    output: destination,
    codec: StitchCodec.delivery,
    onProgress: (f) => onProgress?.call('Rendering ${plan.clips.length} clips', f),
  );
  await revealInFinder(file);
  return file;
}

// Finder only exists on macOS, and `open` reports failure by exit code, so a failed reveal never fails the render.
Future<void> revealInFinder(File file) async {
  if (!Platform.isMacOS) return;
  await Process.run('open', ['-R', file.path]);
}

Future<File> buildPreview(Video video, {IngestProgress? onProgress}) async {
  final plan = await getStitchPlan(video, onProgress: onProgress);

  // Keyed by the whole ffmpeg command, so any change to what's drawn, or to how, builds a new preview.
  final key = plan.getArgs(plan.artifacts.proxy, codec: .preview).join('\n').hashCode.toUnsigned(32);
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
