import 'dart:math';

const maxZoomJitter = 0.10;
const minNeighborZoomGap = 0.04;

/// Puts the point ([x], [y]) of the source, as fractions of its size, at [frameY] of the frame's height, centered
/// horizontally. [title] and [none] zoom on the source's center, and [media] aims at the head, where `Video.headY` puts
/// it.
class Framing {
  const Framing._({required this.frameY, required this.baseZoom, required this.captionY, this.y = 0.5}) : x = 0.5;

  /// Centers the window on ([x], [y]).
  const Framing.at(this.x, this.y, {this.baseZoom = 1.2}) : frameY = 0.5, captionY = 0.75;

  static const title = Framing._(frameY: 0.5, baseZoom: 1.10, captionY: 0.75);

  // The head at 75% puts captions over the chin, so they drop below it.
  static const media = Framing._(frameY: 0.75, baseZoom: 1.45, captionY: 0.82, y: null);

  static const none = Framing._(frameY: 0.5, baseZoom: 1.20, captionY: 0.75);

  final double x;

  /// Null aims at the head.
  final double? y;

  final double frameY;
  final double baseZoom;
  final double captionY;

  // The crop stops at the source's top edge, so a high head needs more zoom to come down to its height.
  double getBaseZoom(double headY) => y == null ? max(baseZoom, frameY / headY) : baseZoom;

  bool hasSamePlacement(Framing other) => x == other.x && y == other.y && frameY == other.frameY;

  String toDart() => switch (this) {
    Framing.title => '.title',
    Framing.media => '.media',
    Framing.none => '.none',
    _ => '.at($x, $y)',
  };
}

/// A window into the source, in fractions of its size, sharing its aspect ratio.
class Crop {
  const Crop({required this.zoom, required this.top, required this.left});

  /// Places the framing's point where it wants it, or as close as the edges allow.
  factory Crop.framing(Framing framing, {required double zoom, required double headY}) {
    final size = 1 / zoom;
    return Crop(
      zoom: zoom,
      top: ((framing.y ?? headY) - framing.frameY * size).clamp(0, 1 - size),
      left: (framing.x - size / 2).clamp(0, 1 - size),
    );
  }

  final double zoom;
  final double top;
  final double left;

  double get size => 1 / zoom;

  @override
  String toString() => 'Crop(${zoom.toStringAsFixed(4)}, ${top.toStringAsFixed(4)}, ${left.toStringAsFixed(4)})';
}

enum Easing { cubicInOut, quarticInOut }

/// The clip's crop easing into [crop] over [frames] from [at], a frame from the clip's start.
class CropChange {
  const CropChange({
    required this.at,
    required this.frames,
    required this.framing,
    required this.crop,
    required this.easing,
  });

  final int at;
  final int frames;
  final Framing framing;
  final Crop crop;
  final Easing easing;

  @override
  String toString() => '$at+$frames:$crop:${easing.name}';
}

// FNV-1a rather than String.hashCode, which isn't guaranteed stable across SDK versions.
double getStableFraction(String seed) =>
    seed.codeUnits.fold(0x811c9dc5, (hash, unit) => ((hash ^ unit) * 0x01000193) & 0xffffffff) / 0x100000000;

double getZoomJitter(String name) => getStableFraction(name) * maxZoomJitter;

// Near-identical zooms on either side of a cut read as a glitch rather than a deliberate jump, so a clip too close to the
// previous one is pushed just far enough away, on whichever side stays within its framing's range.
double getZoom(Framing framing, String name, {required double headY, double? previousZoom}) {
  final baseZoom = framing.getBaseZoom(headY);
  final zoom = baseZoom + getZoomJitter(name);
  if (previousZoom == null || (zoom - previousZoom).abs() >= minNeighborZoomGap) return zoom;

  final isAbove = zoom >= previousZoom
      ? previousZoom + minNeighborZoomGap <= baseZoom + maxZoomJitter
      : previousZoom - minNeighborZoomGap < baseZoom;
  return previousZoom + (isAbove ? minNeighborZoomGap : -minNeighborZoomGap);
}
