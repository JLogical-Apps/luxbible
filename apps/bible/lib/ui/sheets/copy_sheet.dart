import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class CopySheet {
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

    final copy = useReference || useTranslation
        ? [
            '"$text"',
            '(${[
              if (isTextSelection) 'Text in',
              [if (useReference) selection.format(), if (useTranslation) translation.title()].join(', '),
            ].join(' ')})',
          ].join('\n')
        : text;

    return StyledSheet(
      title: 'Copy'.toText(),
      children: [
        StyledSection.child(
          title: 'Preview'.toText(),
          padding: .only(top: 24),
          child: Text(copy, style: context.textStyle.paragraphMd),
        ),
        StyledSection(
          title: 'Citation'.toText(),
          children: [
            if (!translation.isLocal)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16) + .only(bottom: 8),
                child: StyledBanner(message: 'The citation is required for online translations.'.toText()),
              ),
            StyledListItem.switchControl(
              title: 'Include Reference?'.toText(),
              isEnabled: translation.isLocal,
              isSelected: useReference,
              onSelected: translation.isLocal ? (newValue) => useReferenceState.value = newValue : null,
            ),
            StyledListItem.switchControl(
              title: 'Include Translation?'.toText(),
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
          label: 'Copy'.toText(),
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
