import 'dart:math';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/modifier.dart';
import 'package:reels/src/render/captions.dart';

int getClipFrame(ClipTime time, ResolvedClip clip, Transcript transcript, {required int fps}) => switch (time) {
  ClipFrames(:final frames) => frames,
  ClipEnd() => clip.take.frameCount,
  ClipWord(:final phrase) => getWordOnset(
    findPhrase(phrase, clip, transcript),
    frameCount: clip.take.frameCount,
    fps: fps,
  ),
}.clamp(0, clip.take.frameCount);

// Matches on letters and digits alone, so punctuation and case in the captions don't matter.
Word findPhrase(String phrase, ResolvedClip clip, Transcript transcript) {
  String normalize(String word) => word.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');
  final words = transcript.words.map((word) => normalize(word.text)).toList();
  final target = phrase.split(RegExp(r'\s+')).map(normalize).where((word) => word.isNotEmpty).toList();

  final index = Iterable<int>.generate(max(0, words.length - target.length + 1))
      .firstWhereOrNull((start) => const ListEquality().equals(words.sublist(start, start + target.length), target));
  if (index == null) throw UnknownPhraseException(clip.name, phrase, transcript.text);
  return transcript.words[index];
}

class UnknownPhraseException implements Exception {
  const UnknownPhraseException(this.clip, this.phrase, this.captions);

  final String clip;
  final String phrase;
  final String captions;

  @override
  String toString() => 'No "$phrase" in the captions of $clip: $captions';
}
