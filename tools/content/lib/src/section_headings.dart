import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';

extension SectionHeadingBookExtensions on Book {
  Book withSectionHeadingsFrom(Book source) => copyWith(
    chapters: chapters.mapIndexed((index, chapter) => chapter.withSectionHeadingsFrom(source.chapters[index])).toList(),
  );
}

extension on Chapter {
  Chapter withSectionHeadingsFrom(Chapter source) => Chapter(
    paragraphs: source.paragraphs
        .getSectionHeadingsByVerse(
          // The BSB's s2 headings in Song of Songs name the speaker, which clashes with a translation's own speaker labels.
          types: paragraphs.any((paragraph) => paragraph is SectionParagraph && paragraph.type == .sp)
              ? {.s1}
              : {.s1, .s2},
        )
        .entries
        .fold(paragraphs, (paragraphs, entry) => paragraphs.withSectionHeadingsBefore(entry.key, entry.value)),
  );
}

extension on List<Paragraph> {
  Map<int, List<SectionParagraph>> getSectionHeadingsByVerse({required Set<SectionType> types}) => indexed
      .map(
        (entry) => switch (entry) {
          (final index, SectionParagraph(:final type) && final section) when types.contains(type) =>
            switch (getVerseIntroducedBySectionAt(index)) {
              final verse? => (verse.verseNum, section),
              null => null,
            },
          _ => null,
        },
      )
      .nonNulls
      .groupFoldBy((entry) => entry.$1, (sections, entry) => [...?sections, entry.$2]);

  List<Paragraph> withSectionHeadingsBefore(int verseNum, List<SectionParagraph> headings) {
    final index = getIndexForVerse(verseNum);
    if (index == null) return this;

    final paragraph = this[index] as VersesParagraph;
    final splitIndex = paragraph.verses.indexWhere((verse) => verse.verseNum == verseNum);
    if (splitIndex == 0) {
      // BSB headings sit above a psalm's superscription.
      bool isSuperscription(Paragraph paragraph) => paragraph is SectionParagraph && paragraph.type == .d;
      final insertIndex = index - sublist(0, index).reversed.takeWhile(isSuperscription).length;
      return [...take(insertIndex), ...headings, ...skip(insertIndex)];
    }

    return [
      ...take(index),
      paragraph.copyWith(verses: paragraph.verses.take(splitIndex).toList()),
      ...headings,
      VersesParagraph(type: paragraph.type, verses: paragraph.verses.skip(splitIndex).toList()),
      ...skip(index + 1),
    ];
  }
}
