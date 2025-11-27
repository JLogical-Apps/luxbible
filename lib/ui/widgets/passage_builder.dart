import 'dart:math';

import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:bible/utils/extensions/color_extensions.dart';
import 'package:bible/utils/extensions/span_extensions.dart';
import 'package:bible/utils/guard.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PassageBuilder extends HookConsumerWidget {
  final Passage passage;
  final Bible? bible;
  final Function(Reference)? onReferencePressed;
  final Function(Selection?)? onSelectionUpdated;

  final List<Reference> underlinedReferences;

  const PassageBuilder({
    super.key,
    required this.passage,
    this.bible,
    this.onReferencePressed,
    this.onSelectionUpdated,
    this.underlinedReferences = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibles = ref.watch(biblesProvider);
    final user = ref.watch(userProvider);
    final bible = this.bible ?? user.getBible(bibles);

    final spans = passage.references.expandIndexed((referenceIndex, reference) {
      final verse = bible.getVerseByReference(reference);
      final passageAnnotations = user.getPassageAnnotations(Passage.reference(reference));
      final verseSelectionAnchors = user.getSelectionAnchors(reference);
      return [
        SizedWidgetSpan(
          size: Size(
            context.textStyle.bibleVerseNumber.getWidth(reference.verseNum.toString()) + 6,
            context.textStyle.bibleBody.height! * context.textStyle.bibleBody.fontSize!,
          ),
          alignment: PlaceholderAlignment.middle,
          child: SelectionContainer.disabled(
            child: Container(
              color: passageAnnotations
                  .map((annotation) => annotation.color.toHue(context.colors).primary.withValues(alpha: 0.5))
                  .mixOrNull,
              child: Padding(
                padding: EdgeInsets.only(right: 6, top: 12),
                child: Text(
                  reference.verseNum.toString(),
                  style: context.textStyle.bibleVerseNumber.copyWith(
                    decoration: underlinedReferences.contains(reference) ? TextDecoration.underline : null,
                  ),
                ),
              ),
            ),
          ),
        ),
        ...verseSelectionAnchors.mapIndexed((verseIndex, offset) {
          final selectionAnnotations = user.getSelectionAnnotations(
            Selection.character(
              anchor: SelectionWordAnchor.fromReference(reference: reference, characterOffset: offset),
              translation: bible.translation,
            ),
          );
          final annotations = passageAnnotations + selectionAnnotations;
          return TextSpan(
            text: verse.text.substring(offset, verseSelectionAnchors.elementAtOrNull(verseIndex + 1)),
            style: context.textStyle.bibleBody.copyWith(
              decoration: underlinedReferences.contains(reference) ? TextDecoration.underline : null,
              backgroundColor: annotations
                  .map((annotation) => annotation.color.toHue(context.colors).primary.withValues(alpha: 0.5))
                  .mixOrNull,
            ),
          );
        }),
        TextSpan(text: '\n'),
      ];
    }).toList();

    final textKey = useMemoized(() => GlobalKey());

    final selectionListener = useMemoized(() => SelectionListenerNotifier());
    useOnListenableChange(selectionListener, () {
      final range = guard(() => selectionListener.selection.range);
      if (range == null) {
        onSelectionUpdated?.call(null);
        return;
      }

      final minOffset = min(range.startOffset, range.endOffset) - 1;
      final maxOffset = max(range.startOffset, range.endOffset) - 2;

      final startAnchor = getOffsetAnchor(characterOffset: minOffset, bible: bible);
      final endAnchor = getOffsetAnchor(characterOffset: maxOffset, bible: bible);

      if (startAnchor != null && endAnchor != null) {
        onSelectionUpdated?.call(Selection(start: startAnchor, end: endAnchor, translation: bible.translation));
      }
    });

    return SelectionListener(
      selectionNotifier: selectionListener,
      child: GestureDetector(
        onTapUp: (details) {
          final renderBox = textKey.currentContext!.findRenderObject() as RenderBox;
          final offset = spans.getCharacterOffsetFromPosition(
            width: renderBox.size.width,
            localPosition: renderBox.globalToLocal(details.globalPosition),
          );

          final anchor = getOffsetAnchor(characterOffset: offset, bible: bible);
          if (anchor != null) {
            onReferencePressed?.call(anchor.toReference());
          }
        },
        child: Text.rich(
          key: textKey,
          TextSpan(children: spans),
          style: context.textStyle.bibleBody,
        ),
      ),
    );
  }

  SelectionWordAnchor? getOffsetAnchor({required int characterOffset, required Bible bible}) {
    var offsetCount = 0;
    for (final reference in passage.references) {
      final referenceLength = bible.getVerseByReference(reference).text.length;
      if (characterOffset < offsetCount + referenceLength) {
        return SelectionWordAnchor.fromReference(reference: reference, characterOffset: characterOffset - offsetCount);
      }
      offsetCount += referenceLength;
    }
    return null;
  }
}
