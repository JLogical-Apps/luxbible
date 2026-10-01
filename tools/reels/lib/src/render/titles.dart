import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/clip_time.dart';
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

// Titles sharing a position share one card, one after another. Each keeps its row from the start, and the card covers
// only the rows showing, so it grows as titles appear without any text moving. A label is as wide as its widest row
// from the start, for the same reason.
Iterable<String> getClipTitleEvents(
  ResolvedClip clip,
  Transcript transcript, {
  required int offset,
  required FontMetrics metrics,
  required int fps,
}) => clip.titles.groupListsBy((title) => (x: title.x, y: title.y)).entries.expand((card) {
  final centerX = (card.key.x ?? 0.5) * canvasWidth;
  final maxWidth = 2 * min(centerX, canvasWidth - centerX) - 2 * titleCardInset;
  final rows = card.value
      .map(
        (title) => (
          title: title,
          lines: getTitleLines(title.text, metrics, width: maxWidth - 2 * titlePaddingX),
          from: offset + getClipFrame(title.start, clip, transcript, fps: fps),
          to: offset + getClipFrame(title.end, clip, transcript, fps: fps),
        ),
      )
      .toList();
  final width = card.key.x == null
      ? maxWidth
      : (rows.expand((row) => row.lines).map((line) => metrics.measure(line, emSize: titleEmSize)).maxOrNull ?? 0) +
            2 * titlePaddingX;
  final firstLines = rows.fold([0], (firsts, row) => firsts..add(firsts.last + row.lines.length));
  final top = card.key.y * canvasHeight - getCardHeight(firstLines.last) / 2;
  final cuts = rows.expand((row) => [row.from, row.to]).toSet().sorted((a, b) => a - b);

  final cardEvents = IterableZip([cuts, cuts.skip(1)])
      .map((span) => (span: span, showing: rows.indexed.where((row) => row.$2.from <= span[0] && span[0] < row.$2.to)))
      .where((entry) => entry.showing.isNotEmpty)
      .map((entry) {
        final firstLine = firstLines[entry.showing.first.$1];
        final lineCount = firstLines[entry.showing.last.$1 + 1] - firstLine;
        final rect = getRoundedRect(
          centerX: centerX,
          width: width,
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
        tags: '\\pos(${centerX.toStringAsFixed(1)},${y.toStringAsFixed(1)})\\alpha&H$alpha&',
        text: escapeAss(line),
      );
    }),
  );

  return [...cardEvents, ...lineEvents];
});

int getCardHeight(int lineCount) => lineCount * titleLineHeight + titlePaddingTop + titlePaddingBottom;

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
String getRoundedRect({
  required double centerX,
  required num width,
  required num height,
  required num radius,
  required double top,
}) {
  final left = centerX - width / 2;
  final right = centerX + width / 2;
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
List<String> getTitleLines(String text, FontMetrics metrics, {required num width}) => text
    .split('\n')
    .expand(
      (paragraph) => paragraph.split(' ').where((word) => word.isNotEmpty).fold(<String>[], (lines, word) {
        final joined = lines.isEmpty ? word : '${lines.last} $word';
        final fits = lines.isNotEmpty && metrics.measure(joined, emSize: titleEmSize) <= width;
        return fits ? (lines..last = joined) : (lines..add(word));
      }),
    )
    .toList();
