import 'package:bible/models/user/copy_configuration.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
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
    required CopyConfiguration configuration,
  }) => configuration.isReferenceIncluded(translation)
      ? [
          '"$text"',
          '(${[
            if (isTextSelection) t.copySheet.textIn,
            [selection.format(), if (configuration.isTranslationIncluded(translation)) translation.title()].join(', '),
          ].join(' ')})',
        ].join('\n')
      : text;

  static Future<void> show(
    BuildContext context, {
    required String text,
    required bool isTextSelection,
    required BibleTranslation translation,
    required VerseSelection selection,
  }) => context.showStyledSheet((context, ref) {
    final configurationState = useState(ref.read(userProvider).copy);
    final configuration = configurationState.value;

    final copyText = getCopyText(
      text: text,
      isTextSelection: isTextSelection,
      translation: translation,
      selection: selection,
      configuration: configuration,
    );

    return StyledSheet(
      title: t.common.copy.toText(),
      children: [
        StyledSection.child(
          title: t.copySheet.preview.toText(),
          padding: .only(top: 24),
          child: Text(copyText, style: context.textStyle.paragraphMd),
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
              isSelected: configuration.isReferenceIncluded(translation),
              onSelected: translation.isLocal
                  ? (isIncluded) => configurationState.value = configuration.copyWith(includesReference: isIncluded)
                  : null,
            ),
            StyledListItem.switchControl(
              title: t.copySheet.includeTranslation.toText(),
              isEnabled: translation.isLocal && configuration.includesReference,
              isSelected: configuration.isTranslationIncluded(translation),
              onSelected: translation.isLocal && configuration.includesReference
                  ? (isIncluded) => configurationState.value = configuration.copyWith(includesTranslation: isIncluded)
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

            ref.updateUser((user) => user.copyWith(copy: configuration));
            Clipboard.setData(ClipboardData(text: copyText));
            context.pop();
          },
        ),
      ],
    );
  });
}
