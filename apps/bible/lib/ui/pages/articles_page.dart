import 'package:bible/models/article_collection.dart';
import 'package:bible/models/linked_resource.dart';
import 'package:bible/providers/articles_provider.dart';
import 'package:bible/ui/widgets/article_list_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class ArticlesPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  final ArticleCollection collection;

  const ArticlesPage({super.key, required this.collection});

  @override
  String get path => '/${collection.name}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articlesProvider(collection: collection)).value;
    final sortedArticles = useMemoized(() => articles?.sortedBy((article) => article.title.toUpperCase()), [articles]);

    final searchState = useState('');
    final matchingArticles = sortedArticles?.whereMatchingTitleSearch(searchState.value).toList();

    return StyledPage(
      title: collection.title().toText(),
      body: Column(
        children: [
          Container(
            padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .all(16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: StyledTextField(
              text: searchState.value,
              hintText: collection.searchHint(),
              onChanged: (text) => searchState.value = text,
              autocorrect: false,
            ),
          ),
          Expanded(
            child: StyledScrollbar(
              child: StyledListView(
                padding: .only(bottom: MediaQuery.paddingOf(context).bottom + MediaQuery.viewInsetsOf(context).bottom),
                children: [
                  if (matchingArticles == null)
                    Padding(padding: .all(16), child: StyledLoading())
                  else if (matchingArticles.isEmpty)
                    SafeArea(
                      top: false,
                      bottom: false,
                      child: Padding(
                        padding: .all(16),
                        child: StyledTile.message(
                          title: collection.noMatchesMessage().toText(),
                          subtitle: t.emptyStates.tryAnotherSearch.toText(),
                          leading: Symbols.search.toIcon(),
                        ),
                      ),
                    ),
                  ...?matchingArticles?.map(
                    (article) => ArticleListItem(
                      collection: collection,
                      article: article,
                      onNavigateToVerseSelection: (verseSelection) => context.pop(verseSelection),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
