import 'package:bible/models/bible/word.dart';
import 'package:bible/models/morphology.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/widgets/verse_text.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class StrongSheet {
  static Future<void> showWithBreadcrumbs(
    BuildContext context, {
    String? strongId,
    Word? word,
    Function(VerseSelection)? onNavigateToVerseSelection,
  }) async {
    final user = ref.read(userProvider);
    final studyBible = ref.read(studyBibleProvider);

    final strongs = ref.read(strongsProvider);
    final strong = strongs[strongId];

    final seeMoreStrongs = strong?.glossary.map((glossary) => strongs[glossary]).nonNulls.toList();
    final otherReferences = strongId == null
        ? null
        : studyBible.references
              .where((reference) => studyBible.getVerseByReference(reference)?.strongIds.contains(strongId) ?? false)
              .toList();

    final morphologyCode = word?.data?.morphology;
    final morphologyCodes = morphologyCode == null ? null : Morphology.splitCode(morphologyCode);

    await context.showStyledSheetWithBreadcrumbs(breadcrumbText: word?.data?.inflection ?? strong?.id ?? '', (context) {
      final selectedMorphologyCodeState = useState(morphologyCodes?.firstOrNull);
      final selectedMorphologyCode = selectedMorphologyCodeState.value;

      return StyledSheet(
        title: 'Interlinear Word'.toText(),
        subtitle: word?.data?.inflection?.toText() ?? strongId?.toText(),
        children: [
          if (word != null)
            StyledSection(
              title: 'Usage'.toText(),
              padding: .only(top: 24),
              children: [
                if (word.text case final text?) StyledListItem(title: 'English'.toText(), subtitle: text.toText()),
                if (word.data case final data?) ...[
                  StyledListItem(title: 'Inflected'.toText(), subtitle: data.inflection?.toText()),
                  StyledListItem(title: 'Transliteration'.toText(), subtitle: data.transliteration?.toText()),
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
                StyledListItem(title: 'Definition'.toText(), subtitle: strong.definition.toText()),
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
                      onPressed: () => context.showStyledDialog(
                        (context) => StyledDialog.confirm(
                          title: 'Morphology Info'.toText(),
                          bodyPadding: .zero,
                          body: StyledList(
                            children: [
                              StyledListItem(
                                title: attribute.displayName.toText(),
                                subtitle: attribute.description.toText(),
                              ),
                              StyledListItem(
                                title: value.displayName.toText(),
                                subtitle: value.description.toText(),
                                thirdLine: value.examples.isEmpty
                                    ? null
                                    : [
                                        'Examples: ',
                                        value.examples.map((example) => '"$example"').join(', '),
                                      ].join().toText(),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                      title: strong.id.toText(),
                      subtitle: Text('${strong.languageText}: ${strong.definition}', maxLines: 1, overflow: .ellipsis),
                      onPressed: () {
                        context.pop();
                        StrongSheet.showWithBreadcrumbs(
                          context,
                          strongId: strong.id,
                          onNavigateToVerseSelection: onNavigateToVerseSelection,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          if (otherReferences != null && otherReferences.isNotEmpty && onNavigateToVerseSelection != null)
            ...StyledSection(
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
                    return StyledListItem(
                      title: reference.format().toText(),
                      subtitle: VerseText(verse: verse, highlightStrongId: strongId),
                      trailing: Symbols.expand_circle_right.toIcon(),
                      onPressed: () {
                        context.pop();
                        onNavigateToVerseSelection(VerseSelection.reference(reference));
                      },
                    );
                  })
                  .nonNulls
                  .toList(),
            ).buildChildren(context),
        ],
      );
    });
  }
}
