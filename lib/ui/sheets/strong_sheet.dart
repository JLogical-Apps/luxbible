import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/widgets/verse_text.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class StrongSheet {
  static Future<void> showWithContext(
    BuildContext context,
    WidgetRef ref, {
    required String strongId,
    required User user,
    required Function(Passage) onNavigateToPassage,
  }) async {
    final strongs = ref.read(strongsProvider);
    final strong = strongs[strongId];
    if (strong == null) {
      return;
    }

    final bibles = ref.read(studyBiblesProvider);
    final bible = bibles.firstWhere((bible) => bible.translation == .bsb);

    final seeMoreStrongs = strong.glossary.map((glossary) => strongs[glossary]).nonNulls.toList();
    final otherReferences = bible.references
        .where((reference) => bible.getVerseByReference(reference)?.strongIds.contains(strongId) ?? false)
        .toList();

    await context.showStyledSheetWithBreadcrumbs(
      breadcrumbText: strong.id,
      (context) => StyledSheet(
        title: 'Strong Word Analysis'.toText(),
        subtitle: strong.id.toText(),
        children: [
          StyledSection(
            title: 'Info'.toText(),
            padding: .only(top: 24),
            children: [
              StyledListItem(title: 'ID'.toText(), subtitle: strongId.toText()),
              StyledListItem(title: 'Pronunciation'.toText(), subtitle: strong.pronunciation.toText()),
              StyledListItem(title: 'Transliteration'.toText(), subtitle: strong.transliteration.toText()),
              StyledListItem(title: 'Definition'.toText(), subtitle: strong.definition.toText()),
            ],
          ),
          if (seeMoreStrongs.isNotEmpty)
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
                          user: user,
                          onNavigateToPassage: onNavigateToPassage,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          if (otherReferences.isNotEmpty)
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
      ),
    );
  }
}
