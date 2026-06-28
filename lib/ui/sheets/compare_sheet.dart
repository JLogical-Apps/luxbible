import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/paragraphs_builder.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class CompareSheet {
  static List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    BibleTranslation? translation,
    required User user,
  }) {
    if (translation != null) {
      return [
        Consumer(
          builder: (context, ref, child) {
            final paragraphs = ref
                .watch(verseSelectionParagraphsProvider(selection: verseSelection, translation: translation))
                .value;
            return Padding(
              padding: .all(16),
              child: _bibleParagraphs(translation: translation, paragraphs: paragraphs, verseSelection: verseSelection),
            );
          },
        ),
      ];
    }
    final bibles = user.biblesOrDefault;
    return bibles
        .mapIndexed<Widget>(
          (i, translation) => Consumer(
            builder: (context, ref, child) {
              final paragraphs = ref
                  .watch(verseSelectionParagraphsProvider(selection: verseSelection, translation: translation))
                  .value;
              return Stack(
                children: [
                  StyledStickyHeader.child(
                    title: translation.title().toText(),
                    child: _bibleParagraphs(
                      translation: translation,
                      paragraphs: paragraphs,
                      verseSelection: verseSelection,
                    ),
                  ),
                  if (i + 1 < bibles.length) Positioned(bottom: 0, left: 0, right: 0, child: StyledDivider(height: 2)),
                ],
              );
            },
          ),
        )
        .toList();
  }

  static Widget _bibleParagraphs({
    required BibleTranslation translation,
    required VerseSelection verseSelection,
    required List<Paragraph>? paragraphs,
  }) {
    final chapterReference = verseSelection.references.firstOrNull?.toChapterReference();
    return verseSelection.isInTranslation(translation)
        ? StyledLoading(
            child: paragraphs == null || chapterReference == null
                ? null
                : Padding(
                    padding: .only(bottom: 16),
                    child: ParagraphsBuilder(
                      paragraphs: paragraphs,
                      chapterReference: chapterReference,
                      user: ref.read(userProvider),
                      translation: translation,
                    ),
                  ),
          )
        : Padding(
            padding: .only(bottom: 16),
            child: StyledTile.message(
              leading: Symbols.translate.toIcon(),
              title: "${translation.fullName()} doesn't include this selection.".toText(),
            ),
          );
  }
}
