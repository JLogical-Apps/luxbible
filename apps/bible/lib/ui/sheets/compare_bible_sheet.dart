import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/compare_settings_page.dart';
import 'package:bible/ui/widgets/bible_tile.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n/strings.g.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class CompareBibleSheet {
  static Future<BibleTranslation?> show(BuildContext context, {BibleTranslation? initialBible}) =>
      context.showStyledSheet((context, ref) {
        final user = ref.watch(userProvider);
        return StyledSelectionSheet(
          title: t.studyActions.compare.toText(),
          trailing: StyledCircleButton.md(
            child: Symbols.tune.toIcon(),
            onPressed: () => context.push((context) => CompareSettingsPage()),
          ),
          initialOption: initialBible,
          options: user.compareBiblesOrDefault,
          optionMapper: (option) => StyledSelectOption(
            title: option.title().toText(),
            subtitle: option.fullName().toText(),
            thirdLine: BibleTile.buildBibleChips(option),
          ),
        );
      });
}
