import 'package:bible/models/bible.dart';
import 'package:bible/models/passage.dart';
import 'package:bible/models/reference.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/highlighted_paragraph.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PassageBuilder extends ConsumerWidget {
  final Passage passage;
  final Bible bible;
  final Function(Reference)? onReferencePressed;

  final List<Reference> underlinedReferences;

  const PassageBuilder({
    super.key,
    required this.passage,
    required this.bible,
    this.onReferencePressed,
    this.underlinedReferences = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Column(
      children: passage.references.map((reference) {
        final highlightColor = user.highlightByKey[reference.toKey()];
        final verse = bible.getVerseByReference(reference);
        return GestureDetector(
          onTap: () => onReferencePressed?.call(reference),
          child: Stack(
            children: [
              HighlightedParagraph(
                text: ' ' * reference.verseNum.toString().length + '  ${verse.text}',
                style: context.textStyle.bibleBody.copyWith(
                  decoration: underlinedReferences.contains(reference) ? TextDecoration.underline : null,
                ),
                lineColor: highlightColor?.toHue(context.colors).primary.withValues(alpha: 0.5),
              ),
              Positioned(
                top: 12,
                left: 2,
                child: Text(reference.verseNum.toString(), style: context.textStyle.bibleVerseNumber),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
