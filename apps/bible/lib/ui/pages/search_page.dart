import 'package:bible/models/user/tutorial.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/providers/dictionary_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/dialogs/tutorial_dialog.dart';
import 'package:bible/ui/pages/chapter_preview_page.dart';
import 'package:bible/ui/sheets/dictionary_sheet.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/ui/widgets/search_location_button.dart';
import 'package:bible/ui/widgets/verse_text.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class SearchPageResult {
  final VerseSelection selection;

  const SearchPageResult({required this.selection});
}

class SearchPage extends HookConsumerWidget {
  final String? initialSearch;
  final ChapterReference? currentChapterReference;

  const SearchPage({super.key, this.initialSearch, this.currentChapterReference});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    usePostFrameEffect(() => ref.markOnboardingStep(.searchWord));

    usePostFrameEffect(() {
      if (initialSearch case final initialSearch?) {
        ref.updateUser((user) => user.withSearchHistory(initialSearch));
      }
    });

    final studyBible = ref.watch(studyBibleProvider).value;
    final localBible = user.translation.isLocal
        ? ref.watch(localBibleProvider(translation: user.translation)).value
        : studyBible;

    if (localBible == null || studyBible == null) {
      return SizedBox.shrink();
    }

    final strongs = ref.watch(strongsProvider);
    final dictionary = ref.watch(dictionaryProvider);

    final textState = useState(initialSearch ?? '');
    final searchState = useState(textState.value);

    final locationsState = useState(<SearchLocationFilter>[]);
    final locations = locationsState.value;

    List<Reference> getSearchedReferences() {
      final locations = locationsState.value;
      final search = searchState.value.trim();
      if (search.isEmpty) {
        return [];
      }

      final validReferences = localBible.references
          .where((reference) => locations.isEmpty || locations.any((filter) => filter.passes(reference)))
          .toList();

      if (search.isStrongId) {
        return validReferences
            .where((reference) => studyBible.getVerseByReference(reference)?.strongIds.contains(search) ?? false)
            .toList();
      }

      final searchTerms = search.onlyLetters.toLowerCase().split(' ');
      return searchTerms.isEmpty
          ? <Reference>[]
          : validReferences
                .where(
                  (reference) =>
                      localBible.getVerseByReference(reference)?.searchTerms.containsInOrder(searchTerms) ?? false,
                )
                .toList();
    }

    final searchResultsState = useState(useMemoized(() => getSearchedReferences()));
    final searchResults = searchResultsState.value;

    void search() {
      searchResultsState.value = getSearchedReferences();
      if (searchState.value.isNotEmpty) {
        ref.updateUser((user) => user.withSearchHistory(searchState.value));
      }
    }

