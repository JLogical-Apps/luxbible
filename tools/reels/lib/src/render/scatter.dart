import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:reels/src/ffmpeg/ffmpeg.dart';
import 'package:reels/src/ffmpeg/transcribe.dart';
import 'package:reels/src/model/clip.dart';
import 'package:reels/src/model/framing.dart';
import 'package:reels/src/model/media.dart';
import 'package:reels/src/model/modifier.dart';
import 'package:reels/src/model/video.dart';
import 'package:reels/src/paths.dart';
import 'package:reels/src/render/ass.dart';
import 'package:reels/src/render/clip_time.dart';

// The same band as media, above a head framed for it. Images may hang this much of their width off either side.
const scatterTop = 0.02;
const scatterBottom = 0.56;
const scatterOverhang = 0.2;
const scatterMaxWidth = 0.65;
const scatterMaxScale = 0.9;
const scatterMaxRotation = 6.0;

// Each image tries this many seeded spots and takes the one covering the most of the band still showing, judged on a
// grid of cells this many canvas pixels wide.
const scatterCandidates = 64;
const scatterCellSize = 20;

// Images start appearing slowly and ease up to speed over this long, then keep that speed until the last one.
const scatterRampSeconds = 1.0;

/// An image over the output timeline, [width] of the frame wide before turning [rotation] degrees clockwise, centered
/// at [x] and [y] as fractions of the frame.
class ScatterImage {
  const ScatterImage({
    required this.file,
    required this.outputStart,
    required this.outputEnd,
    required this.width,
    required this.x,
    required this.y,
    required this.rotation,
    this.sound,
  });

  final File file;
  final int outputStart;
  final int outputEnd;
  final double width;
  final double x;
  final double y;
  final double rotation;
  final Sound? sound;

  @override
  String toString() =>
      '${p.basename(file.path)}:$outputStart-$outputEnd:${width.toStringAsFixed(3)}@'
      '${x.toStringAsFixed(3)},${y.toStringAsFixed(3)}@${rotation.toStringAsFixed(2)}';
}

Future<List<ScatterImage>> getScatterImages(
  Video video,
  List<ResolvedClip> clips,
  List<Transcript> transcripts, {
  required int fps,
}) async {
  final offsets = getClipStarts(clips);
  final scatters = clips
      .expandIndexed(
        (index, clip) => clip.scatters.map((scatter) {
          int getFrame(ClipTime time) => offsets[index] + getClipFrame(time, clip, transcripts[index], fps: fps);
          final files = getScatterFiles(video, scatter.pattern);
          final starts = getScatterStarts(
            files,
            start: getFrame(scatter.start),
            by: getFrame(scatter.by),
            at: scatter.at.map(getFrame).toList(),
            fps: fps,
          );
          return (
            pile: scatter.pile,
            end: getFrame(scatter.end),
            images: files.mapIndexed((i, file) => (file: file, start: starts[i], sound: scatter.sound)).toList(),
          );
        }),
      )
      .toList();
  // A scatter without a pile is a pile of its own.
  final piles = scatters.indexed.groupListsBy<Object>((entry) => entry.$2.pile ?? entry.$1).values;
  final groups = await piles
      .map(
        (pile) => getScatterGroup(
          pile.expand((entry) => entry.$2.images).toList(),
          end: pile.map((entry) => entry.$2.end).max,
        ),
      )
      .wait;
  return groups.flattened.where((image) => image.outputStart < image.outputEnd).toList();
}

// The first image appears at [start] and the last at [by], easing up to speed, unless [at] gives each its own moment.
List<int> getScatterStarts(
  List<File> files, {
  required int start,
  required int by,
  required List<int> at,
  required int fps,
}) {
  if (at.isNotEmpty) {
    if (at.length != files.length) {
      throw ArgumentError(
        'Scatter.at gives ${at.length} moments for ${files.length} images: '
        '${files.map((file) => p.basename(file.path)).join(', ')}',
      );
    }
    return at;
  }
  final spread = by - start;
  final ramp = min(spread, scatterRampSeconds * fps);
  return files.mapIndexed((i, _) {
    final fraction = files.length == 1 ? 0 : i / (files.length - 1);
    return start +
        Iterable<int>.generate(max(0, spread) + 1)
            .firstWhere((frame) => getRampedFraction(frame, total: spread, ramp: ramp) >= fraction - 1e-9);
  }).toList();
}

