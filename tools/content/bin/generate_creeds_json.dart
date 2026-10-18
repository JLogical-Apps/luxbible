import 'dart:convert';
import 'dart:io';

import 'package:bible/models/creed.dart';
import 'package:bible/models/rich_content.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:lux_content_tools/repository_paths.dart';
import 'package:utils_core/utils_core.dart';

void main() {
  final creeds = getJsonFiles(sourceDirectory('creeds')).map(getCreed).toList();
  writeCreeds('creeds/creeds.json', creeds);

  final creedById = creeds.mapToMap((creed) => MapEntry(creed.id, creed));
  sourceDirectory('creeds/translations').listSync().whereType<Directory>().forEach(
    (directory) => writeCreeds(
      'creeds/creeds_${directory.uri.pathSegments.lastWhere((segment) => segment.isNotEmpty)}.json',
      getJsonFiles(directory).map((file) => getTranslatedCreed(file, creedById: creedById)).toList(),
    ),
  );
}

List<File> getJsonFiles(Directory directory) => directory
    .listSync()
    .whereType<File>()
    .where((file) => file.path.endsWith('.json'))
    .sortedBy((file) => file.path)
    .toList();

void writeCreeds(String path, List<Creed> creeds) => appAssetFile(path, app: .bible)
  ..parent.createSync(recursive: true)
  ..writeAsStringSync(jsonEncode(creeds.map((creed) => creed.toJson()).toList()));

String getId(File file) => file.uri.pathSegments.last.replaceFirst('.json', '');

// A translation keeps its English document's year and type, and each translated item takes the Scripture proofs of the
// English item in the same position, so a translation of a document with proofs must keep its numbering.
Creed getTranslatedCreed(File file, {required Map<String, Creed> creedById}) {
  final id = getId(file);
  final creed = creedById[id] ?? (throw FormatException('No creed matches the translation `${file.path}`.'));
  final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final chapters = (json['chapters'] as List)
      .cast<Map<String, dynamic>>()
      .mapIndexed(
        (chapterIndex, chapter) => CreedChapter(
          number: chapter['number'],
          title: chapter['title'],
          items: (chapter['items'] as List)
              .cast<Map<String, dynamic>>()
              .mapIndexed(
                (itemIndex, item) => CreedItem(
                  number: item['number'],
                  title: item['title'],
                  body: getParagraphs((item['body'] as List).join('\n')),
                  passages:
                      creed.chapters.elementAtOrNull(chapterIndex)?.items.elementAtOrNull(itemIndex)?.passages ?? [],
                ),
              )
              .toList(),
        ),
      )
      .toList();

  final unmatchedItems = creed.chapters.expandIndexed(
    (chapterIndex, chapter) => chapter.items.whereIndexed(
      (itemIndex, item) =>
          item.passages.isNotEmpty &&
          chapters.elementAtOrNull(chapterIndex)?.items.elementAtOrNull(itemIndex)?.number != item.number,
    ),
  );
  if (unmatchedItems.isNotEmpty) {
    throw FormatException('The translation `${file.path}` has no item numbered ${unmatchedItems.first.number}.');
  }

  return creed.copyWith(
    title: json['title'],
    authors: (json['authors'] as List? ?? creed.authors).cast<String>(),
    source: json['source'],
    chapters: chapters,
  );
}

