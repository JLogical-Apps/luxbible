import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/dictionary_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/chapter_preview_page.dart';
import 'package:bible/ui/sheets/dictionary_sheet.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/ui/widgets/search_location_button.dart';
import 'package:bible/ui/widgets/verse_text.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchPageResult {
  final Reference reference;

  const SearchPageResult({required this.reference});
}

class SearchPage extends HookConsumerWidget {
  final String? initialSearch;
  final ChapterReference? currentChapterReference;

  const SearchPage({super.key, this.initialSearch, this.currentChapterReference});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    usePostFrameEffect(() => ref.markOnboardingStep(.searchWord));

    final studyBible = ref.watch(studyBibleProvider);
    final localBible = user.translation.isLocal
        ? ref.watch(localBibleProvider(translation: user.translation)).value
        : studyBible;

    final strongs = ref.watch(strongsProvider);
    final dictionary = ref.watch(dictionaryProvider);

    final textState = useState(initialSearch ?? '');
    final searchState = useState(textState.value);

    final locationsState = useState(<SearchLocationFilter>[]);
    final locations = locationsState.value;

    List<Reference> getSearchedReferences() {
      final locations = locationsState.value;
      final search = searchState.value.trim();
      if (search.isEmpty || localBible == null) {
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
    }

    return StyledPage(
      title: 'Search'.toText(),
      body: Column(
        children: [
          Container(
            padding: .all(16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: Column(
              spacing: 12,
              crossAxisAlignment: .start,
              children: [
                StyledTextField(
                  label: 'Search'.toText(),
                  text: textState.value,
                  autofocus: initialSearch == null,
                  onChanged: (text) {
                    textState.value = text;
                    searchState.value = '';
                    searchResultsState.value = [];
                  },
                  hintText: 'Search for a word or phrase',
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
                if (user.translation.isOnline)
                  StyledBanner(
                    leading: Symbols.book.toIcon(),
                    message: 'Using BSB for search'.toText(),
                    action: StyledTextAction(
                      label: 'Learn More'.toText(),
                      onPressed: () => context.showStyledDialog(
                        (context) => StyledDialog.confirm(
                          title: 'Search Translations'.toText(),
                          body: '${user.translation.title()} does not currently support search. Using BSB instead.'
                              .toText(),
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
                        Padding(
                          padding: .all(16),
                          child: StyledTile.message(
                            title: 'Start a search'.toText(),
                            subtitle: 'Enter a keyword like light, word, or wisdom, then hit enter on the keyboard.'
                                .toText(),
                            leading: Symbols.search.toIcon(),
                          ),
                        ),
                        if (user.searchHistory.isNotEmpty)
                          StyledSection(
                            title: Text('Recents'),
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
                        title: 'No Search Results Found'.toText(),
                        subtitle: 'Try another search'.toText(),
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
                              subtitle: strong.definition.toText(),
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
                            subtitle: Text(entry.definition, maxLines: 2, overflow: .ellipsis),
                            onPressed: () => DictionarySheet.show(context, entry: entry),
                          ),
                        ),
                      ),
                    ...searchResults.map((result) {
                      final verse = localBible?.getVerseByReference(result);
                      if (verse == null) {
                        return null;
                      }

                      return StyledListItem(
                        title: result.format().toText(),
                        subtitle: searchState.value.trim().isStrongId
                            ? VerseText(verse: verse, highlightStrongId: searchState.value.trim())
                            : SubstringHighlight(
                                text: localBible?.getVerseByReference(result)?.text ?? '',
                                term: searchState.value,
                                words: true,
                                textStyle: context.textStyle.paragraphSm.subtle(),
                                textStyleHighlight: context.textStyle.paragraphSm.subtle().bold,
                              ),
                        trailing: Symbols.expand_circle_right.toIcon(),
                        onPressed: () => ChapterPreviewPage.show(
                          context,
                          verseSelection: VerseSelection.reference(result),
                          onNavigateToPassage: () {
                            ref.updateUser((user) => user.withSearchHistory(searchState.value));
                            context.pop(SearchPageResult(reference: result));
                          },
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
