import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/testament_icon.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

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
                    child: 'Online Only'.toText(),
                    leading: Symbols.cloud.toIcon(),
                    colorBuilder: ColorBuilder((colors) => colors.blue.tertiary),
                  ),
                if (translation.isStudy)
                  StyledTag.sm(
                    child: 'Study Bible'.toText(),
                    leading: Symbols.school.toIcon(),
                    colorBuilder: ColorBuilder((colors) => colors.green.tertiary),
                  ),
                if (translation.hasAudioBible)
                  StyledTag.sm(
                    child: 'Audio Bible'.toText(),
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
                  title: 'Online Only'.toText(),
                  subtitle:
                      'This Bible is streamed from ${translation.onlineSourceName}, so it requires an internet connection.'
                          .toText(),
                )
              : StyledListItem(
                  leading: Symbols.book_4.toIcon(),
                  title: 'On Device'.toText(),
                  subtitle: 'This Bible is downloaded to your device, so you can search it and read offline.'.toText(),
                ),
          translation.isStudy
              ? StyledListItem(
                  leading: Symbols.school.toIcon(),
                  title: 'Study Bible'.toText(),
                  subtitle:
                      'Includes interlinear and morphology data. Long-press any word while reading to see the original Greek or Hebrew.'
                          .toText(),
                )
              : StyledListItem(
                  leading: Symbols.auto_stories.toIcon(),
                  title: 'Reading Bible'.toText(),
                  subtitle: 'Doesn\'t include interlinear or morphology data.'.toText(),
                ),
          StyledListItem(
            leading: TestamentIcon(testament: translation.testament),
            title: translation.getTestamentTitle().toText(),
            subtitle: translation.getTestamentDescription().toText(),
          ),
          if (translation.hasNativeHeadings)
            StyledListItem(
              title: 'Native Headings'.toText(),
              subtitle: 'Headings are included with this Bible.'.toText(),
              leading: Symbols.title.toIcon(),
            )
          else if (translation.hasSyntheticHeadings)
            StyledListItem(
              title: 'Synthetic Headings'.toText(),
              subtitle: 'Headings are synthetically inserted into this Bible from the BSB.'.toText(),
              leading: Symbols.labs.toIcon(),
            )
          else
            StyledListItem(
              title: 'No Headings'.toText(),
              subtitle: 'No headings are included in this Bible.'.toText(),
              leading: Symbols.format_clear.toIcon(),
            ),
          StyledListItem(
            title: 'Audio Bible'.toText(),
            subtitle: 'Whether this Bible includes an Audio Bible'.toText(),
            trailing: StyledSwitch(isSelected: translation.hasAudioBible, isEnabled: true),
          ),
          StyledListItem(
            trailing: StyledSwitch(isSelected: translation.hasRedLetters, isEnabled: true),
            title: 'Red Letters'.toText(),
            subtitle: 'Whether Red Letters are supported in this Bible.'.toText(),
          ),
          StyledListItem(
            trailing: StyledSwitch(isSelected: translation.hasFootnotes, isEnabled: true),
            title: 'Footnotes'.toText(),
            subtitle: 'Whether this Bible includes footnotes.'.toText(),
          ),
          StyledListItem(
            trailing: StyledSwitch(isSelected: translation.hasParagraphs, isEnabled: true),
            title: 'Paragraphs'.toText(),
            subtitle: 'Whether this Bible includes paragraphs.'.toText(),
          ),
        ],
      ),
    ),
  );
}
