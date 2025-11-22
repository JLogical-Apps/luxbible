import 'dart:math';

import 'package:bible/models/bible.dart';
import 'package:bible/models/passage.dart';
import 'package:bible/models/reference.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/highlighted_paragraph.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:bible/utils/guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PassageBuilder extends HookConsumerWidget {
  final Passage passage;
  final Bible bible;
  final Function(Reference)? onReferencePressed;
  final Function(Reference, (int startOffset, int endOffset)?)? onSelectionUpdated;

  final List<Reference> underlinedReferences;

  const PassageBuilder({
    super.key,
    required this.passage,
    required this.bible,
    this.onReferencePressed,
    this.underlinedReferences = const [],
    this.onSelectionUpdated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Column(
      children: passage.references.map((reference) {
        final highlightColor = user.highlightByKey[reference.toKey()];
        final hasNote = user.passageNotes.any((note) => Passage.fromOsisId(note.passageKey).hasReference(reference));
        final verse = bible.getVerseByReference(reference);
        return GestureDetector(
          onTap: () => onReferencePressed?.call(reference),
          child: Stack(
            children: [
              HookBuilder(
                builder: (context) {
                  final selectionListener = useMemoized(() => SelectionListenerNotifier());

                  useOnListenableChange(selectionListener, () {
                    final range = guard(() => selectionListener.selection.range);
                    onSelectionUpdated?.call(
                      reference,
                      range?.mapIfNonNull(
                        (range) => (min(range.startOffset, range.endOffset), max(range.startOffset, range.endOffset)),
                      ),
                    );
                  });

                  return SelectionListener(
                    selectionNotifier: selectionListener,
                    child: HighlightedParagraph(
                      verseNumberWidth: context.textStyle.bibleVerseNumber.getWidth(reference.verseNum.toString()) + 8,
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: SizedBox(
                              width: context.textStyle.bibleVerseNumber.getWidth(reference.verseNum.toString()) + 8,
                            ),
                          ),
                          TextSpan(text: verse.text),
                        ],
                        style: context.textStyle.bibleBody.copyWith(
                          decoration: underlinedReferences.contains(reference) ? TextDecoration.underline : null,
                        ),
                      ),
                      lineColor:
                          highlightColor?.toHue(context.colors).primary.withValues(alpha: 0.5) ??
                          (hasNote ? context.colors.contentTertiary.withValues(alpha: 0.5) : null),
                    ),
                  );
                },
              ),
              Positioned(
                top: 12,
                left: 2,
                child: SelectionContainer.disabled(
                  child: Text(reference.verseNum.toString(), style: context.textStyle.bibleVerseNumber),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
