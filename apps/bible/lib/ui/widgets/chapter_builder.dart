import 'package:bible/models/user/user.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/font_size_spacing_zoom_gesture.dart';
import 'package:bible/ui/widgets/paragraphs_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:url_launcher/url_launcher.dart';

class ChapterBuilder extends HookConsumerWidget {
  final ChapterReference chapterReference;
  final User user;

  final List<Reference> underlinedReferences;

  final BibleSelection? selection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final Chapter? chapter;

  final PassageController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;

  const ChapterBuilder({
    super.key,
    required this.chapterReference,
    required this.user,
    this.underlinedReferences = const [],
    this.selection,
    this.onNavigateToVerseSelection,
    this.chapter,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
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
      language: translation.bibleLanguage,
      child: ParagraphsBuilder(
        paragraphs: chapter.paragraphs,
        chapterReference: chapterReference,
        user: user,
        translation: translation,
        underlinedReferences: underlinedReferences,
        selection: selection,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
        controller: controller,
        padding: padding,
        shrinkWrap: shrinkWrap,
        header: isFallback
            ? StyledTile.message(
                leading: Symbols.translate.toIcon(),
                title: t.chapterUnavailable
                    .title(selectedTranslation: user.translation.fullName(), testament: book.testament.title())
                    .toText(),
                subtitle: t.chapterUnavailable
                    .subtitle(testament: book.testament.title(), fallbackTranslation: translation.fullName())
                    .toText(),
              )
            : null,
        footer: translation.copyright == null && translation.source is! ApiBibleTranslationSource
            ? null
            : Column(
                spacing: 12,
                children: [
                  if (translation.copyright case final copyright?)
                    Text(copyright, style: context.textStyle.paragraphXs.subtle(), textAlign: .center),
                  if (translation.source is ApiBibleTranslationSource)
                    MarkdownBuilder(
                      Markdown(t.selectionUi.sourceApiBible),
                      style: context.textStyle.paragraphXs.subtle(),
                      onLinkPressed: (_, _) => launchUrl(Uri.https('api.bible')),
                      textAlign: .center,
                    ),
                ],
              ),
      ),
    );
  }
}
