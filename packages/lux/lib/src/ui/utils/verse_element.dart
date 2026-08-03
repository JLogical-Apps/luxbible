import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';

class VerseElement {
  final BibleTextSelectionWordAnchor anchor;
  final bool isBoundInSelection;
  final bool isLeading;

  VerseElement({required this.anchor, required this.isBoundInSelection, this.isLeading = false});

  VerseElement copyWith({BibleTextSelectionWordAnchor? anchor, bool? isBoundInSelection, bool? isLeading}) =>
      VerseElement(
        anchor: anchor ?? this.anchor,
        isBoundInSelection: isBoundInSelection ?? this.isBoundInSelection,
        isLeading: isLeading ?? this.isLeading,
      );
}

extension VerseElementSpanExtensions on List<InlineSpan> {
  int? getFirstSpanPositionForReference(Reference reference) {
    var cursor = 0;
    return map((span) {
      final position =
          span is IsAnnotatedSpan<VerseElement> &&
              span.annotation.anchor.toReference() == reference &&
              span.textLength > 0
          ? cursor
          : null;
      cursor += span.textLength;
      return position;
    }).nonNulls.firstOrNull;
  }

  BibleTextSelection getContainedTextSelection({required BibleTranslation translation}) {
    final lastAnchor = whereType<IsAnnotatedSpan<VerseElement>>().last;
    return BibleTextSelection(
      start: whereType<IsAnnotatedSpan<VerseElement>>().first.annotation.anchor,
      end: lastAnchor.annotation.anchor.withCharactersAdded(lastAnchor.textLength),
      translation: translation,
    );
  }

  int get maxTextPosition => map((span) => span.textLength).sum;

  int? getTextPosition({required BibleTextSelectionWordAnchor anchor, bool onlyBound = false}) {
    if (whereType<IsAnnotatedSpan<VerseElement>>().firstOrNull case final startingSpan?) {
      if (startingSpan.annotation.anchor > anchor) {
        return null;
      }
    }

    if (whereType<IsAnnotatedSpan<VerseElement>>().every(
      (span) => span.annotation.anchor.withCharactersAdded(span.textLength) < anchor,
    )) {
      return null;
    }

    var cursor = 0;
    final equalBoundPosition = map((span) {
      final start = cursor;
      cursor += span.textLength;
      return span is IsAnnotatedSpan<VerseElement> &&
              span.annotation.anchor == anchor &&
              (!onlyBound || span.annotation.isBoundInSelection)
          ? start - span.annotation.anchor.characterOffset + anchor.characterOffset
          : null;
    }).toList().nonNulls.firstOrNull;

    if (equalBoundPosition != null) {
      return equalBoundPosition;
    }

    cursor = 0;
    return map((span) {
      final start = cursor;
      cursor += span.textLength;
      return span is IsAnnotatedSpan<VerseElement> && span.annotation.anchor <= anchor
          ? start - span.annotation.anchor.characterOffset + anchor.characterOffset
          : null;
    }).toList().nonNulls.lastOrNull;
  }

  (int, int)? getReferenceCharacterOffsets({
    required Chapter chapter,
    required Reference reference,
    required BibleTranslation translation,
    required bool isParagraphs,
  }) {
    if (!getContainedTextSelection(translation: translation).isInReference(reference)) {
      return null;
    }

    return (
      getTextPosition(anchor: BibleTextSelectionWordAnchor.fromReference(reference: reference, characterOffset: 0)) ??
          (isParagraphs ? 1 : 0),
      getTextPosition(
            anchor: BibleTextSelectionWordAnchor.fromReference(
              reference: reference,
              characterOffset: chapter.getVerseByReference(reference)?.text.length ?? 0,
            ),
          ) ??
          maxTextPosition,
    );
  }

  (int, int)? getTextSelectionCharacterOffsets({
    required BibleTextSelection textSelection,
    required BibleTranslation translation,
    required bool isParagraphs,
  }) {
    if (!getContainedTextSelection(translation: translation).intersects(textSelection)) {
      return null;
    }

    return (
      getTextPosition(anchor: textSelection.start, onlyBound: true) ?? (isParagraphs ? 1 : 0),
      (getTextPosition(anchor: textSelection.end, onlyBound: true) ?? (maxTextPosition - 1)) + 1,
    );
  }
}
