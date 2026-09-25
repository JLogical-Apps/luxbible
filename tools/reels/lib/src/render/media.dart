import 'dart:math';

import 'package:collection/collection.dart';
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/model/modifier.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/clip_time.dart';

// Centered, as wide as its aspect ratio allows. Larger than the Remotion facecam overlay's 2% to 50%.
const mediaTop = 0.01;
const mediaBottom = 0.56;

typedef MediaCue = ({int at, int? by, Play play});

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
      return visible.expand((showing) => segments.map((s) => s.clipped(showing.start, showing.end)).nonNulls);
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
      MediaSegment(media: file, outputStart: start, outputEnd: end, from: frame, to: frame);

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
          media: file,
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
