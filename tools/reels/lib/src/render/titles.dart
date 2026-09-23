import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/modifier.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/captions.dart';
import 'package:reels/src/render/font_metrics.dart';

// Matches the Remotion facecam title card: 60px Bitter Black on an off-white card inset 82px from each side. As with
// captions, libass sizes text by ascent + descent (1.631 em), so 98 here is their 60px.
const titleFont = 'Bitter Black';
const titleFontFile = 'Bitter-Black.ttf';
const titleEmSize = 60.0;
const titleFontSize = 98;
const titleLineHeight = 66;
const titleTextColor = '&H00090909';
const titleCardColor = '&H00F5F7F7';
const titleCardInset = 82;
const titleCardRadius = 18;
const titlePaddingX = 26;
const titlePaddingTop = 18;
const titlePaddingBottom = 22;

const titleCardWidth = canvasWidth - 2 * titleCardInset;
const titleTextWidth = titleCardWidth - 2 * titlePaddingX;

List<String> getTitleEvents(List<ResolvedClip> clips, List<Transcript> transcripts, {required int fps}) {
  final metrics = FontMetrics.load(File(p.join(fontsDir.path, titleFontFile)));
  final starts = getClipStarts(clips);
  return clips
      .expandIndexed(
        (index, clip) =>
            getClipTitleEvents(clip, transcripts[index], offset: starts[index], metrics: metrics, fps: fps),
      )
      .toList();
}

// Titles sharing a `y` share one card, one after another. Each keeps its row from the start, and the card covers only
// the rows showing, so it grows as titles appear without any text moving.
Iterable<String> getClipTitleEvents(
  ResolvedClip clip,
  Transcript transcript, {
  required int offset,
  required FontMetrics metrics,
  required int fps,
}) => clip.titles.groupListsBy((title) => title.y).entries.expand((card) {
  final rows = card.value
      .map(
        (title) => (
          title: title,
          lines: getTitleLines(title.text, metrics),
          from: offset + getClipFrame(title.start, clip, transcript, fps: fps),
          to: offset + getClipFrame(title.end, clip, transcript, fps: fps),
        ),
      )
      .toList();
  final firstLines = rows.fold([0], (firsts, row) => firsts..add(firsts.last + row.lines.length));
  final top = card.key * canvasHeight - getCardHeight(firstLines.last) / 2;
  final cuts = rows.expand((row) => [row.from, row.to]).toSet().sorted((a, b) => a - b);

  final cardEvents = IterableZip([cuts, cuts.skip(1)])
      .map((span) => (span: span, showing: rows.indexed.where((row) => row.$2.from <= span[0] && span[0] < row.$2.to)))
      .where((entry) => entry.showing.isNotEmpty)
      .map((entry) {
        final firstLine = firstLines[entry.showing.first.$1];
        final lineCount = firstLines[entry.showing.last.$1 + 1] - firstLine;
        final rect = getRoundedRect(
          width: titleCardWidth,
          height: getCardHeight(lineCount),
          radius: titleCardRadius,
          top: top + firstLine * titleLineHeight,
        );
        return getDialogue(
          1,
          'TitleCard',
          from: entry.span[0],
          to: entry.span[1],
          fps: fps,
          tags: r'\pos(0,0)\p1',
          text: rect,
        );
      });

  // Each line is its own event, since libass spaces lines by ascent + descent, far looser than the card's line height.
  final lineEvents = rows.expandIndexed(
    (index, row) => row.lines.where((_) => row.from < row.to).mapIndexed((lineIndex, line) {
      final y = top + titlePaddingTop + titleLineHeight * (firstLines[index] + lineIndex + 0.5);
      final alpha = ((1 - row.title.opacity) * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
      return getDialogue(
        2,
        'Title',
        from: row.from,
        to: row.to,
        fps: fps,
        tags: '\\pos(${canvasWidth ~/ 2},${y.toStringAsFixed(1)})\\alpha&H$alpha&',
        text: escapeAss(line),
      );
    }),
  );

  return [...cardEvents, ...lineEvents];
});

int getCardHeight(int lineCount) => lineCount * titleLineHeight + titlePaddingTop + titlePaddingBottom;

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

String getDialogue(
  int layer,
  String style, {
  required int from,
  required int to,
  required int fps,
  required String tags,
  required String text,
}) => 'Dialogue: $layer,${getAssTime(from, fps)},${getAssTime(to, fps)},$style,,0,0,0,,{$tags}$text';

// An ASS drawing in canvas coordinates, with each corner a cubic approximation of a quarter circle.
String getRoundedRect({required num width, required num height, required num radius, required double top}) {
  final left = canvasWidth / 2 - width / 2;
  final right = canvasWidth / 2 + width / 2;
  final bottom = top + height;
  final handle = radius * 0.4477;
  String point(double x, double y) => '${x.round()} ${y.round()}';

  return [
    'm ${point(left + radius, top)}',
    'l ${point(right - radius, top)}',
    'b ${point(right - handle, top)} ${point(right, top + handle)} ${point(right, top + radius)}',
    'l ${point(right, bottom - radius)}',
    'b ${point(right, bottom - handle)} ${point(right - handle, bottom)} ${point(right - radius, bottom)}',
    'l ${point(left + radius, bottom)}',
    'b ${point(left + handle, bottom)} ${point(left, bottom - handle)} ${point(left, bottom - radius)}',
    'l ${point(left, top + radius)}',
    'b ${point(left, top + handle)} ${point(left + handle, top)} ${point(left + radius, top)}',
  ].join(' ');
}

// Wraps greedily by the font's own advances, so the card is sized for exactly the lines libass will draw.
List<String> getTitleLines(String text, FontMetrics metrics) => text
    .split('\n')
    .expand(
      (paragraph) => paragraph.split(' ').where((word) => word.isNotEmpty).fold(<String>[], (lines, word) {
        final joined = lines.isEmpty ? word : '${lines.last} $word';
        final fits = lines.isNotEmpty && metrics.measure(joined, emSize: titleEmSize) <= titleTextWidth;
        return fits ? (lines..last = joined) : (lines..add(word));
      }),
    )
    .toList();

class UnknownPhraseException implements Exception {
  const UnknownPhraseException(this.clip, this.phrase, this.captions);

  final String clip;
  final String phrase;
  final String captions;

  @override
  String toString() => 'No "$phrase" in the captions of $clip: $captions';
}
