import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

part 'activity_plan.freezed.dart';
part 'activity_plan.g.dart';

@freezed
sealed class ActivityPlan with _$ActivityPlan {
  const ActivityPlan._();

  const factory ActivityPlan.phraseRead() = PhraseReadActivityPlan;
  const factory ActivityPlan.readContext() = ReadContextActivityPlan;
  const factory ActivityPlan.phraseSelection() = PhraseSelectionActivityPlan;
  const factory ActivityPlan.wordSelection() = WordSelectionActivityPlan;
  const factory ActivityPlan.wordType() = WordTypeActivityPlan;
  const factory ActivityPlan.referenceSelection() = ReferenceSelectionActivityPlan;
  const factory ActivityPlan.referenceType() = ReferenceTypeActivityPlan;

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
    readContext || referenceSelection || referenceType => false,
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
    wordType => 'Type the words in the blanks.',
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
