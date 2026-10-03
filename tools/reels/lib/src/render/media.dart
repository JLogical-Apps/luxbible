import 'dart:math';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/model/modifier.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/clip_time.dart';

// Centered and fit inside this band and the frame's width. Larger than the Remotion facecam overlay's 2% to 50%.
const mediaTop = 0.01;
const mediaBottom = 0.56;

typedef MediaCue = ({int at, int? by, Play play});

/// Filters that fit a media frame, with its [mask], inside [width] by [height].
String getMediaFitFilter(Mask? mask, {required int width, required int height}) => switch (mask) {
  null => 'scale=$width:$height:force_original_aspect_ratio=decrease',
  final Bevel bevel => getBevelFilter(bevel, width: width, height: height),
};

// The bezel is padded on before anything is known of the frame's size, so the scale leaves room for it, and the corners
// are drawn from the padded width. The screen's corners and the bezel's share their centers, one distance apart.
String getBevelFilter(Bevel bevel, {required int width, required int height}) {
  final Bevel(:radius, :border) = bevel;
  final framed = 1 + 2 * border;
  final center = 'W*${(border + radius) / framed}';
  final distance = 'hypot(max(max($center-X-0.5,X+0.5-W+$center),0),max(max($center-Y-0.5,Y+0.5-H+$center),0))';
  final screen = 'clip(W*${radius / framed}-$distance+0.5,0,1)';
  final outline = 'clip($center-$distance+0.5,0,1)';
  return "format=rgba,scale=w='min($width/$framed,$height/(ih/iw+${2 * border}))':h=-1,"
      "pad=w='iw*$framed':h='ih+iw*${2 * border}':x='iw*$border':y='iw*$border':color=black,"
      "geq=r='r(X,Y)*$screen':g='g(X,Y)*$screen':b='b(X,Y)*$screen':a='alpha(X,Y)*$outline'";
}

/// Every stretch of the output timeline showing media, and which of its frames it shows.
List<MediaSegment> getMediaSegments(
  List<ResolvedClip> clips,
  List<Transcript> transcripts, {
  required MediaLibrary library,
  required int fps,
}) {
  final offsets = getClipStarts(clips);
  int getFrame(int clip, ClipTime time) => offsets[clip] + getClipFrame(time, clips[clip], transcripts[clip], fps: fps);

  final showings = clips.expandIndexed(
    (index, clip) => clip.media.map(
      (media) => (clip: index, start: getFrame(index, media.start), end: getFrame(index, media.end), media: media),
    ),
  );

  return showings.groupListsBy((showing) => showing.media.file).entries.expand((entry) {
    if (isImage(entry.key)) {
      final image = library.getImage(entry.key);
      if (entry.value.any((showing) => showing.media.play.isNotEmpty)) throw ImagePlayException(entry.key);
      return entry.value
          .where((showing) => showing.start < showing.end)
          .map(
            (showing) => MediaSegment(
              name: entry.key,
              file: image,
              outputStart: showing.start,
              outputEnd: showing.end,
              from: 0,
              to: 0,
              mask: showing.media.mask,
            ),
          );
    }

    final file = library[entry.key];
    // The playhead carries across runs, even with the file hidden between them.
    var position = library.getFrame(file.name, 'start');

    return entry.value.splitBetween((a, b) => b.clip - a.clip > 1).expand((run) {
      final visible = run.where((showing) => showing.start < showing.end).toList();
      if (visible.isEmpty) return <MediaSegment>[];

      final runStart = visible.map((showing) => showing.start).min;
      final runEnd = visible.map((showing) => showing.end).max;
      final cues = run
          .expand(
            (showing) => showing.media.play.map(
              (play) => (
                at: play.at == null ? showing.start : getFrame(showing.clip, play.at!),
                by: play.by == null ? null : getFrame(showing.clip, play.by!),
                play: play,
              ),
            ),
          )
          .sortedBy<num>((cue) => cue.at);

      final (segments, reached) = getRunSegments(
        cues.isEmpty ? [(at: runStart, by: null, play: const Play('end'))] : cues,
        file: file,
        library: library,
        runStart: runStart,
        runEnd: runEnd,
        start: position,
      );
      position = reached;
      return visible.expand(
        (showing) => segments.map((s) => s.clipped(showing.start, showing.end, mask: showing.media.mask)).nonNulls,
      );
    });
  }).toList();
}

/// The run's segments, and where its playhead ends up.
(List<MediaSegment>, int) getRunSegments(
  List<MediaCue> cues, {
  required MediaFile file,
  required MediaLibrary library,
  required int runStart,
  required int runEnd,
  required int start,
}) {
  MediaSegment hold(int start, int end, int frame) =>
      MediaSegment(name: file.name, file: file.normalized, outputStart: start, outputEnd: end, from: frame, to: frame);

  var cursor = runStart;
  var position = start;
  final segments = cues.foldIndexed(<MediaSegment>[], (index, built, cue) {
    final play = cue.play;
    if (play.speed case final speed? when speed < 1) {
      throw ArgumentError.value(speed, 'speed', 'Play("${play.to}") in ${file.name} must not play slower than 1x');
    }

    final from = play.from == null ? position : library.getFrame(file.name, play.from!);
    final to = library.getFrame(file.name, play.to);
    if (to < from) throw BackwardsPlayException(file.name, from: from, to: to, tag: play.to);

    final nextAt = cues.elementAtOrNull(index + 1)?.at ?? runEnd;
    final end = max(cue.at, min(cue.by ?? runEnd, min(nextAt, runEnd)));
    final window = end - cue.at;
    final speed = play.speed ?? (window == 0 ? 1.0 : max(1.0, (to - from) / window));
    // Float error must not leave a fitted play a frame short of its tag.
    final playFrames = min(window, ((to - from) / speed - 1e-6).ceil());
    final reached = window == 0 || playFrames * speed + 1e-6 >= to - from ? to : from + (playFrames * speed).floor();

    final added = [
      if (cue.at > cursor) hold(cursor, cue.at, index == 0 ? from : position),
      if (playFrames > 0)
        MediaSegment(
          name: file.name,
          file: file.normalized,
          outputStart: cue.at,
          outputEnd: cue.at + playFrames,
          from: from,
          to: reached,
          speed: speed,
        ),
      if (end > cue.at + playFrames) hold(cue.at + playFrames, end, reached),
    ];
    cursor = max(cursor, end);
    position = reached;
    return built..addAll(added);
  });

  return ([...segments, if (runEnd > cursor) hold(cursor, runEnd, position)], position);
}
