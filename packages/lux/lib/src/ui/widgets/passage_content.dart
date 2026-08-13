import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:url_launcher/url_launcher.dart';

class PassageContent extends StatelessWidget {
  final LuxReaderConfiguration configuration;

  final List<Paragraph> paragraphs;
  final ChapterReference chapterReference;
  final BibleTranslation translation;

  final PassageSelectionController? selection;
  final List<Reference> underlinedReferences;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final PassageController? controller;

  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final bool removeScrollbarPadding;

  final bool showChapterAccessories;
  final bool animate;

  final Widget Function(BuildContext, Widget)? contentBuilder;
  final Widget? footer;

  const PassageContent({
    super.key,
    required this.configuration,
    required this.paragraphs,
    required this.chapterReference,
    required this.translation,
    this.selection,
    this.underlinedReferences = const [],
    this.onNavigateToVerseSelection,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.removeScrollbarPadding = false,
    this.showChapterAccessories = false,
    this.animate = false,
    this.contentBuilder,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final selection = this.selection;
    final onNavigateToVerseSelection = this.onNavigateToVerseSelection;

    final footerChildren = [
      if (showChapterAccessories &&
          (translation.copyright != null || translation.source is ApiBibleTranslationSource)) ...[
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
      ?footer,
    ];

    final passage = ParagraphsBuilder(
      paragraphs: paragraphs,
      chapterReference: chapterReference,
      translation: translation,
      configuration: configuration.paragraphsConfiguration(context, translation),
      underlinedReferences: selection?.references ?? underlinedReferences,
      textSelection: selection?.textSelection,
      decorations: configuration.decorationsBuilder(context, chapterReference, translation),
      markersBuilder: configuration.markersBuilder == null
          ? null
          : (reference, verse, verseParagraphOffset) => configuration.markersBuilder!(
              context,
              translation,
              reference,
              verse,
              verseParagraphOffset,
              onNavigateToVerseSelection,
            ),
      onReferencePressed: selection?.onReferencePressed,
      onTextSelectionLongPressed: selection == null || onNavigateToVerseSelection == null
          ? null
          : (textSelection) => selection.onTextSelectionLongPressed(context, textSelection, onNavigateToVerseSelection),
      onTextSelectionUpdated: selection?.onTextSelectionUpdated,
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      removeScrollbarPadding: removeScrollbarPadding,
      header: showChapterAccessories && translation != configuration.selectedTranslation
          ? StyledTile.message(
              leading: Symbols.translate.toIcon(),
              title: t.chapterUnavailable
                  .title(
                    selectedTranslation: configuration.selectedTranslation.fullName(),
                    testament: chapterReference.book.testament.title(),
                  )
                  .toText(),
              subtitle: t.chapterUnavailable
                  .subtitle(
                    testament: chapterReference.book.testament.title(),
                    fallbackTranslation: translation.fullName(),
                  )
                  .toText(),
            )
          : null,
      footer: footerChildren.isEmpty ? null : Column(spacing: 12, children: footerChildren),
    );

    final content = contentBuilder?.call(context, passage) ?? passage;
    return configuration.chapterWrapper(
      context,
      translation,
      animate
          ? TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: paragraphs.isEmpty ? 0.0 : 1.0),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              child: content,
              builder: (context, opacity, child) => Opacity(opacity: opacity, child: child),
            )
          : content,
    );
  }
}
