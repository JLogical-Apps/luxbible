import 'dart:convert';
import 'dart:io';

import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/reference/verse_selection.dart';

void main() {
  for (final type in BiblePlanType.values) {
    final raw =
        jsonDecode(File('source_files/reading_plans/${type.name}.json').readAsStringSync()) as Map<String, dynamic>;
    File('assets/bible_plans/${type.name}.json').writeAsStringSync(
      jsonEncode(
        BiblePlan(
          name: (raw['name'] as String).trim(),
          description: switch (type) {
            .mcheyne =>
              'A classic plan with four short readings a day. You read through the Old Testament once and the New Testament and Psalms twice in a year.',
            .one_year_chronological =>
              'Read the whole Bible in a year, arranged in the order the events actually happened.',
            .esv_through_the_bible => 'Read straight through the whole Bible in a year, from Genesis to Revelation.',
            .esv_gospels_and_epistles =>
              'Spend the year in the New Testament, journeying through the Gospels and the letters of the apostles.',
            .esv_every_day_in_word =>
              'Four readings a day from the Old Testament, New Testament, Psalms, and Proverbs, covering the whole Bible in a year.',
            .esv_literary_study_bible =>
              'Experience the Bible over a year grouped by its literary styles, moving through story, poetry, and letters.',
            .esv_chronicles_and_prophets =>
              'A year that pairs the history in Chronicles with the messages of the Prophets.',
            .esv_pentateuch_and_history_of_israel =>
              'Journey through the five books of Moses and the history of Israel over a year.',
            .esv_psalms_and_wisdom_literature =>
              'Spend the year in the Psalms and wisdom books like Proverbs, Job, and Ecclesiastes.',
            .heartlight_ot_and_nt =>
              'Read through both the Old and New Testaments together, with a passage from each every day.',
            .heartlight_different_topics =>
              'Rotate through a different section of Scripture each day, exploring every book of the Bible over a year.',
            .heartlight_nt_psalms_proverbs =>
              'Read the New Testament alongside Psalms and Proverbs over the course of a year.',
            .navigators_5x5x5_nt =>
              'Read one New Testament chapter a day, five days a week, with room each week to reflect or catch up.',
          },
          days: (raw['data2'] as List).map((day) {
            final references = (day as List)
                .cast<String>()
                .expand(
                  (passage) => VerseSelection.parse(
                    passage,
                    bookToName: {
                      .psalms: 'Psalms',
                      .songOfSolomon: 'Song of Songs',
                      .thessalonians1: '1 Thes',
                      .thessalonians2: '2 Thes',
                      .john1: '1 Joh',
                      .john2: '2 Joh',
                      .john3: '3 Joh',
                      .jude: 'Jud',
                    },
                  ).references,
                )
                .toList();
            return BiblePlanDay(passages: VerseSelection.fromReferences(references).splitByChapter());
          }).toList(),
        ).toJson(),
      ),
    );
  }
}
