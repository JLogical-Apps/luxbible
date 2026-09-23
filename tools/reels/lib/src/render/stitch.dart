import 'dart:io';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/ffmpeg.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/framing.dart';
import 'package:reels/src/render/ass.dart';

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

  final inputs = [...clips.expand((clip) => input(clip, source)), ...clips.expand((clip) => input(clip, voice))];

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
  final graph =
      '$labelled${streams}concat=n=${clips.length}:v=1:a=1[cv][ca];'
      "[cv]scale=-2:${codec.height},ass=filename='${subtitles.path}':fontsdir='${fontsDir.path}'[vout]";

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
