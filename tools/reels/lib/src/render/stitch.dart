import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/framing.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/ffmpeg/voice.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/audio.dart';
import 'package:reels/src/render/media.dart';
import 'package:reels/src/render/scatter.dart';
import 'package:reels/src/render/zoom.dart';

class StitchCodec {
  const StitchCodec({required this.args, required this.height});

  static const preview = StitchCodec(args: ['-c:v', 'h264_videotoolbox', '-b:v', '4M'], height: 960);
  static const delivery = StitchCodec(
    args: ['-c:v', 'libx264', '-crf', '18', '-preset', 'medium', '-pix_fmt', 'yuv420p'],
    height: 1920,
  );

  final List<String> args;
  final int height;

  int get width => height * 9 ~/ 16;
}

/// Every ffmpeg argument for the stitched video except the output path, so it also identifies what would be drawn.
List<String> getStitchArgs({
  required File source,
  required File voice,
  required List<ResolvedClip> clips,
  required int fps,
  required StitchCodec codec,
  required File subtitles,
  required List<List<CropChange>> zooms,
  List<MediaSegment> media = const [],
  List<ScatterImage> scatter = const [],
  AudioCue? music,
  List<AudioCue> sounds = const [],
}) {
  if (clips.isEmpty) throw StateError('Nothing to stitch: the video has no clips.');

  // Seeking to a frame's exact timestamp drops that frame whenever float error lands the seek just past it, so seek
  // half a frame early and cut by frame count, with the audio trimmed to match.
  double lead(ResolvedClip clip) => clip.take.start == 0 ? 0 : 0.5 / fps;

  List<String> input(ResolvedClip clip, File file) => [
    '-ss',
    '${clip.take.start / fps - lead(clip)}',
    '-t',
    '${(clip.take.frameCount + 1) / fps}',
    '-i',
    file.path,
  ];

  List<String> mediaInput(MediaSegment segment) => [
    '-ss',
    '${max(0, (segment.from - 0.5) / fps)}',
    '-t',
    '${(segment.to - segment.from + 1) / fps}',
    '-i',
    segment.file.path,
  ];

  final inputs = [
    ...clips.expand((clip) => input(clip, source)),
    ...clips.expand((clip) => input(clip, voice)),
    ...media.expand(mediaInput),
    ...scatter.expand((image) => ['-i', image.file.path]),
    if (music case final music?) ...['-ss', '${music.seek}', '-i', music.file.path],
    ...sounds.expand((sound) => ['-i', sound.file.path]),
  ];

  // Each clip is cropped differently, so each is scaled to the output size before concat, which needs them to match.
  String getFraming(Crop crop, List<CropChange> changes) {
    final window = changes.isEmpty
        ? 'crop=w=iw*${crop.size}:h=ih*${crop.size}:x=iw*${crop.left}:y=ih*${crop.top}'
        : getZoomFilter(crop, changes);
    return '$window,scale=${codec.width}:${codec.height},setsar=1';
  }

  final labelled = clips
      .mapIndexed(
        (i, clip) =>
            '[$i:v]trim=end_frame=${clip.take.frameCount},setpts=PTS-STARTPTS,${getFraming(clip.startCrop, zooms[i])}[v$i];'
            '[${clips.length + i}:a]atrim=start=${lead(clip)}:duration=${clip.take.frameCount / fps},asetpts=PTS-STARTPTS[a$i];',
      )
      .join();
  final streams = clips.mapIndexed((i, _) => '[v$i][a$i]').join();

  // Each segment plays at its speed, then holds its last frame for the rest of its stretch, placed at its output time.
  // overlay drops a stream's final frame at its EOF, so each segment runs a frame long and `enable` cuts it off.
  final mediaHeight = ((mediaBottom - mediaTop) * codec.height).round();
  final overlays = media.mapIndexed(
    (i, segment) =>
        '[${2 * clips.length + i}:v]trim=end_frame=${segment.to - segment.from + 1},'
        '${getMediaFitFilter(segment.mask, width: codec.width, height: mediaHeight)},'
        'setpts=(PTS-STARTPTS)/${segment.speed},fps=$fps,tpad=stop_mode=clone:stop=-1,'
        'trim=end_frame=${segment.frameCount + 1},setpts=PTS-STARTPTS+${segment.outputStart / fps}/TB[m$i];'
        '[b$i][m$i]overlay=x=(W-w)/2:y=${(mediaTop * codec.height).round()}:eof_action=pass:'
        "enable='between(n,${segment.outputStart},${segment.outputEnd - 1})'[b${i + 1}];",
  );
  // Each image is a single frame, which overlay repeats once it runs out. Rotating grows it to fit, with clear corners,
  // and the overlay centers whatever size that came to.
  final images = scatter.mapIndexed((i, image) {
    final base = media.length + i;
    final angle = image.rotation * pi / 180;
    return "[${2 * clips.length + base}:v]scale=${(image.width * codec.width / 2).round() * 2}:-2,setsar=1,"
        'format=rgba,rotate=a=$angle:ow=rotw($angle):oh=roth($angle):c=none[s$i];'
        "[b$base][s$i]overlay=x='${image.x * codec.width}-w/2':y='${image.y * codec.height}-h/2':"
        "enable='between(n,${image.outputStart},${image.outputEnd - 1})'[b${base + 1}];";
  });
  final audio = getAudioMix(
    music: music,
    sounds: sounds,
    firstInput: 2 * clips.length + media.length + scatter.length,
    duration: clips.map((clip) => clip.take.frameCount).sum / fps,
  );
  final graph =
      '$labelled${streams}concat=n=${clips.length}:v=1:a=1[cv][ca];'
      // concat's microsecond timestamps can land a hair before a segment's first frame, which overlay then skips.
      '[cv]settb=1/$fps,setpts=N,scale=-2:${codec.height}[b0];'
      '${overlays.join()}'
      '${images.join()}'
      "[b${media.length + scatter.length}]ass=filename='${subtitles.path}':fontsdir='${fontsDir.path}'[vout]"
      '$audio';

  return [
    ...inputs,
    '-filter_complex',
    graph,
    '-map',
    '[vout]',
    '-map',
    music == null && sounds.isEmpty ? '[ca]' : '[aout]',
    ...codec.args,
    '-r',
    '$fps',
    '-c:a',
    'aac',
    '-b:a',
    '192k',
    '-movflags',
    '+faststart',
  ];
}

