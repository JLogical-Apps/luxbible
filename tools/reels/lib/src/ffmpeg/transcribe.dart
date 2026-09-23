import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/ffmpeg.dart';
import 'package:reels/src/ffmpeg/silence.dart';
import 'package:reels/src/model/clips.dart';
import 'package:reels/src/model/word_alignment.dart';
import 'package:reels/src/paths.dart';

const whisperBin = 'whisper-cli';
const whisperModel = '.cache/whisper/ggml-base.en.bin';
const blankMarker = '[BLANK_AUDIO]';
const dtwLagMs = 50;

class MissingWhisperException implements Exception {
  const MissingWhisperException(this.model);

  final String model;

  @override
  String toString() =>
      'whisper-cli or its model is unavailable.\n'
      'Install with: brew install whisper-cpp\n'
      'Expected model at: $model';
}

String get whisperModelPath => p.join(Platform.environment['HOME']!, whisperModel);

String get whisperDtwPreset => RegExp(r'ggml-(.+)\.bin$').firstMatch(whisperModel)![1]!;

/// A word with frame offsets relative to the start of its take.
class Word {
  const Word({required this.text, required this.start, required this.end});

  final String text;
  final int start;
  final int end;
}

class Transcript {
  const Transcript({required this.text, required this.words});

  static const empty = Transcript(text: '', words: []);

  final String text;
  final List<Word> words;

  // DTW places words 50-300 ms late, and unevenly, worst on a take's first word. Where a word follows a pause the
  // waveform shows exactly when it starts, so it takes the nearest unclaimed onset; the rest keep DTW minus its usual lag.
  Transcript snapped(List<int> onsets, {required int fps}) {
    int frames(int ms) => (ms * fps / 1000).round();

    var previous = -1;
    return Transcript(
      text: text,
      words: words.mapIndexed((index, word) {
        final expected = word.start - frames(dtwLagMs);
        final candidates = onsets.where(
          (onset) => onset > previous && onset <= word.start + frames(60) && onset >= word.start - frames(200),
        );
        final onset = index == 0
            ? onsets.firstWhereOrNull((onset) => onset <= word.start + frames(60))
            : candidates.sortedBy<num>((onset) => (onset - expected).abs()).firstOrNull;
        final start = onset ?? max(previous + 1, expected);
        previous = start;
        return Word(text: word.text, start: start, end: max(start, word.end));
      }).toList(),
    );
  }

  // Only whisper knows when each word was spoken, so hand-corrected text borrows its timing rather than replacing it.
  Transcript corrected(String text, {required int frameCount}) {
    final typed = text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (typed.isEmpty) return empty;

    final heard = words.isEmpty ? [Word(text: '', start: 0, end: frameCount)] : words;
    final anchors = anchorWords(heard.map((w) => w.text).toList(), typed);
    final groups = anchors.toSet().toList();

    return Transcript(
      text: typed.join(' '),
      words: typed.mapIndexed((j, word) {
        final anchor = anchors[j];
        // Each group also covers any deleted words up to the next group, so removing words leaves no gap.
        final start = heard[anchor == groups.first ? 0 : anchor].start;
        final end = heard[(groups.firstWhereOrNull((a) => a > anchor) ?? heard.length) - 1].end;
        final sharing = anchors.where((a) => a == anchor).length;
        final position = anchors.take(j).where((a) => a == anchor).length;
        return Word(
          text: word,
          start: start + (end - start) * position ~/ sharing,
          end: start + (end - start) * (position + 1) ~/ sharing,
        );
      }).toList(),
    );
  }
}

Future<Transcript> getCaptions(File audio, {required Take take, required int fps, required Directory cache}) async {
  final heard = await transcribeTake(audio, take: take, fps: fps, cache: cache);
  final onsets = await detectOnsets(audio, start: take.start / fps, duration: take.frameCount / fps);
  return heard
      .snapped(onsets.map((seconds) => (seconds * fps).round()).toList(), fps: fps)
      .corrected(take.text ?? heard.text, frameCount: take.frameCount);
}

/// Transcribes one take. Whisper is run on the take's own audio rather than the
/// whole recording: across long pauses it smears word timings badly, and a take
/// has no long pauses inside it by construction.
Future<Transcript> transcribeTake(File audio, {required Take take, required int fps, required Directory cache}) async {
  final transcripts = Directory(p.join(cache.path, 'transcripts'))..createSync(recursive: true);
  final result = await cached(File(p.join(transcripts.path, '${take.start}-${take.end}.dtw.json')), (partial) async {
    if (!File(whisperModelPath).existsSync()) throw MissingWhisperException(whisperModelPath);

    final slice = File(p.join(transcripts.path, 'slice-$pid.wav'));
    await runFfmpeg(['-ss', '${take.start / fps}', '-t', '${take.frameCount / fps}', '-i', audio.path, slice.path]);

    final process = await Process.run(whisperBin, [
      '-m',
      whisperModelPath,
      '-f',
      slice.path,
      '--dtw',
      whisperDtwPreset,
      '-nfa',
      '-ng',
      '-ojf',
      '-of',
      p.withoutExtension(partial.path),
      '--no-prints',
    ]);
    slice.deleteSync();
    if (process.exitCode != 0) throw MissingWhisperException(whisperModelPath);
  });

  return parseTranscript(result.readAsStringSync(), fps);
}

// Onsets come from DTW, which places words far more consistently than token offsets. A token with a leading space
// opens a word; anything else (punctuation, word pieces) extends the current one.
Transcript parseTranscript(String whisperJson, int fps) {
  int frames(num ms) => (ms * fps / 1000).round();

  final tokens = ((jsonDecode(whisperJson) as Map<String, dynamic>)['transcription'] as List)
      .expand((segment) => (segment as Map<String, dynamic>)['tokens'] as List)
      .cast<Map<String, dynamic>>()
      .where((token) => !(token['text'] as String).startsWith('[_'));

  final words = tokens
      .fold(<Word>[], (words, token) {
        final text = token['text'] as String;
        final end = frames((token['offsets'] as Map<String, dynamic>)['to'] as int);
        if (text.startsWith(' ') || words.isEmpty) {
          final dtw = token['t_dtw'] as num;
          final start = frames(dtw >= 0 ? dtw * 10 : (token['offsets'] as Map<String, dynamic>)['from'] as int);
          return words..add(Word(text: text.trim(), start: start, end: max(start, end)));
        }
        final last = words.removeLast();
        return words..add(Word(text: last.text + text, start: last.start, end: max(last.end, end)));
      })
      .where((w) => w.text != blankMarker && RegExp('[a-zA-Z0-9]').hasMatch(w.text))
      .toList();

  return Transcript(text: words.map((w) => w.text).join(' '), words: words);
}