    return StyledPage(
      title: t.labels.search.toText(),
      body: Column(
        children: [
          Container(
            padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .all(16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: Column(
              spacing: 12,
              crossAxisAlignment: .start,
              children: [
                StyledTextField(
                  label: t.labels.search.toText(),
                  text: textState.value,
                  autofocus: initialSearch == null,
                  onChanged: (text) {
                    textState.value = text;
                    searchState.value = '';
                    searchResultsState.value = [];
                  },
                  hintText: t.searchUi.wordOrPhraseHint,
                  onSubmit: (newText) {
                    textState.value = newText;
                    searchState.value = newText;
                    search();
                  },
                ),
                SearchLocationButton(
                  locations: locations,
                  onLocationsSelected: (locations) {
                    locationsState.value = locations;
                    searchState.value = textState.value;
                    search();
                  },
                  currentBook: currentChapterReference?.book,
                ),
                if (user.translation.isOnline && !user.tutorials.contains(Tutorial.searchStudy))
                  StyledBanner(
                    leading: Symbols.book.toIcon(),
                    message: t.searchUi.usingTranslation(translation: user.studyTranslation.title()).toText(),
                    action: StyledTextAction(
                      label: t.common.learnMore.toText(),
                      onPressed: () => context.showStyledDialog(
                        (context) => TutorialDialog(
                          title: t.searchUi.searchBible.toText(),
                          body: t.searchUi.unsupportedTranslation(translation: user.translation.title()).toText(),
                          tutorial: .searchStudy,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: StyledListView(
                padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
                children: [
                  if (searchState.value.isEmpty)
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: .all(16),
                            child: StyledTile.message(
                              title: t.searchUi.startSearch.toText(),
                              subtitle: t.searchUi.searchPrompt.toText(),
                              leading: Symbols.search.toIcon(),
                            ),
                          ),
                        ),
                        if (user.searchHistory.isNotEmpty)
                          StyledSection(
                            title: Text(t.navigation.recents),
                            children: user.searchHistory
                                .mapIndexed(
                                  (i, searchResult) => StyledSwipeable(
                                    key: ValueKey(searchResult),
                                    actions: [
                                      StyledSwipeableAction.delete(
                                        onPressed: () => ref.updateUser(
                                          (user) => user.copyWith(searchHistory: user.searchHistory.withRemovedAt(i)),
                                        ),
                                      ),
                                    ],
                                    child: StyledListItem(
                                      leading: Symbols.history.toIcon(),
                                      title: Text(searchResult),
                                      trailing: Symbols.search.toIcon(),
                                      onPressed: () {
                                        textState.value = searchResult;
                                        searchState.value = searchResult;
                                        search();
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                      ],
                    )
                  else if (searchResults.isEmpty)
                    Padding(
                      padding: .all(16),
                      child: StyledTile.message(
                        title: t.emptyStates.noSearchResults.toText(),
                        subtitle: t.emptyStates.tryAnotherSearch.toText(),
                        leading: Symbols.search.toIcon(),
                      ),
                    )
                  else ...[
                    if (searchState.value.isStrongId) ...[
                      if (strongs[searchState.value] case final strong?)
                        Padding(
                          padding: .all(16),
                          child: StyledTile(
                            child: StyledListItem.navigation(
                              title: SingleChildScrollView(
                                scrollDirection: .horizontal,
                                child: Row(
                                  spacing: 8,
                                  children: [
                                    StyledTag.sm(child: strong.id.toText()),
                                    Text([strong.languageText, strong.transliteration].join('  ·  ')),
                                  ],
                                ),
                              ),
                              subtitle: MarkdownBuilder(strong.definition, maxLines: 4),
                              onPressed: () => StrongSheet.showWithBreadcrumbs(context, strongId: strong.id),
                            ),
                          ),
                        ),
                    ] else if (dictionary[searchState.value.trim().toUpperCase()] case final entry?)
                      Padding(
                        padding: .all(16),
                        child: StyledTile(
                          child: StyledListItem.navigation(
                            title: entry.title.toText(),
                            subtitle: MarkdownBuilder(entry.definitions.first.withCollapsedWhitespace, maxLines: 2),
                            onPressed: () => DictionarySheet.show(
                              context,
                              entry: entry,
                              onNavigateToVerseSelection: (verseSelection) =>
                                  context.pop(SearchPageResult(selection: verseSelection)),
                            ),
                          ),
                        ),
                      ),
                    ...searchResults.map((result) {
                      final verse = localBible.getVerseByReference(result);
                      if (verse == null) {
                        return null;
                      }

                      return StyledListItem.navigation(
                        title: result.format().toText(),
                        subtitle: searchState.value.trim().isStrongId
                            ? VerseText.verse(verse: verse, highlightStrongId: searchState.value.trim())
                            : VerseText.verse(
                                verse: verse,
                                highlightTerm: searchState.value,
                                style: context.textStyle.paragraphSm.subtle(),
                              ),
                        onPressed: () => ChapterPreviewPage.show(
                          context,
                          verseSelection: VerseSelection.reference(result),
                          onNavigateToVerseSelection: (selection) =>
                              context.pop(SearchPageResult(selection: selection)),
                        ),
                      );
                    }).nonNulls,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
