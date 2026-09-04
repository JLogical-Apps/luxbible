import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class CopySheet {
  static String getCopyText({
    required String text,
    required bool isTextSelection,
    required BibleTranslation translation,
    required VerseSelection selection,
    required bool useReference,
    required bool useTranslation,
  }) => useReference || useTranslation
      ? [
          '"$text"',
          '(${[
            if (isTextSelection) t.copySheet.textIn,
            [if (useReference) selection.format(), if (useTranslation) translation.title()].join(', '),
          ].join(' ')})',
        ].join('\n')
      : text;

  static Future<void> show(
    BuildContext context, {
    required String text,
    required bool isTextSelection,
    required BibleTranslation translation,
    required VerseSelection selection,
  }) => context.showStyledSheet((context, _) {
    final useReferenceState = useState(true);
    final useReference = useReferenceState.value;

    final useTranslationState = useState(true);
    final useTranslation = useReference ? useTranslationState.value : false;

    final copy = getCopyText(
      text: text,
      isTextSelection: isTextSelection,
      translation: translation,
      selection: selection,
      useReference: useReference,
      useTranslation: useTranslation,
    );

    return StyledSheet(
      title: t.common.copy.toText(),
      children: [
        StyledSection.child(
          title: t.copySheet.preview.toText(),
          padding: .only(top: 24),
          child: Text(copy, style: context.textStyle.paragraphMd),
        ),
        StyledSection(
          title: t.copySheet.citation.toText(),
          children: [
            if (!translation.isLocal)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16) + .only(bottom: 8),
                child: StyledBanner(message: t.copySheet.citationRequired.toText()),
              ),
            StyledListItem.switchControl(
              title: t.copySheet.includeReference.toText(),
              isEnabled: translation.isLocal,
              isSelected: useReference,
              onSelected: translation.isLocal ? (newValue) => useReferenceState.value = newValue : null,
            ),
            StyledListItem.switchControl(
              title: t.copySheet.includeTranslation.toText(),
              isEnabled: translation.isLocal && useReference,
              isSelected: useTranslation,
              onSelected: translation.isLocal && useReference
                  ? (newValue) => useTranslationState.value = newValue
                  : null,
            ),
          ],
        ),
      ],
      buttonsBuilder: (context) => [
        StyledRectButton.primary(
          label: t.common.copy.toText(),
          onPressed: () {
            context.showStyledSnackbar(
              message: t.selectionActions.copiedVerses(reference: selection.format()).toText(),
            );

            Clipboard.setData(ClipboardData(text: copy));
            context.pop();
          },
        ),
      ],
    );
  });
}
