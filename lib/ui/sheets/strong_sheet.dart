import 'package:bible/models/bible/word.dart';
import 'package:bible/models/morphology.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/strong.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/chapter_preview_page.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/widgets/markdown_builder.dart';
import 'package:bible/ui/widgets/verse_text.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/markdown.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class StrongSheet {
  static Future<void> showWithBreadcrumbs(
    BuildContext context, {
    String? strongId,
    Word? word,
    Function(VerseSelection)? onNavigateToVerseSelection,
  }) async {
    final strongs = ref.read(strongsProvider);
    final strong = strongs[strongId];

    final seeMoreStrongs = strong?.relatedStrongIds.map((strongId) => strongs[strongId]).nonNulls.toList();

    final morphologyCode = word?.data?.morphology;
    final morphologyCodes = morphologyCode == null ? null : Morphology.splitCode(morphologyCode);

    final user = ref.read(userProvider);

    void openStrong(BuildContext context, String strongId) {
      context.pop();
      StrongSheet.showWithBreadcrumbs(
        context,
        strongId: strongId,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      );
    }

    await context.showStyledSheetWithBreadcrumbs(breadcrumbText: word?.data?.inflection ?? strong?.id ?? '', (context) {
      final selectedMorphologyCodeState = useState(morphologyCodes?.firstOrNull);
      final selectedMorphologyCode = selectedMorphologyCodeState.value;

      return StyledSheet.builder(
        title: (word != null ? 'Interlinear Word' : 'Lexicon').toText(),
        subtitle: SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 8,
            children: [
              ?word?.data?.inflection?.toText() ?? strongId?.toText(),
              if (user.translation != user.studyTranslation)
                StyledTag.sm(child: user.studyTranslation.title().toText()),
            ],
          ),
        ),
        childrenBuilder: (context, ref) {
          return [
            if (word != null)
              StyledSection(
                title: 'Usage'.toText(),
                padding: .only(top: 24),
                children: [
                  if (word.text case final text?) StyledListItem(title: 'English'.toText(), subtitle: text.toText()),
                  if (word.data case final data?) ...[
                    StyledListItem(title: 'Inflected'.toText(), subtitle: data.inflection?.toText()),
                    if (data.transliteration case final transliteration?)
                      StyledListItem(title: 'Transliteration'.toText(), subtitle: transliteration.toText()),
                  ],
                ],
              ),
            if (strongId != null && strong != null)
              StyledSection(
                title: 'Root'.toText(),
                subtitle: 'Strongs $strongId'.toText(),
                padding: .only(top: 24),
                children: [
                  StyledListItem(title: 'Root Word'.toText(), subtitle: strong.languageText.toText()),
                  StyledListItem(title: 'Transliteration'.toText(), subtitle: strong.transliteration.toText()),
                  StyledListItem(title: 'Pronunciation'.toText(), subtitle: strong.pronunciation.toText()),
                  StyledListItem(
                    title: Row(
                      children: [
                        Expanded(child: 'Strong\'s Definition'.toText()),
                        StyledLink('Legend', onPressed: () => showDefinitionLegend(context)),
                      ],
                    ),
                    subtitle: MarkdownBuilder(
                      strong.formattedDefinition,
                      onLinkPressed: (text, link) {
                        final marker = StrongDefinitionMarker.fromLinkTarget(link);
                        if (marker != null) {
                          showDefinitionLegend(context, marker: marker);
                        } else {
                          openStrong(context, link);
                        }
                      },
                    ),
                  ),
                  if (strong.definition != strong.usage)
                    StyledListItem(
                      title: 'Biblical Usage'.toText(),
                      subtitle: MarkdownBuilder(
                        strong.formattedUsage,
                        onLinkPressed: (text, link) {
                          final stem = HebrewStem.fromLinkTarget(link);
                          if (stem != null) {
                            context.showStyledDialog(
                              (context) => StyledDialog.confirm(
                                title: stem.displayName.toText(),
                                bodyPadding: .zero,
                                body: StyledList(
                                  children: [
                                    StyledListItem(title: 'Definition'.toText(), subtitle: stem.description.toText()),
                                    StyledListItem(
                                      title: 'Examples'.toText(),
                                      subtitle: stem.examples.map((example) => '"$example"').join(', ').toText(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            openStrong(context, link);
                          }
                        },
                      ),
                    ),
                  if (strong.partOfSpeech case final partOfSpeech?)
                    StyledListItem(title: 'Part of Speech'.toText(), subtitle: partOfSpeech.toText()),
                  if (strong.derivation case final derivation?)
                    StyledListItem(
                      title: 'Derivation'.toText(),
                      subtitle: MarkdownBuilder(derivation, onLinkPressed: (text, link) => openStrong(context, link)),
                    ),
                ],
              ),
            if (morphologyCode != null && morphologyCodes != null && selectedMorphologyCode != null)
              StyledSection(
                title: 'Morphology'.toText(),
                subtitle: morphologyCode.toText(),
                padding: .only(top: 24),
                children: [
                  if (morphologyCodes.length > 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16) + .symmetric(vertical: 8),
                      child: StyledSegmentedControl(
                        options: morphologyCodes,
                        onOptionSelected: (code) => selectedMorphologyCodeState.value = code,
                        selectedOption: selectedMorphologyCode,
                        optionBuilder: (morphology) => StyledSelectOption(title: Text(morphology)),
                      ),
                    ),
                  ...Morphology.parse(selectedMorphologyCode).attributes.mapToIterable(
                    (attribute, value) => StyledListItem(
                      title: attribute.displayName.toText(),
                      subtitle: value.displayName.toText(),
                      trailing: StyledPillButton.sm(
                        label: 'Learn More'.toText(),
                        onPressed: () => showMorphologyInfo(context, attribute: attribute, value: value),
                      ),
                    ),
                  ),
                ],
              ),
            if (seeMoreStrongs != null && seeMoreStrongs.isNotEmpty)
              StyledSection(
                title: 'Related Terms'.toText(),
                padding: .only(top: 24),
                children: seeMoreStrongs
                    .map(
                      (strong) => StyledListItem.navigation(
                        title: Row(
                          spacing: 8,
                          children: [
                            strong.languageText.toText(),
                            StyledTag.sm(child: strong.id.toText()),
                          ],
                        ),
                        subtitle: MarkdownBuilder(Markdown(strong.definition.text), maxLines: 2),
                        onPressed: () => openStrong(context, strong.id),
                      ),
                    )
                    .toList(),
              ),
            ...concordanceChildren(
              context,
              ref,
              strongId: strongId,
              onNavigateToVerseSelection: onNavigateToVerseSelection,
            ),
          ];
        },
      );
    });
  }

  static Future<void> showMorphologyInfo(
    BuildContext context, {
    required MorphologyAttribute attribute,
    required MorphologyAttributeValue value,
  }) => context.showStyledDialog(
    (context) => StyledDialog.confirm(
      title: 'Morphology Info'.toText(),
      bodyPadding: .zero,
      body: StyledList(
        children: [
          StyledListItem(title: attribute.displayName.toText(), subtitle: attribute.description.toText()),
          StyledListItem(
            title: value.displayName.toText(),
            subtitle: value.description.toText(),
            thirdLine: value.examples.isEmpty
                ? null
                : ['Examples: ', value.examples.map((example) => '"$example"').join(', ')].join().toText(),
          ),
        ],
      ),
    ),
  );

  static Future<void> showDefinitionLegend(
    BuildContext context, {
    StrongDefinitionMarker? marker,
  }) => context.showStyledDialog(
    (context) => StyledDialog.confirm(
      title: (marker?.title ?? 'Strong\'s Definition Legend').toText(),
      bodyPadding: .zero,
      body: StyledList(
        children: [
          ...(marker == null ? StrongDefinitionMarker.values : [marker]).map(
            (marker) => StyledListItem(
              leading: Text(marker.symbol, style: context.textStyle.labelLg),
              title: marker.title.toText(),
              subtitle: marker.description.toText(),
            ),
          ),
          if (marker == null) ...[
            StyledListItem(
              leading: Text('()', style: context.textStyle.labelLg),
              title: 'Optional word'.toText(),
              subtitle: 'Marks a word or syllable that may be supplied with the main word.'.toText(),
            ),
            StyledListItem(
              leading: Text('[]', style: context.textStyle.labelLg),
              title: 'Added word in Hebrew or Greek'.toText(),
              subtitle:
                  'Marks a word included in the English rendering even though it is not present in the Hebrew or Greek.'
                      .toText(),
            ),
            StyledListItem(
              leading: Symbols.format_italic.toIcon(),
              title: 'Explanation'.toText(),
              subtitle: 'Italic text at the end of a rendering explains a variation from the usual form.'.toText(),
            ),
          ],
        ],
      ),
    ),
  );

  static List<Widget> concordanceChildren(
    BuildContext context,
    WidgetRef ref, {
    required String? strongId,
    Function(VerseSelection)? onNavigateToVerseSelection,
  }) {
    final user = ref.watch(userProvider);
    final studyBible = ref.watch(studyBibleProvider).value;
    if (studyBible == null) {
      return [Padding(padding: .all(16), child: StyledLoading())];
    }

    final otherReferences = strongId == null
        ? null
        : studyBible.references
              .where((reference) => studyBible.getVerseByReference(reference)?.strongIds.contains(strongId) ?? false)
              .toList();

    if (otherReferences == null || otherReferences.isEmpty || onNavigateToVerseSelection == null) {
      return [];
    }

    return StyledSection(
      title: 'Concordance'.toText(),
      padding: .only(top: 24),
      trailing: StyledLink(
        'Open In Search',
        onPressed: () async {
          context.pop();
          final result = await context.push<SearchPageResult>(
            SearchPage(initialSearch: strongId, currentChapterReference: user.lastReference),
          );
          if (result != null) {
            onNavigateToVerseSelection(VerseSelection.reference(result.reference));
          }
        },
      ),
      children: otherReferences
          .map((reference) {
            final verse = studyBible.getVerseByReference(reference);
            if (verse == null) {
              return null;
            }
            return StyledListItem.navigation(
              title: reference.format().toText(),
              subtitle: VerseText.verse(verse: verse, highlightStrongId: strongId),
              onPressed: () => ChapterPreviewPage.show(
                context,
                verseSelection: VerseSelection.reference(reference),
                onNavigateToPassage: () {
                  context.pop();
                  onNavigateToVerseSelection(VerseSelection.reference(reference));
                },
              ),
            );
          })
          .nonNulls
          .toList(),
    ).buildChildren(context);
  }
}
