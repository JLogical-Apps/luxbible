import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/ffmpeg.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/framing.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/media.dart';

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

Future<File> stitch({
  required File source,
  required File voice,
  required List<ResolvedClip> clips,
  required int fps,
  required File output,
  required StitchCodec codec,
  required File subtitles,
  List<MediaSegment> media = const [],
  void Function(double)? onProgress,
}) async {
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
    segment.media.normalized.path,
  ];

  final inputs = [
    ...clips.expand((clip) => input(clip, source)),
    ...clips.expand((clip) => input(clip, voice)),
    ...media.expand(mediaInput),
  ];

  // Each clip is cropped differently, so each is scaled to the output size before concat, which needs them to match.
  String getFraming(Crop crop) =>
      'crop=w=iw*${crop.size}:h=ih*${crop.size}:x=iw*${crop.left}:y=ih*${crop.top},'
      'scale=${codec.width}:${codec.height},setsar=1';

  final labelled = clips
      .mapIndexed(
        (i, clip) =>
            '[$i:v]trim=end_frame=${clip.take.frameCount},setpts=PTS-STARTPTS,${getFraming(clip.crop)}[v$i];'
            '[${clips.length + i}:a]atrim=start=${lead(clip)}:duration=${clip.take.frameCount / fps},asetpts=PTS-STARTPTS[a$i];',
      )
      .join();
  final streams = clips.mapIndexed((i, _) => '[v$i][a$i]').join();

  // Each segment plays at its speed, then holds its last frame for the rest of its stretch, placed at its output time.
  // overlay drops a stream's final frame at its EOF, so each segment runs a frame long and `enable` cuts it off.
  final mediaHeight = ((mediaBottom - mediaTop) * codec.height).round();
  final overlays = media.mapIndexed(
    (i, segment) =>
        '[${2 * clips.length + i}:v]trim=end_frame=${segment.to - segment.from + 1},scale=-2:$mediaHeight,'
        'setpts=(PTS-STARTPTS)/${segment.speed},fps=$fps,tpad=stop_mode=clone:stop=-1,'
        'trim=end_frame=${segment.frameCount + 1},setpts=PTS-STARTPTS+${segment.outputStart / fps}/TB[m$i];'
        '[b$i][m$i]overlay=x=(W-w)/2:y=${(mediaTop * codec.height).round()}:eof_action=pass:'
        "enable='between(n,${segment.outputStart},${segment.outputEnd - 1})'[b${i + 1}];",
  );
  final graph =
      '$labelled${streams}concat=n=${clips.length}:v=1:a=1[cv][ca];'
      // concat's microsecond timestamps can land a hair before a segment's first frame, which overlay then skips.
      '[cv]settb=1/$fps,setpts=N,scale=-2:${codec.height}[b0];'
      '${overlays.join()}'
      "[b${media.length}]ass=filename='${subtitles.path}':fontsdir='${fontsDir.path}'[vout]";

  final total = Duration(microseconds: clips.map((c) => c.take.frameCount).sum * 1000000 ~/ fps);

  await runFfmpeg(
    [
      ...inputs,
      '-filter_complex',
      graph,
      '-map',
      '[vout]',
      '-map',
      '[ca]',
      ...codec.args,
      '-r',
      '$fps',
      '-c:a',
      'aac',
      '-b:a',
      '192k',
      '-movflags',
      '+faststart',
      output.path,
    ],
    total: total,
    onProgress: onProgress,
  );

  return output;
}
