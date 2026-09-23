const maxZoomJitter = 0.10;
const minNeighborZoomGap = 0.04;

/// How the head is framed, given what is shown above it.
enum Framing {
  title,
  media,
  none;

  double get baseZoom => switch (this) {
    .title => 1.10,
    .media => 1.40,
    .none => 1.20,
  };

  /// Where the head should land, as a fraction of the frame's height.
  double get headY => switch (this) {
    .title || .none => 0.5,
    .media => 0.7,
  };
}

/// A window into the source, in fractions of its size, sharing its aspect ratio and always centered horizontally.
class Crop {
  const Crop({required this.zoom, required this.top});

  /// Moves the head from the center of the source to the framing's target height, or as close as the edges allow.
  factory Crop.framing(Framing framing, {required double zoom}) {
    final size = 1 / zoom;
    return Crop(zoom: zoom, top: (0.5 - framing.headY * size).clamp(0, 1 - size));
  }

  final double zoom;
  final double top;

  double get size => 1 / zoom;

  double get left => (1 - size) / 2;

  @override
  String toString() => 'Crop(${zoom.toStringAsFixed(4)}, ${top.toStringAsFixed(4)})';
}

// FNV-1a rather than String.hashCode, which isn't guaranteed stable across SDK versions.
double getZoomJitter(String name) =>
    name.codeUnits.fold(0x811c9dc5, (hash, unit) => ((hash ^ unit) * 0x01000193) & 0xffffffff) /
    0x100000000 *
    maxZoomJitter;

// Near-identical zooms on either side of a cut read as a glitch rather than a deliberate jump, so a clip too close to the
// previous one is pushed just far enough away, on whichever side stays within its framing's range.
double getZoom(Framing framing, String name, {double? previousZoom}) {
  final zoom = framing.baseZoom + getZoomJitter(name);
  if (previousZoom == null || (zoom - previousZoom).abs() >= minNeighborZoomGap) return zoom;

  final isAbove = zoom >= previousZoom
      ? previousZoom + minNeighborZoomGap <= framing.baseZoom + maxZoomJitter
      : previousZoom - minNeighborZoomGap < framing.baseZoom;
  return previousZoom + (isAbove ? minNeighborZoomGap : -minNeighborZoomGap);
}
