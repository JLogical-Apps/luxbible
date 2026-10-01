import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/ffmpeg.dart';
import 'package:reels/src/ffmpeg/silence.dart';
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/ffmpeg/voice.dart';
import 'package:reels/src/model/clips.dart';
import 'package:reels/src/model/video.dart';
import 'package:reels/src/paths.dart';

const outputFps = 30;
const proxyHeight = 960;

const toneMap =
    'zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,'
    'tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p';

class Ingest {
  const Ingest({required this.master, required this.proxy, required this.audio, required this.voice});

  final File master;
  final File proxy;
  final File audio;
  final File voice;
}

typedef IngestProgress = void Function(String step, double fraction);

class MissingSourceException implements Exception {
  const MissingSourceException(this.path);

  final String path;

  @override
  String toString() => 'Source video not found: $path';
}

class SourceChangedException implements Exception {
  const SourceChangedException(this.paths, this.cache);

  final List<String> paths;
  final Directory cache;

  @override
  String toString() =>
      'Source videos changed since they were ingested: ${paths.join(', ')}\n'
      'Its clips.json frame numbers point into the old recordings. Give the video a new name, '
      'or delete ${cache.path} and its clips.json to start over.';
}

Future<Ingest> ingest(Video video, {IngestProgress? onProgress}) async {
  final sources = video.sources.map((src) => File(expandHome(src))).toList();
  final cache = cacheDirFor(video)..createSync(recursive: true);

  final audio = File(p.join(cache.path, 'audio.wav'));
  final master = File(p.join(cache.path, 'master.mp4'));
  final proxy = File(p.join(cache.path, 'proxy.mp4'));

  verifySources(sources, cache: cache, derived: [audio, master]);

  await cached(
    master,
    (partial) async => runFfmpeg(
      [
        for (final src in sources) ...['-i', src.path],
        '-filter_complex',
        getConcatGraph(sources.length),
        '-map',
        '[v]',
        '-map',
        '[a]',
        '-r',
        '$outputFps',
        '-c:v',
        'hevc_videotoolbox',
        '-b:v',
        '30M',
        '-tag:v',
        'hvc1',
        '-c:a',
        'aac',
        '-b:a',
        '256k',
        partial.path,
      ],
      total: (await Future.wait(sources.map((src) => probeDuration(src.path)))).reduce((a, b) => a + b),
      onProgress: (f) => onProgress?.call('Normalizing master (tone-mapping HDR)', f),
    ),
  );

  // Taken from the master rather than the sources, so its timeline matches the master's across every join.
  await cached(audio, (partial) async {
    onProgress?.call('Extracting audio', 0);
    await runFfmpeg(['-i', master.path, '-vn', '-ac', '1', '-ar', '16000', '-c:a', 'pcm_s16le', partial.path]);
  });

  await cached(
    proxy,
    (partial) async => runFfmpeg(
      [
        '-i',
        master.path,
        '-vf',
        'scale=-2:$proxyHeight',
        '-c:v',
        'h264_videotoolbox',
        '-b:v',
        '3M',
        '-c:a',
        'aac',
        '-b:a',
        '128k',
        partial.path,
      ],
      total: await probeDuration(master.path),
      onProgress: (f) => onProgress?.call('Building preview proxy', f),
    ),
  );

  final voice = await cached(
    File(p.join(cache.path, voiceFileName)),
    (partial) => processVoice(master, output: partial, onProgress: (f) => onProgress?.call('Processing voice', f)),
  );

  final isDetecting = !clipsFileFor(video).existsSync();
  if (isDetecting) onProgress?.call('Detecting clips', 0);
  final clips = isDetecting
      ? Clips(
          fps: outputFps,
          clips: await detectClips(audio, fps: outputFps, duration: await probeDuration(audio.path)),
        )
      : loadClips(video);

  if (isDetecting || clips.takes.any((t) => t.text == null)) {
    final transcribed = await transcribeClips(clips, audio: audio, cache: cache, onProgress: onProgress);
    // Saved only after transcription, so a failed first run re-detects instead of keeping silent spans under
    // auto-generated names that can no longer be safely renumbered.
    saveClips(video, isDetecting ? transcribed.withoutSilence() : transcribed);
  }

  return Ingest(master: master, proxy: proxy, audio: audio, voice: voice);
}

// concat pads a source's audio with silence when it ends before its video, so the voice stays on the lips after a join.
String getConcatGraph(int count) => [
  ...Iterable.generate(count, (i) => '[$i:v]$toneMap[v$i]'),
  '${Iterable.generate(count, (i) => '[v$i][$i:a]').join()}concat=n=$count:v=1:a=1[v][a]',
].join(';');

// The recorded sizes let render run after the sources are deleted, while still catching a swapped or added recording
// that would make every frame number in clips.json point at the wrong footage.
void verifySources(List<File> sources, {required Directory cache, required List<File> derived}) {
  final record = File(p.join(cache.path, 'source.json'));

  if (sources.firstWhereOrNull((src) => !src.existsSync()) case final missing?) {
    if (derived.every((f) => f.existsSync())) return;
    throw MissingSourceException(missing.path);
  }

  final sizes = sources.map((src) => src.lengthSync()).toList();
  if (!record.existsSync()) {
    record.writeAsStringSync(jsonEncode({'paths': sources.map((src) => src.path).toList(), 'sizes': sizes}));
  } else if (!ListEquality().equals((jsonDecode(record.readAsStringSync()) as Map<String, dynamic>)['sizes'], sizes)) {
    throw SourceChangedException(sources.map((src) => src.path).toList(), cache);
  }
}

Future<Clips> transcribeClips(
  Clips clips, {
  required File audio,
  required Directory cache,
  IngestProgress? onProgress,
}) async {
  final pending = clips.takes.where((t) => t.text == null).length;
  var done = 0;

  Future<Take> transcribed(Take take) async {
    if (take.text != null) return take;
    final transcript = await transcribeTake(audio, take: take, fps: clips.fps, cache: cache);
    onProgress?.call('Transcribing takes', ++done / pending);
    return take.transcribed(transcript.text);
  }

  return Clips(
    fps: clips.fps,
    clips: [
      for (final clip in clips.clips)
        SourceClip(name: clip.name, takes: [for (final take in clip.takes) await transcribed(take)]),
    ],
  );
}

Clips loadClips(Video video) =>
    Clips.fromJson(jsonDecode(clipsFileFor(video).readAsStringSync()) as Map<String, dynamic>);

void saveClips(Video video, Clips clips) => clipsFileFor(video)
  ..createSync(recursive: true)
  ..writeAsStringSync('${const JsonEncoder.withIndent('  ').convert(clips.toJson())}\n');