Creed getCreed(File file) {
  final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final metadata = json['Metadata'] as Map<String, dynamic>;
  final data = json['Data'];
  final id = getId(file);

  return Creed(
    id: id,
    title: metadata['Title'],
    year: metadata['Year'],
    authors: (metadata['Authors'] as List).cast<String>(),
    type: switch (metadata['CreedFormat']) {
      'Creed' => .creed,
      'Canon' || 'Confession' => .confession,
      'Catechism' || 'HenrysCatechism' => .catechism,
      final other => throw FormatException('Unknown format `$other` in `$id`.'),
    },
    chapters: switch (metadata['CreedFormat']) {
      'Creed' => [
        CreedChapter(
          items: [
            CreedItem(
              body: getParagraphs(data['Content']),
              passages: getPassages(data, id: id),
            ),
          ],
        ),
      ],
      'Catechism' => [
        CreedChapter(
          items: (data as List)
              .map(
                (question) => CreedItem(
                  number: '${question['Number']}',
                  title: question['Question'],
                  body: getParagraphs(question['Answer']),
                  passages: getPassages(question, id: id),
                ),
              )
              .toList(),
        ),
      ],
      'HenrysCatechism' => [CreedChapter(items: getExpandedCatechismItems((data as List).cast()))],
      'Confession' =>
        (data as List)
            .map(
              (chapter) => CreedChapter(
                number: chapter['Chapter'],
                title: chapter['Title'],
                items: (chapter['Sections'] as List)
                    .map(
                      (section) => CreedItem(
                        number: section['Section'],
                        body: getParagraphs(section['Content']),
                        passages: getPassages(section, id: id),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      'Canon' => [CreedChapter(items: (data as List).map((article) => getCanonItem(article, id: id)).toList())],
      final other => throw FormatException('Unknown format `$other` in `$id`.'),
    },
  );
}

// Labels such as "Canon 1" or "Art. I" already number the article, so they become the title on their own.
CreedItem getCanonItem(Map<String, dynamic> article, {required String id}) {
  final number = article['Article'] as String?;
  final title = article['Title'] as String;
  final label = switch (title) {
    _ when RegExp(r'^[IVXLC]+$').hasMatch(title) => 'Article $title',
    _ when RegExp(r'^(Canon|Thesis|Article) \S+$').hasMatch(title) => title,
    _ when RegExp(r'^Art\. \S+$').hasMatch(title) => title.replaceFirst('Art.', 'Article'),
    _ => null,
  };

  return CreedItem(
    number: label == null ? number : null,
    title: label ?? getTitleCased(title.replaceFirst(RegExp(r'^[IVXLC]+\.\s+'), '')),
    body: getParagraphs(article['Content']),
    passages: getPassages(article, id: id),
  );
}

// Expositions of the Shorter Catechism follow each question with numbered sub-questions. Entries numbered "?" only
// continue the previous question's sub-questions.
List<CreedItem> getExpandedCatechismItems(List<Map<String, dynamic>> questions) => questions
    .splitBefore((question) => question['Number'] != '?')
    .map(
      (group) => CreedItem(
        number: group.first['Number'],
        title: group.first['Question'],
        body: [
          ...getParagraphs(group.first['Answer']),
          ...group
              .expand((question) => (question['SubQuestions'] as List? ?? []).cast<Map<String, dynamic>>())
              .expand(
                (subQuestion) => [
                  RichContent.paragraph(
                    text: Markdown.fromPlainText('${subQuestion['Number']}. ${subQuestion['Question']}'),
                    style: .bold,
                  ),
                  ...getParagraphs(subQuestion['Answer']),
                ],
              ),
        ],
      ),
    )
    .toList();

List<RichContent> getParagraphs(String text) => text
    .split('\n')
    .map((paragraph) => paragraph.trim())
    .where((paragraph) => paragraph.isNotEmpty)
    .map((paragraph) => RichContent.paragraph(text: Markdown.fromPlainText(paragraph)))
    .toList();

List<VerseSelection> getPassages(Map<String, dynamic> json, {required String id}) => (json['Proofs'] as List? ?? [])
    .sortedBy<num>((proof) => proof['Id'])
    .expand((proof) => proof['References'] as List)
    .cast<String>()
    .expand((reference) => getReferencePassages(reference, id: id))
    .toSet()
    .toList();

// A reference can list several passages, as in `Gen.3.6-Gen.3.8,Gen.3.13`. Consecutive passages in one chapter stay
// together as a single selection.
List<VerseSelection> getReferencePassages(String reference, {required String id}) => reference
    .split(',')
    .map((part) => getPassage(part, id: id))
    .splitBetween(
      (previous, next) =>
          previous.spans.last.endReference.toChapterReference() != next.spans.first.startReference.toChapterReference(),
    )
    .map((passages) => VerseSelection(spans: passages.expand((passage) => passage.spans).toList()))
    .toList();

VerseSelection getPassage(String reference, {required String id}) => VerseSelection.isOsisId(reference)
    ? VerseSelection.fromOsisId(reference)
    : throw FormatException('Invalid reference `$reference` in `$id`.');

const minorWords = {'a', 'an', 'and', 'as', 'at', 'by', 'for', 'from', 'in', 'into', 'of', 'on', 'or', 'the', 'to'};

String getTitleCased(String title) => title != title.toUpperCase()
    ? title
    : title
          .toLowerCase()
          .split(' ')
          .mapIndexed(
            (index, word) => index > 0 && minorWords.contains(word)
                ? word
                : word.replaceFirstMapped(RegExp(r'[a-z]'), (match) => match[0]!.toUpperCase()),
          )
          .join(' ');