// Mixed in stereo at 48 kHz, with the mono voice copied to both sides at full level, where an automatic upmix would
// lower it 3 dB. The limiter only catches where the extra audio pushes the voice's peaks past its own limit.
String getAudioMix({
  required AudioCue? music,
  required List<AudioCue> sounds,
  required int firstInput,
  required double duration,
}) {
  if (music == null && sounds.isEmpty) return '';

  String place(AudioCue cue) =>
      'aformat=sample_rates=$audioSampleRate:channel_layouts=stereo,volume=${cue.volume}dB,'
      'adelay=delays=${(cue.start * audioSampleRate).round()}S:all=1';

  final musicFilter = switch (music) {
    final music? =>
      '[$firstInput:a]${place(music)},'
          'afade=t=out:st=${max(0, duration - musicFadeSeconds)}:d=$musicFadeSeconds[music];',
    null => '',
  };
  final soundInput = firstInput + (music == null ? 0 : 1);
  // Sound effects tend to open on a little silence, which would land them late.
  final soundFilters = sounds.mapIndexed(
    (i, sound) => '[${soundInput + i}:a]silenceremove=start_periods=1:start_threshold=-50dB,${place(sound)}[x$i];',
  );
  final mixed = ['[voice]', if (music != null) '[music]', ...sounds.mapIndexed((i, _) => '[x$i]')];

  return ';[ca]pan=stereo|c0=c0|c1=c0[voice];'
      '$musicFilter'
      '${soundFilters.join()}'
      '${mixed.join()}amix=inputs=${mixed.length}:duration=first:normalize=0,'
      'alimiter=limit=$peakLimit:attack=5:release=50:level=false:latency=true[aout]';
}
