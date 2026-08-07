import 'package:bible/ui/widgets/testament_icon.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BibleTile extends StatelessWidget {
  final BibleTranslation translation;
  final Widget? trailing;

  final Function()? onPressedOverride;
  final bool isEnabled;

  const BibleTile({super.key, required this.translation, this.trailing, this.onPressedOverride, this.isEnabled = true});

  @override
  Widget build(BuildContext context) => StyledListItem(
    title: translation.title().toText(),
    subtitle: translation.fullName().toText(),
    thirdLine: translation.isOnline || translation.isStudy || translation.hasAudioBible || translation.testament != null
        ? Padding(
            padding: .only(top: 4),
            child: Row(
              spacing: 4,
              children: [
                if (translation.isOnline)
                  StyledTag.sm(
                    child: t.bibleDetails.onlineOnly.toText(),
                    leading: Symbols.cloud.toIcon(),
                    colorBuilder: ColorBuilder((colors) => colors.blue.tertiary),
                  ),
                if (translation.isStudy)
                  StyledTag.sm(
                    child: t.bibleDetails.studyBible.toText(),
                    leading: Symbols.school.toIcon(),
                    colorBuilder: ColorBuilder((colors) => colors.green.tertiary),
                  ),
                if (translation.hasAudioBible)
                  StyledTag.sm(
                    child: t.labels.audioBible.toText(),
                    leading: Symbols.headphones.toIcon(),
                    colorBuilder: ColorBuilder((colors) => colors.violet.tertiary),
                  ),
                if (translation.testament case final testament?)
                  StyledTag.sm(
                    child: translation.getTestamentTitle().toText(),
                    leading: TestamentIcon(testament: testament),
                  ),
              ],
            ),
          )
        : null,
    trailing: trailing,
    onPressed: isEnabled ? onPressedOverride ?? () => showInfo(context) : null,
  );

  Future<void> showInfo(BuildContext context) => context.showStyledDialog(
    (context) => StyledDialog.confirm(
      title: translation.fullName().toText(),
      bodyPadding: .zero,
      body: StyledList(
        children: [
          translation.isOnline
              ? StyledListItem(
                  leading: Symbols.cloud.toIcon(),
                  title: t.bibleDetails.onlineOnly.toText(),
                  subtitle: t.bibleDetails.onlineDescription(source: translation.onlineSourceName).toText(),
                )
              : StyledListItem(
                  leading: Symbols.book_4.toIcon(),
                  title: t.bibleDetails.onDevice.toText(),
                  subtitle: t.bibleDetails.onDeviceDescription.toText(),
                ),
          translation.isStudy
              ? StyledListItem(
                  leading: Symbols.school.toIcon(),
                  title: t.bibleDetails.studyBible.toText(),
                  subtitle: t.bibleDetails.studyBibleDescription.toText(),
                )
              : StyledListItem(
                  leading: Symbols.auto_stories.toIcon(),
                  title: t.bibleDetails.readingBible.toText(),
                  subtitle: t.bibleDetails.readingBibleDescription.toText(),
                ),
          StyledListItem(
            leading: TestamentIcon(testament: translation.testament),
            title: translation.getTestamentTitle().toText(),
            subtitle: translation.getTestamentDescription().toText(),
          ),
          if (translation.hasNativeHeadings)
            StyledListItem(
              title: t.bibleDetails.nativeHeadings.toText(),
              subtitle: t.bibleDetails.nativeHeadingsDescription.toText(),
              leading: Symbols.title.toIcon(),
            )
          else if (translation.hasSyntheticHeadings)
            StyledListItem(
              title: t.bibleDetails.syntheticHeadings.toText(),
              subtitle: t.bibleDetails.syntheticHeadingsDescription.toText(),
              leading: Symbols.labs.toIcon(),
            )
          else
            StyledListItem(
              title: t.bibleDetails.noHeadings.toText(),
              subtitle: t.bibleDetails.noHeadingsDescription.toText(),
              leading: Symbols.format_clear.toIcon(),
            ),
          StyledListItem(
            title: t.labels.audioBible.toText(),
            subtitle: t.bibleDetails.audioSupportDescription.toText(),
            trailing: StyledSwitch(isSelected: translation.hasAudioBible, isEnabled: true),
          ),
          StyledListItem(
            trailing: StyledSwitch(isSelected: translation.hasRedLetters, isEnabled: true),
            title: t.bibleDetails.redLetters.toText(),
            subtitle: t.bibleDetails.redLettersDescription.toText(),
          ),
          StyledListItem(
            trailing: StyledSwitch(isSelected: translation.hasFootnotes, isEnabled: true),
            title: t.labels.footnotes.toText(),
            subtitle: t.bibleDetails.footnotesDescription.toText(),
          ),
          StyledListItem(
            trailing: StyledSwitch(isSelected: translation.hasParagraphs, isEnabled: true),
            title: t.labels.paragraphs.toText(),
            subtitle: t.bibleDetails.paragraphsDescription.toText(),
          ),
        ],
      ),
    ),
  );
}
