import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lux_reader_configuration_provider.g.dart';

class PassageSelectionConfiguration {
  final List<Reference> Function(List<Reference> selectedReferences, Reference pressedReference) referencesAfterPress;

  final BibleTextSelection? Function(BibleTextSelection?, bool isNewSelection) textSelectionAfterUpdate;

  final bool Function(
    BuildContext,
    VerseSelection? selectedVerseSelection,
    BibleTextSelection? selectedTextSelection,
    BibleTextSelection pressedTextSelection,
    Function(VerseSelection) onNavigateToVerseSelection,
    Function() clearVerseSelection,
    Function() clearTextSelection,
    Function() markReferencesAction,
  )?
  onLongPress;

  const PassageSelectionConfiguration({
    this.referencesAfterPress = defaultReferencesAfterPress,
    this.textSelectionAfterUpdate = defaultTextSelectionAfterUpdate,
    this.onLongPress,
  });

  static List<Reference> defaultReferencesAfterPress(List<Reference> references, Reference pressedReference) =>
      references.withPressedReference(pressedReference: pressedReference);

  static BibleTextSelection? defaultTextSelectionAfterUpdate(BibleTextSelection? selection, bool isNewSelection) =>
      selection;
}

class LuxReaderConfiguration {
  final BibleTranslation Function(ChapterReference) translationForChapter;
  final BibleParagraphsConfiguration Function(BuildContext, BibleTranslation) paragraphsConfiguration;
  final List<BiblePassageDecoration> Function(BuildContext, ChapterReference, BibleTranslation) decorationsBuilder;

  final List<BibleInlineMarker> Function(
    BuildContext,
    BibleTranslation,
    Reference,
    Verse,
    int verseParagraphOffset,
    Function(VerseSelection)? onNavigateToVerseSelection,
  )?
  markersBuilder;

  final Widget Function(BuildContext, BibleTranslation, Widget child) chapterWrapper;
  final BibleTranslation selectedTranslation;
  final PassageSelectionConfiguration selection;
  final BibleTranslation? fallbackTranslation;
  final VoidCallback? onSwitchToFallback;

  LuxReaderConfiguration({
    required this.translationForChapter,
    required this.selectedTranslation,
    BibleParagraphsConfiguration Function(BuildContext, BibleTranslation)? paragraphsConfiguration,
    List<BiblePassageDecoration> Function(BuildContext, ChapterReference, BibleTranslation)? decorationsBuilder,
    this.markersBuilder,
    Widget Function(BuildContext, BibleTranslation, Widget child)? chapterWrapper,
    this.selection = const PassageSelectionConfiguration(),
    this.fallbackTranslation,
    this.onSwitchToFallback,
  }) : paragraphsConfiguration = paragraphsConfiguration ?? ((_, _) => BibleParagraphsConfiguration()),
       decorationsBuilder = decorationsBuilder ?? ((_, _, _) => []),
       chapterWrapper = chapterWrapper ?? ((_, _, child) => child);
}

@Riverpod(keepAlive: true)
LuxReaderConfiguration luxReaderConfiguration(Ref ref) => throw UnimplementedError();
