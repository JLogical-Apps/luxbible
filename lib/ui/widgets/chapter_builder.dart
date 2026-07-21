import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/font_size_spacing_zoom_gesture.dart';
import 'package:bible/ui/widgets/paragraphs_builder.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ChapterBuilder extends HookConsumerWidget {
  final ChapterReference chapterReference;
  final User user;

  final List<Reference> underlinedReferences;

  final BibleSelection? selection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final Map<Reference, GlobalKey>? keyByReference;

  final Chapter? chapter;

  const ChapterBuilder({
    super.key,
    required this.chapterReference,
    required this.user,
    this.underlinedReferences = const [],
    this.selection,
    this.onNavigateToVerseSelection,
    this.keyByReference,
    this.chapter,
  });

  BookType get book => chapterReference.book;

  BibleTranslation get translation => user.getTranslationFor(book);
  bool get isFallback => translation != user.translation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapter =
        this.chapter ?? ref.watch(chapterProvider(translation: translation, chapterReference: chapterReference)).value;
    if (chapter == null) {
      return SizedBox.shrink();
    }

    final nextReference = chapterReference.next;
    if (nextReference != null) {
      ref.watch(chapterProvider(translation: translation, chapterReference: nextReference));
    }

    final previousReference = chapterReference.previous;
    if (previousReference != null) {
      ref.watch(chapterProvider(translation: translation, chapterReference: previousReference));
    }

    return FontSizeSpacingZoomGesture(
      language: translation.language,
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 12,
        children: [
          if (isFallback)
            StyledTile.message(
              leading: Symbols.translate.toIcon(),
              title: "${user.translation.fullName()} doesn't include the ${book.testament.title()}.".toText(),
              subtitle: 'Showing your most-recent ${book.testament.title()} Bible, ${translation.fullName()}.'.toText(),
            ),
          ParagraphsBuilder(
            paragraphs: chapter.paragraphs,
            chapterReference: chapterReference,
            user: user,
            translation: translation,
            underlinedReferences: underlinedReferences,
            selection: selection,
            onNavigateToVerseSelection: onNavigateToVerseSelection,
            keyByReference: keyByReference,
          ),
          if (translation.copyright case final copyright?)
            Text(copyright, style: context.textStyle.paragraphXs.subtle(), textAlign: .center),
        ],
      ),
    );
  }
}
