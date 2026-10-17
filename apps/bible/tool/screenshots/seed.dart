import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/highlight_style.dart';
import 'package:bible/models/notebook.dart';
import 'package:bible/models/user/migration.dart';
import 'package:bible/models/user/onboarding_step.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/models/article_collection.dart';
import 'package:bible/models/whats_new_highlight.dart';
import 'package:bible/providers/articles_provider.dart';
import 'package:bible/providers/bible_maps_provider.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/creeds_provider.dart';
import 'package:bible/providers/videos_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';

final sundaySermons = Notebook(id: 'sunday-sermons', name: 'Sunday Sermons', color: .red);
final romansStudy = Notebook(id: 'romans-study', name: 'Romans Study', color: .blue);
final prayerJournal = Notebook(id: 'prayer-journal', name: 'Prayer Journal', color: .green);

final unity = HighlightStyle(color: .violet, type: .highlight);
final underline = HighlightStyle(color: .stone, type: .straightUnderline);
final faith = HighlightStyle(color: .yellow, type: .straightUnderline);
final godsWill = HighlightStyle(color: .blue, type: .wavyUnderline);
final pride = HighlightStyle(color: .orange, type: .highlight);
final application = HighlightStyle(color: .green, type: .highlight);
final important = HighlightStyle(color: .red, type: .wavyUnderline);
final prophecy = HighlightStyle(color: .red, type: .highlight);
final promises = HighlightStyle(color: .yellow, type: .highlight);
final christ = HighlightStyle(color: .blue, type: .highlight);
final creation = HighlightStyle(color: .blue, type: .straightUnderline);

final highlightStyles = [
  (unity, 'Unity'),
  (underline, 'Underline'),
  (faith, 'Faith'),
  (godsWill, "God's Will"),
  (pride, 'Pride'),
  (application, 'Application'),
  (important, 'Important'),
  (prophecy, 'Prophecy'),
  (promises, 'Promises'),
  (christ, 'Christ'),
  (creation, 'Creation'),
];

final backgroundPassages = [
  'Psalm 1:1',
  'Psalm 19:1',
  'Psalm 27:1',
  'Psalm 46:10',
  'Psalm 51:10',
  'Psalm 119:105',
  'Psalm 139:14',
  'Proverbs 3:5',
  'Proverbs 3:6',
  'Proverbs 16:18',
  'Proverbs 22:6',
  'Isaiah 7:14',
  'Isaiah 9:6',
  'Isaiah 40:31',
  'Isaiah 53:5',
  'Isaiah 53:6',
  'Jeremiah 29:11',
  'Micah 5:2',
  'Micah 6:8',
  'Matthew 5:3',
  'Matthew 5:9',
  'Matthew 6:33',
  'Matthew 11:28',
  'Matthew 22:37',
  'Matthew 28:19',
  'Mark 10:45',
  'Luke 1:37',
  'Luke 2:11',
  'John 3:16',
  'John 8:12',
  'John 10:11',
  'John 11:25',
  'John 14:6',
  'John 15:5',
  'John 17:21',
  'Acts 1:8',
  'Acts 2:42',
  'Acts 4:32',
  'Romans 1:16',
  'Romans 3:23',
  'Romans 5:8',
  'Romans 6:23',
  'Romans 8:1',
  'Romans 8:28',
  'Romans 10:9',
  'Romans 12:1',
  'Romans 12:2',
  'Romans 12:16',
  '1 Corinthians 1:10',
  '1 Corinthians 10:13',
  '1 Corinthians 12:12',
  '1 Corinthians 13:4',
  '2 Corinthians 5:17',
  'Galatians 2:20',
  'Galatians 3:28',
  'Galatians 5:22',
  'Ephesians 4:3',
  'Ephesians 4:13',
  'Ephesians 6:11',
  'Philippians 2:2',
  'Philippians 2:3',
  'Philippians 4:6',
  'Philippians 4:13',
  'Colossians 3:14',
  'Colossians 3:23',
  '2 Timothy 3:16',
  'Hebrews 4:12',
  'Hebrews 11:1',
  'Hebrews 11:6',
  'Hebrews 12:2',
  'James 1:5',
  'James 1:22',
  'James 4:6',
  '1 Peter 3:8',
  '1 Peter 5:5',
  '1 John 1:9',
  '1 John 4:19',
  'Revelation 3:20',
  'Revelation 21:4',
];

Reference firstReference(String passage) => VerseSelection.parse(passage).references.first;

ChapterPosition positionOf(String passage) => ChapterPosition(reference: firstReference(passage).toChapterReference());

Annotation verseAnnotation(
  String passage,
  HighlightStyle style, {
  required Duration age,
  Notebook? notebook,
  String note = '',
}) => Annotation(
  selection: .verses(verseSelection: VerseSelection.fromReferences(VerseSelection.parse(passage).references)),
  style: style,
  note: note,
  notebookId: notebook?.id,
  createdAt: DateTime.now().subtract(age),
);

Future<Annotation> phraseAnnotation(
  String passage,
  String phrase,
  HighlightStyle style, {
  required Duration age,
  Notebook? notebook,
  String note = '',
  int occurrence = 1,
}) async {
  final reference = firstReference(passage);
  final chapter = await ref.read(
    chapterProvider(translation: .bsb, chapterReference: reference.toChapterReference()).future,
  );
  final text = chapter.getVerseByReference(reference)!.text;
  final start = phrase.allMatches(text).elementAtOrNull(occurrence - 1)?.start;
  if (start == null) throw ArgumentError('"$phrase" is not in $passage $occurrence times: $text');

  BibleTextSelectionWordAnchor anchor(int offset) =>
      BibleTextSelectionWordAnchor.fromReference(reference: reference, characterOffset: offset);

  return Annotation(
    selection: .text(
      textSelection: BibleTextSelection(
        start: anchor(start),
        end: anchor(start + phrase.length - 1),
        translation: .bsb,
      ),
    ),
    style: style,
    note: note,
    notebookId: notebook?.id,
    createdAt: DateTime.now().subtract(age),
  );
}

