import 'dart:convert';

import 'package:bible/models/article.dart';
import 'package:bible/models/bible_plan_study_note.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/creed.dart';
import 'package:bible/models/rich_content.dart';
import 'package:bible/models/strong_word_link.dart';
import 'package:bible/models/video.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:utils_core/utils_core.dart';

// A Lux-curated plan is one Markdown file in content/sources/lux_plans. Each `## Day N: Title` section starts with a
// `Passages:` line of OSIS IDs. Its body supports paragraphs, `### ` subheadings, `> ` quotes, and `::: Title` boxes
// closed by `:::`, with the app's inline Markdown for links, bold, and italics. A `### Reflect` section holds the
// day's Reflection Question.
class LuxPlanSource {
  final String name;
  final String color;
  final List<LuxPlanSourceDay> days;

  const LuxPlanSource({required this.name, required this.color, required this.days});

  static final dayHeadingPattern = RegExp(r'^## Day (\d+): (.+)$');

  factory LuxPlanSource.parse(String markdown) {
    final lines = LineSplitter.split(markdown).toList();
    final dayStarts = lines.indexed
        .where((entry) => dayHeadingPattern.hasMatch(entry.$2))
        .map((entry) => entry.$1)
        .toList();
    final header = lines.take(dayStarts.firstOrNull ?? lines.length);

    return LuxPlanSource(
      name: header.firstWhere((line) => line.startsWith('# ')).substring(2).trim(),
      color: header.firstWhere((line) => line.startsWith('Color: ')).substring(7).trim(),
      days: dayStarts
          .mapIndexed(
            (index, start) => LuxPlanSourceDay.parse(
              lines.sublist(start, dayStarts.elementAtOrNull(index + 1) ?? lines.length),
              dayNumber: index + 1,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toPlanJson() => {
    'name': name,
    'days': days.map((day) => {'passages': day.passages}).toList(),
    'color': color,
  };

  List<Map<String, dynamic>> toStudyNotesJson() => days.map((day) => day.note.toJson()).toList();

  List<String> getErrors({required Map<String, bool Function(String link)> linkValidatorsByPrefix}) => days
      .expand(
        (day) => [
          ...day.passages.whereNot(VerseSelection.isOsisId).map((passage) => 'Day ${day.number}: bad passage $passage'),
          ...day.note.body
              .expand((content) => content.texts)
              .expand((text) => text.linkTargets)
              .where((link) => !isValidLink(link, linkValidatorsByPrefix: linkValidatorsByPrefix))
              .map((link) => 'Day ${day.number}: bad link $link'),
        ],
      )
      .toList();

  static bool isValidLink(String link, {required Map<String, bool Function(String link)> linkValidatorsByPrefix}) =>
      switch (linkValidatorsByPrefix.entries.firstWhereOrNull((entry) => link.startsWith(entry.key))) {
        final entry? => entry.value(link),
        null => VerseSelection.isOsisId(link),
      };

  static Map<String, bool Function(String link)> loadLinkValidatorsByPrefix() {
    final creeds = (decodeAsset('creeds/creeds.json') as List)
        .map((creed) => Creed.fromJson(creed as Map<String, dynamic>))
        .toList();
    final videoCollections = (decodeAsset('videos/bibleproject.json') as List)
        .map((collection) => VideoCollection.fromJson(collection as Map<String, dynamic>))
        .toList();
    final strongIds = (decodeAsset('strongs/strongs.json') as List)
        .map((strong) => (strong as Map<String, dynamic>)['i'] as String)
        .toSet();

    return {
      ...{
        Article.dictionaryLinkPrefix: 'dictionary',
        Article.peopleLinkPrefix: 'people',
        Article.themesLinkPrefix: 'themes',
      }.mapValues((prefix, collection) {
        final articleIds = (decodeAsset('$collection/tyndale.json') as List)
            .map((article) => (article as Map<String, dynamic>)['i'] as String)
            .toSet();
        return (link) => articleIds.contains(link.substring(prefix.length));
      }),
      CommentaryType.linkPrefix: (link) => CommentaryType.parseLink(link) != null,
      Creed.linkPrefix: (link) => creeds.getItemReferenceByLink(link) != null,
      Video.linkPrefix: (link) => videoCollections.getVideoByLink(link) != null,
      StrongWordLink.linkPrefix: (link) => isValidStrongWordLink(link, strongIds: strongIds),
    };
  }

  // The app opens the word from the BSB, so it has to be there with morphology.
  static bool isValidStrongWordLink(String link, {required Set<String> strongIds}) {
    final strongLink = StrongWordLink.parse(link);
    if (strongLink == null || !strongIds.contains(strongLink.strongId)) return false;

    final reference = strongLink.reference;
    final book = decodeAsset('translations/bsb/${reference.book.usxCode()}.json') as Map<String, dynamic>;
    final chapter = Chapter.fromJson((book['c'] as List)[reference.chapterNum - 1] as Map<String, dynamic>);
    final verse = chapter.getVerseByReference(reference);
    return verse != null && strongLink.getWord(verse)?.data?.morphology != null;
  }

  static Object? decodeAsset(String path) => jsonDecode(appAssetFile(path, app: .bible).readAsStringSync());
}

class LuxPlanSourceDay {
  final int number;
  final List<String> passages;
  final BiblePlanStudyNote note;

  const LuxPlanSourceDay({required this.number, required this.passages, required this.note});

  factory LuxPlanSourceDay.parse(List<String> lines, {required int dayNumber}) {
    final match = LuxPlanSource.dayHeadingPattern.firstMatch(lines.first)!;
    if (int.parse(match.group(1)!) != dayNumber) {
      throw FormatException('Expected day $dayNumber but found "${lines.first}"');
    }

    final passagesIndex = lines.indexWhere((line) => line.startsWith('Passages: '));
    if (passagesIndex == -1) throw FormatException('Day $dayNumber has no Passages line');

    final bodyLines = lines.sublist(passagesIndex + 1);
    final reflectIndex = bodyLines.indexWhere((line) => line.trim() == reflectHeading);
    final (reflectionQuestion, noteLines) = switch (reflectIndex) {
      -1 => (null, bodyLines),
      _ => parseReflection(bodyLines, reflectIndex: reflectIndex),
    };

    return LuxPlanSourceDay(
      number: dayNumber,
      passages: lines[passagesIndex].substring(10).split(',').map((passage) => passage.trim()).toList(),
      note: BiblePlanStudyNote(
        title: match.group(2)!.trim(),
        body: parseBlocks(noteLines),
        reflectionQuestion: reflectionQuestion,
      ),
    );
  }

  static const reflectHeading = '### Reflect';

  // The Reflect section becomes the day's separate Reflection Question, so it's left out of the note body.
  static (String, List<String>) parseReflection(List<String> lines, {required int reflectIndex}) {
    final sectionEnd = lines.indexWhere((line) => line.startsWith('### '), reflectIndex + 1);
    final sectionLines = lines.sublist(reflectIndex + 1, sectionEnd == -1 ? lines.length : sectionEnd);
    final question = sectionLines.map((line) => line.trim()).where((line) => line.isNotEmpty).join(' ');
    if (question.isEmpty) throw FormatException('Day has an empty Reflect section');

    return (question, [...lines.take(reflectIndex), ...lines.skip(reflectIndex + 1 + sectionLines.length)]);
  }

  static List<RichContent> parseBlocks(List<String> lines) {
    final boxStart = lines.indexWhere((line) => line.startsWith('::: '));
    if (boxStart == -1) return parseParagraphs(lines);

    final boxEnd = lines.indexWhere((line) => line.trim() == ':::', boxStart + 1);
    if (boxEnd == -1) throw FormatException('Unclosed box "${lines[boxStart]}"');

    return [
      ...parseParagraphs(lines.sublist(0, boxStart)),
      RichContent.box(
        title: lines[boxStart].substring(4).trim(),
        content: parseParagraphs(lines.sublist(boxStart + 1, boxEnd)),
      ),
      ...parseBlocks(lines.sublist(boxEnd + 1)),
    ];
  }

  static List<RichContent> parseParagraphs(List<String> lines) => lines
      .splitBetween(
        (first, second) =>
            first.trim().isEmpty != second.trim().isEmpty || [first, second].any((line) => line.startsWith('### ')),
      )
      .where((group) => group.first.trim().isNotEmpty)
      .map(parseParagraph)
      .toList();

  static RichContent parseParagraph(List<String> lines) => switch (lines) {
    [final line] when line.startsWith('### ') => .paragraph(
      text: Markdown(line.substring(4).trim()),
      style: .subheading,
    ),
    _ when lines.every((line) => line.startsWith('>')) => .paragraph(
      text: Markdown(lines.map((line) => line.replaceFirst(RegExp(r'^>\s?'), '').trim()).join(' ')),
      style: .quote,
    ),
    _ => .paragraph(text: Markdown(lines.map((line) => line.trim()).join(' '))),
  };
}
