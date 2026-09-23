import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';

/// Horizontal advances read straight from a TrueType file, enough to wrap text the way libass will lay it out.
class FontMetrics {
  const FontMetrics({required this.unitsPerEm, required this.advances, required this.cmap});

  factory FontMetrics.load(File file) {
    final data = ByteData.sublistView(file.readAsBytesSync());
    final tables = {
      for (final i in Iterable<int>.generate(data.getUint16(4)))
        String.fromCharCodes(Uint8List.sublistView(data, 12 + i * 16, 16 + i * 16)): data.getUint32(20 + i * 16),
    };

    final hmtx = tables['hmtx']!;
    final metricCount = data.getUint16(tables['hhea']! + 34);

    return FontMetrics(
      unitsPerEm: data.getUint16(tables['head']! + 18),
      advances: Iterable.generate(metricCount, (i) => data.getUint16(hmtx + i * 4)).toList(),
      cmap: CharacterMap.find(data, tables['cmap']!),
    );
  }

  final int unitsPerEm;

  /// Glyphs past the end share the last advance, as the `hmtx` table specifies.
  final List<int> advances;

  final CharacterMap cmap;

  double measure(String text, {required double emSize}) =>
      text.runes.map((rune) => advances[min(cmap[rune], advances.length - 1)]).sum * emSize / unitsPerEm;
}

/// A format 4 `cmap` subtable, which covers every character a title can hold.
class CharacterMap {
  const CharacterMap(this.data, this.offset);

  factory CharacterMap.find(ByteData data, int cmap) {
    final offset = Iterable.generate(
      data.getUint16(cmap + 2),
      (i) => cmap + 4 + i * 8,
    ).map((record) => cmap + data.getUint32(record + 4)).firstWhereOrNull((subtable) => data.getUint16(subtable) == 4);
    if (offset == null) throw const FormatException('Font has no format 4 cmap');
    return CharacterMap(data, offset);
  }

  final ByteData data;
  final int offset;

  int operator [](int rune) {
    final segments = data.getUint16(offset + 6) ~/ 2;
    final ends = offset + 14;
    final starts = ends + segments * 2 + 2;
    final deltas = starts + segments * 2;
    final rangeOffsets = deltas + segments * 2;

    final segment = Iterable<int>.generate(segments).firstWhereOrNull((i) => data.getUint16(ends + i * 2) >= rune);
    if (segment == null || data.getUint16(starts + segment * 2) > rune) return 0;

    final delta = data.getUint16(deltas + segment * 2);
    final rangeOffsetAt = rangeOffsets + segment * 2;
    final rangeOffset = data.getUint16(rangeOffsetAt);
    if (rangeOffset == 0) return (rune + delta) & 0xffff;

    final glyph = data.getUint16(rangeOffsetAt + rangeOffset + (rune - data.getUint16(starts + segment * 2)) * 2);
    return glyph == 0 ? 0 : (glyph + delta) & 0xffff;
  }
}
