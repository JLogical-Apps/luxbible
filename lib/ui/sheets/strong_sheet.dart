import 'package:bible/models/bible/study/verse_fragment.dart';
import 'package:bible/models/morphology.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/style/widgets/dialog/styled_dialog.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/widgets/verse_text.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class StrongSheet {
  static Future<void> showWithContext(
    BuildContext context,
    WidgetRef ref, {
    String? strongId,
    VerseFragment? fragment,
    Function(Passage)? onNavigateToPassage,
  }) async {
    final user = ref.read(userProvider);

    final strongs = ref.read(strongsProvider);
    final strong = strongs[strongId];

    final bibles = ref.read(studyBiblesProvider);
    final bible = bibles.firstWhere((bible) => bible.translation == .bsb);

    final seeMoreStrongs = strong?.glossary.map((glossary) => strongs[glossary]).nonNulls.toList();
    final otherReferences = strongId == null
        ? null
        : bible.references
              .where((reference) => bible.getVerseByReference(reference)?.strongIds.contains(strongId) ?? false)
              .toList();

    final morphologyCode = fragment?.study?.morphology;
    final morphologyCodes = morphologyCode == null ? null : Morphology.splitCode(morphologyCode);

    await context.showStyledSheetWithBreadcrumbs(breadcrumbText: fragment?.study?.inflection ?? strong?.id ?? '', (
      context,
    ) {
      final selectedMorphologyCodeState = useState(morphologyCodes?.firstOrNull);
      final selectedMorphologyCode = selectedMorphologyCodeState.value;

      return StyledSheet(
        title: 'Interlinear Word'.toText(),
        subtitle: fragment?.study?.inflection?.toText() ?? strongId?.toText(),
        children: [
          if (fragment != null)
            StyledSection(
              title: 'Usage'.toText(),
              padding: .only(top: 24),
              children: [
                if (!fragment.isEmptyText)
                  StyledListItem(title: 'English'.toText(), subtitle: fragment.displayText.toText()),
                if (fragment.study case final study?)
                  StyledListItem(title: 'Inflected'.toText(), subtitle: study.inflection?.toText()),
                if (strong != null) StyledListItem(title: 'Root Word'.toText(), subtitle: strong.languageText.toText()),
              ],
            ),
          if (strongId != null && strong != null)
            StyledSection(
              title: 'Strongs'.toText(),
              subtitle: strongId.toText(),
              padding: .only(top: 24),
              children: [
                StyledListItem(title: 'Root Word'.toText(), subtitle: strong.languageText.toText()),
                StyledListItem(title: 'Pronunciation'.toText(), subtitle: strong.pronunciation.toText()),
                StyledListItem(title: 'Transliteration'.toText(), subtitle: strong.transliteration.toText()),
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
                      textBuilder: (morphology) => morphology,
                    ),
                  ),
                ...Morphology.parse(selectedMorphologyCode).attributes.mapToIterable(
                  (attribute, value) => StyledListItem(
                    title: attribute.displayName.toText(),
                    subtitle: value.displayName.toText(),
                    trailing: StyledPillButton(
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
                        StrongSheet.showWithContext(
                          context,
                          ref,
                          strongId: strong.id,
                          onNavigateToPassage: onNavigateToPassage,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          if (otherReferences != null && otherReferences.isNotEmpty && onNavigateToPassage != null)
            ...StyledSection(
              title: 'Concordance'.toText(),
              padding: .only(top: 24),
              trailing: StyledLink(
                'Open In Search',
                onPressed: () async {
                  context.pop();
                  final result =
                      await context.push(
                            SearchPage(initialSearch: strongId, currentChapterReference: user.lastReference),
                          )
                          as SearchPageResult?;
                  if (result != null) {
                    onNavigateToPassage(Passage.reference(result.reference));
                  }
                },
              ),
              children: otherReferences
                  .map((reference) {
                    final verse = bible.getVerseByReference(reference);
                    if (verse == null) {
                      return null;
                    }
                    return StyledListItem(
                      title: reference.format().toText(),
                      subtitle: VerseText(verse: verse, highlightStrongId: strongId),
                      trailing: Symbols.expand_circle_right.toIcon(),
                      onPressed: () {
                        context.pop();
                        onNavigateToPassage(Passage.reference(reference));
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