BiblePlanProgress planProgress(String planId, {required int completedDays}) {
  final plan = ref.read(includedBiblePlansProvider)[planId]!;
  return BiblePlanProgress(
    instanceId: planId,
    days: plan.days
        .mapIndexed(
          (index, _) => index < completedDays ? BiblePlanDayProgress.complete() : BiblePlanDayProgress.incomplete(),
        )
        .toList(),
  );
}

Future<User> buildDemoUser() async {
  final featuredAnnotations = await Future.wait([
    Future.value(verseAnnotation('Genesis 1:1', unity, age: Duration(days: 3), notebook: sundaySermons)),
    phraseAnnotation(
      'Genesis 1:2',
      'Spirit of God',
      godsWill,
      age: Duration(minutes: 6),
      notebook: sundaySermons,
      note: 'The Spirit is present from the very first page. Compare John 1:1-3.',
    ),
    phraseAnnotation(
      'Genesis 1:3',
      'Let there be light',
      faith,
      age: Duration(minutes: 52),
      notebook: sundaySermons,
      note: 'God speaks and it is. His word does what it says.',
    ),
    Future.value(verseAnnotation('Genesis 1:5', pride, age: Duration(days: 3))),
    phraseAnnotation('Genesis 1:8', '“sky.”', godsWill, age: Duration(days: 3)),
    Future.value(verseAnnotation('Genesis 1:9', creation, age: Duration(days: 3))),
    phraseAnnotation('Genesis 1:10', 'And God saw that it was good.', application, age: Duration(days: 3)),
    Future.value(
      verseAnnotation(
        'Romans 8:29',
        underline,
        age: Duration(minutes: 37),
        notebook: sundaySermons,
        note: 'Predestined to be conformed to the image of His Son.',
      ),
    ),
    Future.value(verseAnnotation('Ephesians 2:8-9', unity, age: Duration(hours: 5), notebook: sundaySermons)),
    Future.value(verseAnnotation('John 1:5', promises, age: Duration(days: 4))),
    phraseAnnotation(
      'John 1:7',
      'so that through him everyone might believe',
      application,
      age: Duration(days: 4),
      note: "John's whole purpose was to point beyond himself.",
    ),
    phraseAnnotation('John 1:9', 'The true Light', christ, age: Duration(days: 4), note: 'Compare John 8:12.'),
    Future.value(verseAnnotation('Romans 8:28', faith, age: Duration(days: 9), notebook: romansStudy)),
    Future.value(verseAnnotation('Philippians 4:6', application, age: Duration(days: 12), notebook: prayerJournal)),
  ]);

  final backgroundAnnotations = backgroundPassages.mapIndexed(
    (index, passage) => verseAnnotation(
      passage,
      highlightStyles[index % highlightStyles.length].$1,
      age: Duration(days: 14 + index * 3),
      notebook: [sundaySermons, romansStudy, prayerJournal, null][index % 4],
    ),
  );

  return User(
    translation: .bsb,
    theme: ThemeMode.dark,
    latestMigration: Migration.values.last,
    // Otherwise the toolbar's overflow button shows a notification dot.
    lastSeenWhatsNewVersion: WhatsNewHighlight.releaseVersion,
    startedOnboardingTours: OnboardingTour.values.toSet(),
    commentaries: [.tyndale, .matthewHenry, .jamiesonFaussetBrown, .calvin],
    compareBibles: [.bsb, .kjv, .web, .asv],
    notebooks: [sundaySermons, romansStudy, prayerJournal],
    highlightStyleOverrides: highlightStyles,
    annotations: [...featuredAnnotations, ...backgroundAnnotations],
    planProgressById: {
      'esv_through_the_bible': planProgress('esv_through_the_bible', completedDays: 196),
      'esv_psalms_and_wisdom_literature': planProgress('esv_psalms_and_wisdom_literature', completedDays: 202),
      'navigators_5x5x5_nt': planProgress('navigators_5x5x5_nt', completedDays: 24),
    },
  );
}

final scenePassages = [
  '2 Kings 15',
  'Genesis 1',
  'Genesis 3',
  'Genesis 8',
  'Exodus 14',
  'Psalm 23',
  'Isaiah 7',
  'John 1',
  'Galatians 3',
  '1 John 4',
];

// A cached load that starts inside one scene's fake clock never completes in the next, so shared data loads up front.
Future<void> preload(User user) => Future.wait([
  ...ArticleCollection.values.map((collection) => ref.read(articlesProvider(collection: collection).future)),
  ref.read(bibleMapsProvider.future),
  ref.read(creedsProvider.future),
  ref.read(videoCollectionsProvider.future),
  ...{
    ...scenePassages.map((passage) => firstReference(passage).toChapterReference()),
    ...user.annotations.map((annotation) => annotation.selection.startingReference.toChapterReference()),
  }.map((chapter) => ref.read(chapterProvider(translation: .bsb, chapterReference: chapter).future)),
  ...{...user.compareBibles!, BibleTranslation.oshb}.map(
    (translation) => ref.read(
      chapterProvider(
        translation: translation,
        chapterReference: firstReference('Psalm 23').toChapterReference(),
      ).future,
    ),
  ),
]);
