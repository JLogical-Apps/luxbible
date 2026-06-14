import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
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
    thirdLine: Row(
      spacing: 4,
      children: [
        if (translation.isOnline)
          StyledBadge(
            child: 'Online Only'.toText(),
            leading: Symbols.cloud.toIcon(),
            colorBuilder: ColorBuilder((colors) => colors.blue.tertiary),
          ),
        if (translation == .bsb)
          StyledBadge(
            child: 'Study Bible'.toText(),
            leading: Symbols.school.toIcon(),
            colorBuilder: ColorBuilder((colors) => colors.green.tertiary),
          ),
      ],
    ),
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
                      'This translation is streamed from YouVersion Platform, so it requires an internet connection.'
                          .toText(),
                )
              : StyledListItem(
                  leading: Symbols.book_4.toIcon(),
                  title: 'On Device'.toText(),
                  subtitle: 'This translation is downloaded to your device, so you can search it and read offline.'
                      .toText(),
                ),
          translation == .bsb
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
        ],
      ),
    ),
  );
}
