import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/providers/dictionary_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/ui/dialogs/tutorial_dialog.dart';
import 'package:bible/ui/sheets/dictionary_sheet.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/ui/widgets/search_location_button.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class SearchPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  final String? initialSearch;
  final ChapterReference? currentChapterReference;

  const SearchPage({super.key, this.initialSearch, this.currentChapterReference});

  @override
  String get path => '/search';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    usePostFrameEffect(() {
      ref.markOnboardingStep(.searchWord);
      if (initialSearch?.trim().isNotEmpty == true) AnalyticsEvent.search.log();
    });

    final studyBible = ref.watch(studyBibleProvider).value;
    final localBible = user.translation.isLocal
        ? ref.watch(localBibleProvider(translation: user.translation)).value
        : studyBible;

    final strongs = ref.watch(strongsProvider);
    final dictionary = ref.watch(dictionaryProvider);

    final textState = useState(initialSearch ?? '');
    final searchState = useState(textState.value);
    final search = searchState.value.trim();
    final isSearchActive = search.isNotEmpty;
    final searchTerms = search.bibleSearchTerms;

    final locationsState = useState(<SearchLocationFilter>[]);
    final locations = locationsState.value;

    final searchWordMatchingState = useState(SearchWordMatching.wholeWord);
    final searchWordMatching = searchWordMatchingState.value;

    final searchResultsState = useState<List<Reference>?>(null);
    final searchResults = searchResultsState.value ?? [];

    final isStrongSearch = search.isStrongId;
    final searchBible = isStrongSearch ? studyBible : localBible;
    final isSearchLoading = isSearchActive && searchResultsState.value == null;

    List<Reference> getSearchedReferences() {
      final locations = locationsState.value;
      if (search.isEmpty || searchBible == null) {
        return [];
      }

      final validReferences = searchBible.references
          .where((reference) => locations.isEmpty || locations.any((filter) => filter.passes(reference)))
          .toList();

      if (isStrongSearch) {
        return validReferences
            .where((reference) => searchBible.getVerseByReference(reference)?.strongIds.has(search) ?? false)
            .toList();
      }

      return searchTerms.isEmpty
          ? <Reference>[]
          : validReferences
                .where(
                  (reference) =>
                      searchBible
                          .getVerseByReference(reference)
                          ?.searchTerms
                          .containsInOrderWhere(
                            searchTerms,
                            (word, searchTerm) => searchWordMatching.matches(word, searchTerm),
                          ) ??
                      false,
                )
                .toList();
    }

    usePostFrameEffect(() {
      if (isSearchActive) {
        if (searchBible == null) {
          searchResultsState.value = null;
          return;
        }

        searchResultsState.value = getSearchedReferences();
        if (searchState.value.isNotEmpty) {
          ref.updateUser((user) => user.withSearchHistory(searchState.value));
        }
      }
    }, [searchBible, search, locations, searchWordMatching]);

    final isUsingStudyBible = user.translation.isOnline || (isStrongSearch && !user.translation.isStudy);

    return StyledPage(
      title: t.labels.search.toText(),
      body: Column(
        children: [
          Container(
            padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .symmetric(vertical: 16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: Column(
              spacing: 12,
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: .symmetric(horizontal: 16),
                  child: StyledTextField(
                    label: t.labels.search.toText(),
                    text: textState.value,
                    autofocus: initialSearch == null,
                    onChanged: (text) {
                      textState.value = text;
                      searchState.value = '';
                      searchResultsState.value = null;
                    },
                    hintText: t.searchUi.wordOrPhraseHint,
                    onSubmit: (newText) {
                      textState.value = newText;
                      searchState.value = newText;
                      searchResultsState.value = null;
                      if (newText.trim().isNotEmpty) AnalyticsEvent.search.log();
                    },
                  ),
                ),
                SingleChildScrollView(
                  padding: .symmetric(horizontal: 16),
                  scrollDirection: .horizontal,
                  child: Row(
                    spacing: 8,
                    children: [
                      SearchLocationButton(
                        locations: locations,
                        onLocationsSelected: (locations) {
                          locationsState.value = locations;
                          searchState.value = textState.value;
                          searchResultsState.value = null;
                        },
                        currentBook: currentChapterReference?.book,
                      ),
                      StyledPillButton.md(
                        leading: Symbols.match_word.toIcon(),
                        trailing: Symbols.keyboard_arrow_down.toIcon(),
                        label: searchWordMatching.title().toText(),
                        colorBuilder: searchWordMatching == .wholeWord ? null : .primary,
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final newWordMatching = await context.showStyledSheet(
                            (context, _) => StyledSelectionSheet(
                              title: t.searchUi.wordMatching.title.toText(),
                              options: SearchWordMatching.values,
                              initialOption: searchWordMatching,
                              optionMapper: (option) => StyledSelectOption(
                                title: option.title().toText(),
                                subtitle: option.description().toText(),
                                thirdLine: option.example().toText(),
                              ),
                            ),
                          );
                          if (newWordMatching != null) {
                            searchWordMatchingState.value = newWordMatching;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                if (isUsingStudyBible && !user.tutorials.has(.searchStudy))
                  Padding(
                    padding: .symmetric(horizontal: 16),
                    child: StyledBanner(
                      leading: Symbols.book.toIcon(),
                      message: t.searchUi.usingTranslation(translation: user.studyTranslation.title()).toText(),
                      action: StyledTextAction(
                        label: t.common.learnMore.toText(),
                        onPressed: () => context.showStyledDialog(
                          (context) => TutorialDialog(
                            title: t.searchUi.searchBible.toText(),
                            body: isStrongSearch
                                ? t.searchUi.strongSearchStudyBibleExplanation.toText()
                                : t.searchUi.unsupportedTranslation(translation: user.translation.title()).toText(),
                            tutorial: .searchStudy,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: StyledLoading(
              loadingPadding: .all(16),
              child: isSearchLoading
                  ? null
                  : StyledScrollbar(
                      child: StyledListView(
                        padding: .only(
                          bottom: MediaQuery.paddingOf(context).bottom + MediaQuery.viewInsetsOf(context).bottom,
                        ),
                        children: [
                          if (!isSearchActive)
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                SafeArea(
                                  bottom: false,
                                  top: false,
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
                                              StyledSwipeableAction.remove(
                                                onPressed: () => ref.updateUser(
                                                  (user) =>
                                                      user.copyWith(searchHistory: user.searchHistory.withRemovedAt(i)),
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
                                                searchResultsState.value = null;
                                                AnalyticsEvent.search.log();
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
                            if (isStrongSearch) ...[
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
                                    subtitle: MarkdownBuilder(
                                      entry.definitions.first.withCollapsedWhitespace,
                                      maxLines: 2,
                                    ),
                                    onPressed: () => DictionarySheet.show(
                                      context,
                                      entry: entry,
                                      onNavigateToVerseSelection: (verseSelection) => context.pop(verseSelection),
                                    ),
                                  ),
                                ),
                              ),
                            ...searchResults.map((result) {
                              final verse = searchBible?.getVerseByReference(result);
                              if (verse == null) return null;

                              return StyledListItem.navigation(
                                title: result.format().toText(),
                                subtitle: searchState.value.trim().isStrongId
                                    ? VerseText.verse(
                                        redLetters: user.themeLayout.redLetters,
                                        verse: verse,
                                        highlightStrongId: searchState.value.trim(),
                                      )
                                    : VerseText.verse(
                                        redLetters: user.themeLayout.redLetters,
                                        verse: verse,
                                        isWordHighlighted: (word) {
                                          final wordTerms = word.bibleSearchTerms;
                                          return wordTerms.any(
                                            (wordTerm) => searchTerms.any(
                                              (searchTerm) => searchWordMatching.matches(wordTerm, searchTerm),
                                            ),
                                          );
                                        },
                                        style: context.textStyle.paragraphSm.subtle(),
                                      ),
                                onPressed: () => PassagePreviewPage.show(
                                  context,
                                  verseSelection: VerseSelection.reference(result),
                                  onNavigateToVerseSelection: (selection) => context.pop(selection),
                                ),
                              );
                            }).nonNulls,
                          ],
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

enum SearchWordMatching {
  wholeWord,
  startOfWord,
  partOfWord;

  bool matches(String word, String searchTerm) => switch (this) {
    wholeWord => word == searchTerm,
    startOfWord => word.startsWith(searchTerm),
    partOfWord => word.contains(searchTerm),
  };

  String title() => switch (this) {
    wholeWord => t.searchUi.wordMatching.wholeWord.title,
    startOfWord => t.searchUi.wordMatching.startOfWord.title,
    partOfWord => t.searchUi.wordMatching.partOfWord.title,
  };

  String description() => switch (this) {
    wholeWord => t.searchUi.wordMatching.wholeWord.description,
    startOfWord => t.searchUi.wordMatching.startOfWord.description,
    partOfWord => t.searchUi.wordMatching.partOfWord.description,
  };

  String example() => switch (this) {
    wholeWord => t.searchUi.wordMatching.wholeWord.example,
    startOfWord => t.searchUi.wordMatching.startOfWord.example,
    partOfWord => t.searchUi.wordMatching.partOfWord.example,
  };
}
