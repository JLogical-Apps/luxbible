import 'dart:convert';
import 'dart:io';

import 'package:reels/src/ffmpeg/ffmpeg.dart';

const targetLoudness = -16;
const peakLimit = 0.75;

final voiceChain = [
  'aformat=sample_rates=48000:channel_layouts=mono',
  'afftdn=nr=12:nf=-60:tn=1',
  // afftdn delays its output by one 1200-sample window, which would put the voice 25 ms behind the lips.
  'atrim=start_sample=1200,asetpts=N/SR/TB,apad=pad_len=1200',
  'highpass=f=80:p=2',
  'equalizer=f=250:t=q:w=1:g=-2.5',
  'equalizer=f=4500:t=q:w=1.2:g=2.5',
  'acompressor=threshold=0.08:ratio=3:attack=5:release=80:knee=2.82843:makeup=1',
  'deesser=i=0.35',
].join(',');

String get voiceFileName => 'voice_${'$voiceChain|$targetLoudness|$peakLimit'.hashCode.toUnsigned(32)}.wav';

// A fixed gain and a limiter instead of loudnorm's second pass, which switches to riding the level whenever a plosive
// would clip. A fixed gain keeps a clip sounding the same whether it is processed alone or inside the full recording.
Future<void> processVoice(File source, {required File output, void Function(double)? onProgress}) async {
  final meter = await runFfmpegCapturingStderr([
    '-i',
    source.path,
    '-vn',
    '-af',
    '$voiceChain,loudnorm=print_format=json',
    '-f',
    'null',
    '-',
  ]);
  final measured =
      jsonDecode(meter.substring(meter.lastIndexOf('{'), meter.lastIndexOf('}') + 1)) as Map<String, dynamic>;
  final gain = targetLoudness - double.parse(measured['input_i'] as String);

  await runFfmpeg(
    [
      '-i',
      source.path,
      '-vn',
      '-af',
      '$voiceChain,volume=${gain.toStringAsFixed(2)}dB,'
          'alimiter=limit=$peakLimit:attack=5:release=50:level=false:latency=true',
      '-c:a',
      'pcm_s24le',
      output.path,
    ],
    total: await probeDuration(source.path),
    onProgress: onProgress,
  );
}
