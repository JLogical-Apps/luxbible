import 'package:bible/models/annotation.dart';
import 'package:bible/models/highlight_style.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/bible_reader_configuration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';

class AnnotationPreview extends ConsumerWidget {
  final BibleTextSelection selection;
  final HighlightStyle style;
  final EdgeInsets padding;

  const AnnotationPreview({super.key, required this.selection, this.style = .fallback, this.padding = const .all(16)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    // The mock annotation's sheet could edit or delete the user's real annotations.
    return IgnorePointer(
      child: PassageBuilder(
        verseSelection: selection.toVerseSelection(),
        translation: selection.translation,
        padding: padding,
        shrinkWrap: true,
        configuration: BibleReaderConfiguration.build(
          user.copyWith(
            annotations: [
              Annotation(
                selection: .text(textSelection: selection),
                style: style,
                note: t.themeSettings.previewAnnotationNote,
                createdAt: DateTime.now(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
