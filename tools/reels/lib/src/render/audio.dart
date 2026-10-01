import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/model/video.dart';
import 'package:reels/src/paths.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/clip_time.dart';
import 'package:reels/src/render/scatter.dart';

const audioExtensions = {'.mp3', '.wav', '.m4a', '.aac'};
const audioSampleRate = 48000;

// The track rarely ends with the video, so it fades out over the last moment instead of cutting off.
const musicFadeSeconds = 1.0;

/// [file] played from [seek] seconds in, starting [start] seconds into the output, with [volume] dB of gain.
class AudioCue {
  const AudioCue({required this.file, required this.start, required this.volume, this.seek = 0});

  final File file;
  final double start;
  final double seek;
  final double volume;

  @override
  String toString() => '${p.basename(file.path)}:${start.toStringAsFixed(3)}+${seek.toStringAsFixed(3)}@${volume}dB';
}

AudioCue? getMusicCue(Video video, List<ResolvedClip> clips, List<Transcript> transcripts, {required int fps}) {
  final starts = getClipStarts(clips);
  final placed = clips
      .expandIndexed(
        (index, clip) => clip.music.map(
          (music) => (music: music, frame: starts[index] + getClipFrame(music.at, clip, transcripts[index], fps: fps)),
        ),
      )
      .toList();
  if (placed.isEmpty) return null;
  if (placed.length > 1) throw StateError('A video has at most one Music, but ${placed.length} were given.');

  final (:music, :frame) = placed.single;
  // Where the track's own start lands, which is before the video's start whenever the cue is further in than its moment.
  final offset = frame / fps - music.cue.inMicroseconds / Duration.microsecondsPerSecond;
  return AudioCue(
    file: getAudioFile(video, music.file),
    start: max(0, offset),
    seek: max(0, -offset),
    volume: music.volume,
  );
}

List<AudioCue> getScatterSounds(Video video, List<ScatterImage> scatter, {required int fps}) => [
  for (final image in scatter)
    if (image.sound case final sound?)
      AudioCue(file: getAudioFile(video, sound.file), start: image.outputStart / fps, volume: sound.volume),
];

File getAudioFile(Video video, String name) {
  final folder = video.media;
  if (folder == null) throw UnknownMediaException(name, []);

  final directory = Directory(expandHome(folder));
  final file = File(p.join(directory.path, name));
  if (file.existsSync()) return file;
  throw UnknownMediaException(
    name,
    directory
        .listSync()
        .whereType<File>()
        .map((file) => p.basename(file.path))
        .where((name) => audioExtensions.contains(p.extension(name).toLowerCase()))
        .sorted(compareNatural),
  );
}
