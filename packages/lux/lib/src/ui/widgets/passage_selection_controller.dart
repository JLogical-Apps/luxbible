import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';

class PassageSelectionController {
  final ValueNotifier<List<Reference>> referencesState;
  final ValueNotifier<BibleTextSelection?> textSelectionState;
  final PassageSelectionConfiguration configuration;

  PassageSelectionController({
    required this.referencesState,
    required this.textSelectionState,
    required this.configuration,
  });

  List<Reference> get references => referencesState.value;
  VerseSelection? get verseSelection => references.isEmpty ? null : VerseSelection.fromReferences(references);
  BibleTextSelection? get textSelection => textSelectionState.value;
  bool get hasSelection => references.isNotEmpty || textSelection != null;

  void selectReferences(List<Reference> references) {
    referencesState.value = references;
    textSelectionState.value = null;
  }

  void clearVerses() => referencesState.value = [];
  void clearText() => textSelectionState.value = null;

  void clear() {
    clearVerses();
    clearText();
  }

  void onReferencePressed(Reference reference) {
    if (textSelection != null) {
      clearText();
    } else {
      referencesState.value = configuration.referencesAfterPress(references, reference);
    }
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
      ) ??
      true;

  void onTextSelectionUpdated(BibleTextSelection? selection, bool isNewSelection) {
    clearVerses();
    textSelectionState.value = configuration.textSelectionAfterUpdate(selection, isNewSelection);
  }
}

PassageSelectionController usePassageSelection(PassageSelectionConfiguration configuration) =>
    PassageSelectionController(
      referencesState: useState([]),
      textSelectionState: useState(null),
      configuration: configuration,
    );
