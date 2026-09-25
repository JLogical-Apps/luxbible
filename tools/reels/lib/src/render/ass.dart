import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/video.dart';
import 'package:reels/src/paths.dart';
import 'package:reels/src/render/captions.dart';
import 'package:reels/src/render/titles.dart';

const canvasWidth = 1080;
const canvasHeight = 1920;

const assHeader =
    '''
[Script Info]
ScriptType: v4.00+
PlayResX: $canvasWidth
PlayResY: $canvasHeight
ScaledBorderAndShadow: yes
WrapStyle: 2

[V4+ Styles]
Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding
Style: Caption,$captionFont,$captionFontSize,&H00FFFFFF,&H00FFFFFF,&H00101010,&H00000000,0,0,0,0,100,100,0,0,1,$captionOutline,0,5,0,0,0,1
Style: TitleCard,$titleFont,$titleFontSize,$titleCardColor,$titleCardColor,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,0,0,7,0,0,0,1
Style: Title,$titleFont,$titleFontSize,$titleTextColor,$titleTextColor,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,0,0,5,0,0,0,1

[Events]
Format: Layer, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text
''';

Directory get fontsDir => Directory(p.join(projectRoot.path, 'fonts'));

/// Everything libass draws over the video: captions and titles, on the output timeline.
Future<File> writeSubtitles(
  Video video,
  List<ResolvedClip> clips, {
  required List<Transcript> transcripts,
  required int fps,
}) async {
  final events = [...getCaptionEvents(clips, transcripts, fps: fps), ...getTitleEvents(clips, transcripts, fps: fps)];
  final ass = '$assHeader${events.join('\n')}\n';

  return cached(
    File(p.join(cacheDirFor(video).path, 'subtitles_${ass.hashCode.toUnsigned(32)}.ass')),
    (partial) async => partial.writeAsStringSync(ass),
  );
}

/// The output frame each clip starts on, followed by the total frame count.
List<int> getClipStarts(List<ResolvedClip> clips) =>
    clips.fold([0], (starts, clip) => starts..add(starts.last + clip.take.frameCount));

int msToFrames(int ms, int fps) => (ms * fps / 1000).round();

String escapeAss(String text) => text.replaceAll(RegExp(r'[{}\\]'), '');

// Aims half a frame early so an event starts exactly on its frame. At the frame's own timestamp, rounding to
// centiseconds could land just after it and show the event a frame late.
String getAssTime(int frame, int fps) {
  final centiseconds = frame == 0 ? 0 : ((frame - 0.5) * 100 / fps).round();
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return '${centiseconds ~/ 360000}:${twoDigits(centiseconds ~/ 6000 % 60)}:'
      '${twoDigits(centiseconds ~/ 100 % 60)}.${twoDigits(centiseconds % 100)}';
}
