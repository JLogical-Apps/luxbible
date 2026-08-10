import 'package:bible/models/user/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';

class BibleSelection {
  final ValueNotifier<List<Reference>> referencesState;
  final ValueNotifier<BibleTextSelection?> textSelectionState;

  BibleSelection({required this.referencesState, required this.textSelectionState});

  List<Reference> get references => referencesState.value;

  VerseSelection? get verseSelection =>
      referencesState.value.isEmpty ? null : VerseSelection.fromReferences(referencesState.value);

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

  void onReferencePressed(Reference reference, {required User user}) {
    if (textSelection != null) {
      textSelectionState.value = null;
    } else {
      referencesState.value = references.withPressedReference(
        pressedReference: reference,
        rangeSelection: user.verseSelection.rangeSelection,
        expandReferences: user.verseSelection.expandToAnnotation ? user.getExpandedReferences : null,
      );
    }
  }

  bool onHandleLongPress(
    BuildContext context, {
    required BibleTextSelection selection,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required User user,
  }) {
    final verseSelection = this.verseSelection;
    final textSelection = this.textSelection;

    if (verseSelection != null && selection.isInVerseSelection(verseSelection)) {
      user.verseSelection.longPressShortcut.onPressed(
        context,
        verseSelection: verseSelection,
        onDeselect: clearVerses,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      );
      return false;
    } else if (textSelection != null && textSelection.intersects(selection)) {
      user.textSelection.longPressShortcut.onPressed(
        context,
        textSelection: textSelection,
        onDeselect: clearText,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      );
      return false;
    }

    return true;
  }

  void onTextSelectionUpdated({
    required BibleTextSelection? selection,
    required bool isNewSelection,
    required User user,
  }) {
    clearVerses();
    textSelectionState.value = isNewSelection && user.textSelection.expandToAnnotation && selection != null
        ? user.getExpandedTextSelection(selection)
        : selection;
  }
}

BibleSelection useBibleSelection() => BibleSelection(referencesState: useState([]), textSelectionState: useState(null));
