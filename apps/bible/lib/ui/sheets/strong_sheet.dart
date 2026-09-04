import 'package:bible/models/morphology.dart';
import 'package:bible/models/strong.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
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

    final breadcrumbText = word?.data?.inflection ?? strong?.id ?? '';
    await context.showStyledSheetWithBreadcrumbs(breadcrumbText: breadcrumbText, (context, _) {
      final selectedMorphologyCodeState = useState(morphologyCodes?.firstOrNull);
      final selectedMorphologyCode = selectedMorphologyCodeState.value;

      return StyledSheet.builder(
        title: (word != null ? t.strongSheet.interlinearWord : t.strongSheet.lexicon).toText(),
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
                title: t.strongSheet.usage.toText(),
                padding: .only(top: 24),
                children: [
                  if (word.text case final text?)
                    StyledListItem(title: t.languages.english.toText(), subtitle: text.toText()),
                  if (word.data case final data?) ...[
                    StyledListItem(title: t.strongSheet.inflected.toText(), subtitle: data.inflection?.toText()),
                    if (data.transliteration case final transliteration?)
                      StyledListItem(title: t.strongSheet.transliteration.toText(), subtitle: transliteration.toText()),
                  ],
                ],
              ),
            if (strongId != null && strong != null)
              StyledSection(
                title: t.strongSheet.root.toText(),
                subtitle: t.strongSheet.strongsId(id: strongId).toText(),
                padding: .only(top: 24),
                children: [
                  StyledListItem(title: t.strongSheet.rootWord.toText(), subtitle: strong.languageText.toText()),
                  StyledListItem(
                    title: t.strongSheet.transliteration.toText(),
                    subtitle: strong.transliteration.toText(),
                  ),
                  StyledListItem(title: t.strongSheet.pronunciation.toText(), subtitle: strong.pronunciation.toText()),
                  StyledListItem(
                    title: Row(
                      children: [
                        Expanded(child: t.strongSheet.strongsDefinition.toText()),
                        StyledLink(t.strongSheet.legend, onPressed: () => showDefinitionLegend(context)),
                      ],
                    ),
                    subtitle: MarkdownBuilder(
                      strong.formattedDefinition,
                      onLinkPressed: (text, link) {
                        final marker = StrongDefinitionMarker.fromLinkTarget(link);
                        if (marker != null) {
                          context.showStyledDialog(
                            (context) => StyledDialog.confirm(
                              title: marker.title.toText(),
                              bodyPadding: .zero,
                              body: StyledListItem(
                                leading: Text(marker.symbol, style: context.textStyle.labelLg),
                                title: marker.title.toText(),
                                subtitle: marker.description.toText(),
                              ),
                            ),
                          );
                        } else {
                          openStrong(context, link);
                        }
                      },
                    ),
                  ),
                  if (strong.definition != strong.usage)
                    StyledListItem(
                      title: t.strongSheet.biblicalUsage.toText(),
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
                                    StyledListItem(
                                      title: t.strongSheet.definition.toText(),
                                      subtitle: stem.description.toText(),
                                    ),
                                    StyledListItem(
                                      title: t.strongSheet.examples.toText(),
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
                    StyledListItem(title: t.strongSheet.partOfSpeech.toText(), subtitle: partOfSpeech.toText()),
                  if (strong.derivation case final derivation?)
                    StyledListItem(
                      title: t.strongSheet.derivation.toText(),
                      subtitle: MarkdownBuilder(derivation, onLinkPressed: (text, link) => openStrong(context, link)),
                    ),
                ],
              ),
            if (morphologyCode != null && morphologyCodes != null && selectedMorphologyCode != null)
              StyledSection(
                title: t.strongSheet.morphology.toText(),
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
                        label: t.common.learnMore.toText(),
                        onPressed: () => showMorphologyInfo(context, attribute: attribute, value: value),
                      ),
                    ),
                  ),
                ],
              ),
            if (seeMoreStrongs != null && seeMoreStrongs.isNotEmpty)
              StyledSection(
                title: t.strongSheet.relatedTerms.toText(),
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
      title: t.strongSheet.morphologyInfo.toText(),
      bodyPadding: .zero,
      body: StyledList(
        children: [
          StyledListItem(title: attribute.displayName.toText(), subtitle: attribute.description.toText()),
          StyledListItem(
            title: value.displayName.toText(),
            subtitle: value.description.toText(),
            thirdLine: value.examples.isEmpty
                ? null
                : [
                    t.strongSheet.examplesPrefix,
                    value.examples.map((example) => '"$example"').join(', '),
                  ].join().toText(),
          ),
        ],
      ),
    ),
  );

  static Future<void> showDefinitionLegend(BuildContext context) => context.showStyledDialog(
    (context) => StyledDialog.confirm(
      title: t.strongSheet.definitionLegend.toText(),
      bodyPadding: .zero,
      body: StyledList(
        children: [
          StyledListItem(
            leading: Text('()', style: context.textStyle.labelLg),
            title: t.strongSheet.optionalWord.toText(),
            subtitle: t.strongSheet.optionalWordDescription.toText(),
          ),
          StyledListItem(
            leading: Text('[]', style: context.textStyle.labelLg),
            title: t.strongSheet.addedWord.toText(),
            subtitle: t.strongSheet.addedWordDescription.toText(),
          ),
          StyledListItem(
            leading: Symbols.format_italic.toIcon(),
            title: t.strongSheet.explanation.toText(),
            subtitle: t.strongSheet.renderingExplanation.toText(),
          ),
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
              .where((reference) => studyBible.getVerseByReference(reference)?.strongIds.has(strongId) ?? false)
              .toList();

    if (otherReferences == null || otherReferences.isEmpty || onNavigateToVerseSelection == null) {
      return [];
    }

    return StyledSection(
      title: t.strongSheet.concordance.toText(),
      padding: .only(top: 24),
      trailing: StyledLink(
        t.strongSheet.openInSearch,
        onPressed: () async {
          context.pop();
          final result = await context.push(
            (context) => SearchPage(initialSearch: strongId, currentChapterReference: user.lastReference),
          );
          if (result != null) {
            onNavigateToVerseSelection(result);
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
              subtitle: VerseText.verse(
                redLetters: user.themeLayout.redLetters,
                verse: verse,
                highlightStrongId: strongId,
              ),
              onPressed: () => PassagePreviewPage.show(
                context,
                verseSelection: VerseSelection.reference(reference),
                onNavigateToVerseSelection: (selection) {
                  context.pop();
                  onNavigateToVerseSelection(selection);
                },
              ),
            );
          })
          .nonNulls
          .toList(),
    ).buildChildren(context);
  }
}
