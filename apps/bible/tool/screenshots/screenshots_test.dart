import 'dart:io';

import 'package:bible/models/annotation.dart';
import 'package:bible/functions/commentary_importer.dart';
import 'package:bible/models/article_collection.dart';
import 'package:bible/models/resource_type.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/articles_provider.dart';
import 'package:bible/providers/commentary_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/bible_navigation_service.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/pages/bible_plan_search_page.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:bible/ui/pages/create_bible_plan_page.dart';
import 'package:bible/ui/pages/highlight_styles_page.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/sheets/article_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/ui/widgets/search_location_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lux/lux.dart';

import 'harness.dart';
import 'seed.dart';

void main() {
  late User demo;
  late Annotation wordWasGod;

  setUpAll(() async {
    await setUpScreenshotApp(
      overrides: [
        // The study notes image shows the summary and the verse's note together, without the long introduction between.
        commentaryProvider(type: .tyndale, book: .john).overrideWith(
          (ref) async => (await CommentaryImporter().import(type: .tyndale, book: .john)).copyWith(introduction: []),
        ),
      ],
    );
    // flutter_test answers every HTTP request with a 400, but video artwork streams from BibleProject's CDN.
    HttpOverrides.global = null;
    demo = await buildDemoUser();
    await preload(demo);
    wordWasGod = await phraseAnnotation('John 1:1', 'the Word was God', christ, age: Duration(days: 2));
  });

  User at(String passage, {List<StudyPanel> studyPanels = const [], List<ResourceType>? resourceOrder}) =>
      demo.copyWith(lastPosition: positionOf(passage), studyPanels: studyPanels, resourceOrder: resourceOrder);

  VerseSelection passage(String text) => VerseSelection.fromReferences(VerseSelection.parse(text).references);

  Future<void> select(Screenshot screenshot, String text) =>
      screenshot.run(() => ref.read(bibleNavigationServiceProvider).navigateTo(passage(text)));

  Future<void> openStudyAction(Screenshot screenshot, StudyAction action, String text) => screenshot.run(
    () => action.onPressed(
      screenshot.context,
      verseSelection: passage(text),
      regionFormat: passage(text).format(),
      onNavigateToVerseSelection: (_) {},
      onAddStudyPanel: (_) {},
      user: ref.read(userProvider),
    ),
  );

  Future<void> push(Screenshot screenshot, StyledRoute route) => screenshot.run(() => screenshot.context.push(route));

  Future<void> studyAt(Screenshot screenshot, String text, StudyAction action, {User? user}) async {
    await screenshot.pumpApp(user ?? at(text));
    await select(screenshot, text);
    await openStudyAction(screenshot, action, text);
  }

  // The panel saves its height after a second, which rebuilds the passage and restarts its fade-in.
  Future<void> pumpWithPanel(Screenshot screenshot, User user) async {
    await screenshot.pumpApp(user);
    await screenshot.settle(rounds: 20);
  }

  screenshotTest('1_interlinear_reader', (screenshot) async {
    await screenshot.pumpApp(at('John 1').withAnnotation(wordWasGod));
    await select(screenshot, 'John 1:1');
  });

  screenshotTest('1_interlinear_sheet', (screenshot) => studyAt(screenshot, 'John 1:1', .interlinear));

  screenshotTest('1_interlinear_word', (screenshot) async {
    await studyAt(screenshot, 'John 1:1', .interlinear);
    await screenshot.tap(
      find.ancestor(of: find.text('the beginning'), matching: find.byType(InterlinearWordTile)).first,
    );
  });

  screenshotTest('2_study_notes_glance', (screenshot) => studyAt(screenshot, 'John 1:1', .commentary));

  screenshotTest(
    '2_study_notes_panel',
    (screenshot) => pumpWithPanel(screenshot, at('Galatians 3', studyPanels: [.commentary(type: .matthewHenry)])),
  );

  screenshotTest('2_study_notes_dictionary', (screenshot) async {
    await screenshot.pumpApp(at('Genesis 8'));
    final dictionary = await screenshot.load(articlesProvider(collection: .dictionary).future);
    await screenshot.run(
      () => ArticleSheet.show(
        screenshot.context,
        collection: ArticleCollection.dictionary,
        article: dictionary.firstWhere((article) => article.title == 'Ararat'),
        onNavigateToVerseSelection: (_) {},
      ),
    );
  });

  screenshotTest('3_highlight_styles', (screenshot) async {
    await screenshot.pumpApp(at('Genesis 1'));
    await push(screenshot, HighlightStylesPage());
  });

  screenshotTest('3_annotations', (screenshot) async {
    await screenshot.pumpApp(at('Genesis 1'));
    await push(screenshot, AnnotationsPage(initialNotebookId: (sundaySermons.id,)));
    await screenshot.settle(rounds: 20);
  });

  screenshotTest('3_annotated_reader', (screenshot) => screenshot.pumpApp(at('Genesis 1')));

  screenshotTest(
    '4_resources_people',
    (screenshot) => studyAt(
      screenshot,
      'Genesis 3:15',
      .linkedResources,
      user: at('Genesis 3', resourceOrder: [.people, .themes, .creeds, .dictionary, .maps, .videos]),
    ),
  );

  screenshotTest('4_resources_media', (screenshot) async {
    await studyAt(
      screenshot,
      'Exodus 14:21',
      .linkedResources,
      user: at('Exodus 14', resourceOrder: [.videos, .maps, .dictionary, .people, .themes, .creeds]),
    );
    await screenshot.settle(rounds: 30);
  });

  screenshotTest('5_plans_find', (screenshot) async {
    await screenshot.pumpApp(at('Genesis 1'));
    await push(screenshot, BiblePlanSearchPage());
  });

  screenshotTest('5_plans_progress', (screenshot) async {
    await screenshot.pumpApp(at('Genesis 1'));
    await push(screenshot, BiblePlansPage());
  });

  screenshotTest('5_plans_create', (screenshot) async {
    await screenshot.pumpApp(at('Genesis 1'));
    await push(screenshot, CreateBiblePlanPage());
  });

  screenshotTest('6_search_word', (screenshot) async {
    await screenshot.pumpApp(at('Isaiah 7'));
    await push(screenshot, SearchPage(initialSearch: 'Rezin'));
  });

  screenshotTest('6_search_strongs', (screenshot) async {
    // UI text has no Hebrew fallback without system fonts, so the Strong's search uses a Greek word.
    await screenshot.pumpApp(at('1 John 4'));
    await push(screenshot, SearchPage(initialSearch: 'G26'));
    await screenshot.run(
      () => screenshot.tester.widget<SearchLocationButton>(find.byType(SearchLocationButton)).onBooksSelected({
        BookType.john1,
      }),
    );
  });

  screenshotTest('6_search_reader', (screenshot) async {
    await screenshot.pumpApp(at('2 Kings 15'));
    await screenshot.revealText('Rezin');
    await screenshot.longPressText('Rezin');
    await screenshot.scrollTextAboveToolbar('Rezin');
  });

  screenshotTest('7_cross_references_sheet', (screenshot) => studyAt(screenshot, 'Genesis 1:1', .crossReferences));

  screenshotTest('7_cross_references_preview', (screenshot) async {
    await studyAt(screenshot, 'Genesis 1:1', .crossReferences);
    await screenshot.tap(find.textContaining(RegExp(r'John\s1:1'), findRichText: true).first);
  });

  screenshotTest('8_compare_sheet', (screenshot) => studyAt(screenshot, 'Psalm 23:1', .compare));

  screenshotTest(
    '8_compare_panel',
    (screenshot) => pumpWithPanel(
      screenshot,
      at(
        'Psalm 23',
        studyPanels: [.compare(translation: .oshb)],
      ).withAnnotation(verseAnnotation('Psalm 23:1', promises, age: Duration(days: 2))),
    ),
  );
}
