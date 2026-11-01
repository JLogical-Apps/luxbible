import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';

class PassageSelectionController {
  final ValueNotifier<List<Reference>> referencesState;
  final ValueNotifier<BibleTextSelection?> textSelectionState;
  final ValueNotifier<bool> hasActionBeenPerformedState;
  final PassageSelectionConfiguration configuration;

  PassageSelectionController({
    required this.referencesState,
    required this.textSelectionState,
    required this.hasActionBeenPerformedState,
    required this.configuration,
  });

  List<Reference> get references => referencesState.value;
  VerseSelection? get verseSelection => references.isEmpty ? null : VerseSelection.fromReferences(references);
  BibleTextSelection? get textSelection => textSelectionState.value;
  bool get hasSelection => references.isNotEmpty || textSelection != null;
  bool get hasActionBeenPerformed => hasActionBeenPerformedState.value;

  PassageSelection get selection => PassageSelection(references: references, textSelection: textSelection);

  void selectReferences(List<Reference> references) {
    referencesState.value = references;
    hasActionBeenPerformedState.value = false;
    textSelectionState.value = null;
  }

  void clearVerses() {
    referencesState.value = [];
    hasActionBeenPerformedState.value = false;
  }

  void clearText() => textSelectionState.value = null;

  void clear() {
    clearVerses();
    clearText();
  }

  void onReferencePressed(Reference reference, {required List<Paragraph> paragraphs}) {
    if (textSelection != null || hasActionBeenPerformedState.value) {
      clear();
      return;
    }

    // Selection rules see a verse bridge as its first verse, so pressing a selected bridge deselects all of it.
    bool isInPassage(Reference other) => other.toChapterReference() == reference.toChapterReference();

    final bridgeStartReferences = references
        .map((selected) => isInPassage(selected) ? paragraphs.getBridgeStartReference(selected) : selected)
        .distinct
        .toList();

    referencesState.value = configuration
        .referencesAfterPress(bridgeStartReferences, reference)
        .expand((selected) => isInPassage(selected) ? paragraphs.getBridgeReferences(selected) : [selected])
        .distinct
        .toList();
  }

  void markReferencesAction() {
    if (references.isNotEmpty) hasActionBeenPerformedState.value = true;
  }

  bool onTextSelectionLongPressed(
    BuildContext context,
    BibleTextSelection selection,
    Function(VerseSelection) onNavigateToVerseSelection,
  ) =>
      configuration.onLongPress?.call(
        context,
        verseSelection,
        textSelection,
        selection,
        onNavigateToVerseSelection,
        clearVerses,
        clearText,
        markReferencesAction,
      ) ??
      true;

  void onTextSelectionUpdated(BibleTextSelection? selection, bool isNewSelection) {
    clearVerses();
    textSelectionState.value = configuration.textSelectionAfterUpdate(selection, isNewSelection);
  }
}

class PassageSelection {
  final List<Reference> references;
  final BibleTextSelection? textSelection;

  const PassageSelection({required this.references, required this.textSelection});

  VerseSelection? get verseSelection => references.isEmpty ? null : VerseSelection.fromReferences(references);
}

PassageSelectionController usePassageSelectionController(PassageSelectionConfiguration configuration) =>
    PassageSelectionController(
      referencesState: useState([]),
      textSelectionState: useState(null),
      hasActionBeenPerformedState: useState(false),
      configuration: configuration,
    );