Future<List<ScatterImage>> getScatterGroup(
  List<({File file, int start, Sound? sound})> pile, {
  required int end,
}) async {
  final sizes = await pile.map((image) => getImageSize(image.file)).wait;

  final images = pile.mapIndexed((i, image) {
    final name = p.basename(image.file.path);
    final (sourceWidth, sourceHeight) = sizes[i];
    final width = min(sourceWidth * scatterMaxScale, scatterMaxWidth * canvasWidth);
    final height = width * sourceHeight / sourceWidth;
    // FNV-1a barely mixes its last character, so salts go first or different salts come out nearly equal.
    final rotation = (getStableFraction('rotation $name') * 2 - 1) * scatterMaxRotation;
    final angle = rotation.abs() * pi / 180;
    return (
      name: name,
      width: width,
      rotation: rotation,
      bounds: (width * cos(angle) + height * sin(angle), width * sin(angle) + height * cos(angle)),
    );
  }).toList();
  final centers = getScatterCenters(images.map((image) => (name: image.name, bounds: image.bounds)).toList());

  return pile
      .mapIndexed(
        (i, image) => ScatterImage(
          file: image.file,
          outputStart: image.start,
          outputEnd: end,
          width: images[i].width / canvasWidth,
          x: centers[i].x / canvasWidth,
          y: centers[i].y / canvasHeight,
          rotation: images[i].rotation,
          sound: image.sound,
        ),
      )
      .toList();
}

// In order, each image takes whichever of its seeded spots covers the most cells of the band still showing, so the pile
// fills its holes instead of clumping. Spots keep the image in the band, hanging at most [scatterOverhang] of its width
// off either side. Centers are in canvas pixels.
List<Point<double>> getScatterCenters(List<({String name, (double, double) bounds})> images) {
  final bandTop = scatterTop * canvasHeight;
  final bandBottom = scatterBottom * canvasHeight;
  final columns = canvasWidth ~/ scatterCellSize;
  final rows = (bandBottom - bandTop) ~/ scatterCellSize;
  final covered = <int>{};

  Iterable<int> getCells(Point<double> center, (double, double) bounds) {
    final (width, height) = bounds;
    Iterable<int> span(double from, double to, int count) =>
        Iterable<int>.generate(count)
            .where((cell) => (cell + 0.5) * scatterCellSize >= from && (cell + 0.5) * scatterCellSize <= to);
    final xs = span(center.x - width / 2, center.x + width / 2, columns);
    return span(
      center.y - height / 2 - bandTop,
      center.y + height / 2 - bandTop,
      rows,
    ).expand((row) => xs.map((column) => row * columns + column));
  }

  return images.map((image) {
    final (width, height) = image.bounds;
    final minX = width * (0.5 - scatterOverhang);
    final spots = Iterable.generate(
      scatterCandidates,
      (j) => Point(
        minX + (canvasWidth - 2 * minX) * getStableFraction('x$j ${image.name}'),
        bandTop + height / 2 + max(0, bandBottom - bandTop - height) * getStableFraction('y$j ${image.name}'),
      ),
    );
    final best = maxBy(spots, (spot) => getCells(spot, image.bounds).where((cell) => !covered.contains(cell)).length)!;
    covered.addAll(getCells(best, image.bounds));
    return best;
  }).toList();
}

Future<(int, int)> getImageSize(File file) async {
  final output = await runFfprobe(['-show_entries', 'stream=width,height', '-of', 'csv=p=0', file.path]);
  final [width, height] = output.trim().split(',').map(int.parse).toList();
  return (width, height);
}

// How far through the images [time] is, under a speed that smoothsteps up over [ramp] and holds to the end. The ramp
// covers half the area a full-speed one would, which the held speed makes up for.
double getRampedFraction(int time, {required num total, required num ramp}) {
  if (total <= 0) return 1;
  final speed = 1 / (total - ramp / 2);
  if (time < ramp) return speed * ramp * (pow(time / ramp, 3) - pow(time / ramp, 4) / 2);
  return min(1, speed * (time - ramp / 2));
}

List<File> getScatterFiles(Video video, String pattern) {
  final folder = video.media;
  if (folder == null) throw UnknownMediaException(pattern, []);

  final images = Directory(expandHome(folder))
      .listSync()
      .whereType<File>()
      .where((file) => isImage(file.path))
      .sortedByCompare((file) => p.basename(file.path), compareNatural);
  final matcher = RegExp('^${pattern.split('*').map(RegExp.escape).join('.*')}\$');
  final matches = images.where((file) => matcher.hasMatch(p.basename(file.path))).toList();
  if (matches.isEmpty) throw UnknownMediaException(pattern, images.map((file) => p.basename(file.path)));
  return matches;
}
