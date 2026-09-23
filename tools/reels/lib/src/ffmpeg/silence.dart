import 'dart:io';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/ffmpeg.dart';
import 'package:reels/src/model/clips.dart';

const noiseFloorDb = -40;
const minSilenceSeconds = 1.0;
const minPauseSeconds = 0.04;
const minSoundSeconds = 0.06;
const minTakeSeconds = 0.4;
const breathingRoomSeconds = 0.1;

final silenceStartPattern = RegExp(r'silence_start:\s*(-?[\d.]+)');
final silenceEndPattern = RegExp(r'silence_end:\s*([\d.]+)');

/// Every detected speech span becomes its own clip with a single take. Grouping
/// repeated attempts into one clip is the transcription step's job.
Future<List<SourceClip>> detectClips(File audio, {required int fps, required Duration duration}) async {
  final output = await runFfmpegCapturingStderr([
    '-i',
    audio.path,
    '-af',
    'silencedetect=noise=${noiseFloorDb}dB:d=$minSilenceSeconds',
    '-f',
    'null',
    '-',
  ]);

  final total = duration.inMicroseconds / 1000000;

  return speechSpans(output, total)
      .where((span) => span.$2 - span.$1 >= minTakeSeconds)
      .mapIndexed(
        (index, span) => SourceClip(
          name: 'clip_${(index + 1).toString().padLeft(2, '0')}',
          takes: [
            Take(
              start: ((span.$1 - breathingRoomSeconds).clamp(0.0, total) * fps).round(),
              end: ((span.$2 + breathingRoomSeconds).clamp(0.0, total) * fps).round(),
            ),
          ],
        ),
      )
      .toList();
}

Future<List<double>> detectOnsets(File audio, {required double start, required double duration}) async {
  final output = await runFfmpegCapturingStderr([
    '-ss',
    '$start',
    '-t',
    '$duration',
    '-i',
    audio.path,
    '-af',
    'silencedetect=noise=${noiseFloorDb}dB:d=$minPauseSeconds',
    '-f',
    'null',
    '-',
  ]);
  // A click or lip smack before a take would otherwise claim its first word.
  final spans = speechSpans(output, duration);
  return spans.where((span) => span.$2 - span.$1 >= minSoundSeconds).map((span) => span.$1).toList();
}

List<(double, double)> speechSpans(String silenceDetectOutput, double total) {
  double seconds(RegExpMatch match) => double.parse(match[1]!).clamp(0.0, total);

  final starts = silenceStartPattern.allMatches(silenceDetectOutput).map(seconds).toList();
  final ends = silenceEndPattern.allMatches(silenceDetectOutput).map(seconds);
  final silences = IterableZip([
    starts,
    [...ends, total],
  ]);

  final spans = <(double, double)>[];
  var cursor = 0.0;
  for (final [silenceStart, silenceEnd] in silences) {
    if (silenceStart > cursor) spans.add((cursor, silenceStart));
    cursor = silenceEnd;
  }
  if (cursor < total) spans.add((cursor, total));

  return spans;
}
