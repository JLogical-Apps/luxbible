import 'dart:math';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/ingest.dart';
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/video.dart';
import 'package:reels/src/paths.dart';
import 'package:reels/src/render/ass.dart';

// Matches the Remotion facecam captions. libass sizes text by the font's Windows ascent + descent (1.631 em for
// Bitter) where CSS sizes by the em, so 117 here is their 72px.
const captionFont = 'Bitter Black';
const captionFontSize = 117;
const captionOutline = 3.5;
const captionCenterY = 0.75;
const captionMaxWords = 4;
const captionMaxCharacters = 22;
const captionLeadMs = 60;

Future<List<Transcript>> getTranscripts(
  Video video,
  List<ResolvedClip> clips, {
  required Ingest artifacts,
  required int fps,
  IngestProgress? onProgress,
}) async {
  Future<Transcript> getClipCaptions(int index, ResolvedClip clip) async {
    onProgress?.call('Preparing captions', index / clips.length);
    return getCaptions(artifacts.audio, take: clip.take, fps: fps, cache: cacheDirFor(video));
  }

  return [for (final (index, clip) in clips.indexed) await getClipCaptions(index, clip)];
}

List<String> getCaptionEvents(List<ResolvedClip> clips, List<Transcript> transcripts, {required int fps}) {
  final words = getTimelineWords(clips.mapIndexed((index, clip) => (clip, transcripts[index])).toList(), fps: fps);
  return buildCaptionEvents(
    getCaptionPages(words, fps: fps),
    fps: fps,
    totalFrames: clips.map((c) => c.take.frameCount).sum,
  ).toList();
}

/// When a word lights up, in frames from the start of its clip.
int getWordOnset(Word word, {required int frameCount, required int fps}) =>
    min(word.start, frameCount - 1) - msToFrames(captionLeadMs, fps);

// Words light up slightly before they're spoken. Only onsets are trusted: whisper's word end times drift late, so each
// word runs until the next one starts, held to between 0.1 and 1 s.
List<Word> getTimelineWords(List<(ResolvedClip, Transcript)> pairs, {required int fps}) {
  final offsets = getClipStarts(pairs.map((pair) => pair.$1).toList());

  final onsets = pairs
      .expandIndexed(
        (index, pair) => pair.$2.words.map(
          (word) => (
            text: word.text.toUpperCase(),
            start: max(0, offsets[index] + getWordOnset(word, frameCount: pair.$1.take.frameCount, fps: fps)),
          ),
        ),
      )
      .toList();

  return onsets.mapIndexed((index, word) {
    final next = onsets.elementAtOrNull(index + 1)?.start ?? word.start + msToFrames(600, fps);
    return Word(
      text: word.text,
      start: word.start,
      end: max(word.start + msToFrames(100, fps), min(next, word.start + msToFrames(1000, fps))),
    );
  }).toList();
}

List<List<Word>> getCaptionPages(List<Word> words, {required int fps}) => words.fold([], (pages, word) {
  final page = pages.lastOrNull;
  final fits =
      page != null &&
      page.length < captionMaxWords &&
      !RegExp(r'[.!?]$').hasMatch(page.last.text) &&
      word.start - page.last.end < msToFrames(600, fps) &&
      [...page, word].map((w) => w.text).join(' ').length <= captionMaxCharacters;
  return fits ? (pages..last.add(word)) : (pages..add([word]));
});

// A page is one line of words; it is split into an event per stretch of time with a different spoken word, so the
// highlight moves while the line stays put.
Iterable<String> buildCaptionEvents(List<List<Word>> pages, {required int fps, required int totalFrames}) =>
    pages.expandIndexed((index, page) {
      final pageEnd = [
        pages.elementAtOrNull(index + 1)?.first.start ?? totalFrames,
        page.last.end + msToFrames(400, fps),
        totalFrames,
      ].min;
      int getActiveEnd(int j) => j + 1 < page.length ? page[j + 1].start : page[j].end;

      final cuts = {
        page.first.start,
        pageEnd,
        ...page.map((w) => w.start),
        ...page.indexed.map((entry) => getActiveEnd(entry.$1)),
      }.where((frame) => frame >= page.first.start && frame <= pageEnd).sorted((a, b) => a - b);

      return IterableZip([cuts, cuts.skip(1)]).map((span) {
        final active = page.indexed
            .firstWhereOrNull((entry) => entry.$2.start <= span[0] && span[0] < getActiveEnd(entry.$1))
            ?.$1;
        return 'Dialogue: 0,${getAssTime(span[0], fps)},${getAssTime(span[1], fps)},Caption,,0,0,0,,'
            '{\\pos(${canvasWidth ~/ 2},${(canvasHeight * captionCenterY).round()})}${getPageText(page, active)}';
      });
    });

String getPageText(List<Word> page, int? active) => page
    .mapIndexed((j, word) {
      final text = escapeAss(word.text);
      return j == active ? '{\\1c&H101010&\\3c&HFFFFFF&}$text{\\r}' : text;
    })
    .join(' ');
