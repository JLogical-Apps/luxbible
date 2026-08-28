import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux_core.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

part 'activity_plan.freezed.dart';
part 'activity_plan.g.dart';

@freezed
sealed class ActivityPlan with _$ActivityPlan {
  const ActivityPlan._();

  const factory ActivityPlan.phraseRead({required VerseSelection passage}) = PhraseReadActivityPlan;
  const factory ActivityPlan.readContext({required VerseSelection passage}) = ReadContextActivityPlan;
  const factory ActivityPlan.phraseSelection({required VerseSelection passage}) = PhraseSelectionActivityPlan;
  const factory ActivityPlan.wordSelection({required VerseSelection passage}) = WordSelectionActivityPlan;
  const factory ActivityPlan.wordType({required VerseSelection passage}) = WordTypeActivityPlan;
  const factory ActivityPlan.referenceSelection({required VerseSelection passage}) = ReferenceSelectionActivityPlan;
  const factory ActivityPlan.referenceType({required VerseSelection passage}) = ReferenceTypeActivityPlan;

  factory ActivityPlan.fromType(ActivityPlanType type, {required VerseSelection passage}) => switch (type) {
    .phraseRead => .phraseRead(passage: passage),
    .readContext => .readContext(passage: passage),
    .phraseSelection => .phraseSelection(passage: passage),
    .wordSelection => .wordSelection(passage: passage),
    .wordType => .wordType(passage: passage),
    .referenceSelection => .referenceSelection(passage: passage),
    .referenceType => .referenceType(passage: passage),
  };

  factory ActivityPlan.fromJson(Map<String, dynamic> json) => _$ActivityPlanFromJson(json);
}

enum ActivityPlanType {
  phraseRead,
  readContext,
  phraseSelection,
  wordSelection,
  wordType,
  referenceSelection,
  referenceType;

  bool get isPracticeActivity => switch (this) {
    readContext => false,
    _ => true,
  };

  String title() => switch (this) {
    phraseRead => 'Phrase Read',
    readContext => 'Read Context',
    phraseSelection => 'Phrase Selection',
    wordSelection => 'Word Selection',
    wordType => 'Word Type',
    referenceSelection => 'Reference Selection',
    referenceType => 'Reference Type',
  };

  String description() => switch (this) {
    phraseRead => 'Read the passage in phrases.',
    readContext => 'Read the passage in context',
    phraseSelection => 'Place the correct phrases in the blanks.',
    wordSelection => 'Place the correct words in the blanks.',
    wordType => 'Type the first letter of each word.',
    referenceSelection => 'Select the correct reference.',
    referenceType => 'Type the correct reference.',
  };

  IconData get icon => switch (this) {
    phraseRead => Symbols.segment,
    readContext => Symbols.menu_book,
    phraseSelection => Symbols.view_list,
    wordSelection => Symbols.match_word,
    wordType => Symbols.keyboard,
    referenceSelection => Symbols.link,
    referenceType => Symbols.edit_note,
  };
}
