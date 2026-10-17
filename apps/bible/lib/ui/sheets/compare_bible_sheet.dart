import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/compare_settings_page.dart';
import 'package:bible/ui/widgets/bible_abbreviation.dart';
import 'package:bible/ui/widgets/bible_tile.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n/strings.g.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class CompareBibleSheet {
  static Future<BibleTranslation?> show(BuildContext context, {BibleTranslation? initialBible}) =>
      context.showStyledSheetWithBreadcrumbs(breadcrumbText: t.studyActions.compare, (context, ref) {
        final user = ref.watch(userProvider);
        return StyledSelectionSheet(
          title: t.studyActions.compare.toText(),
          trailing: StyledCircleButton.md(
            child: Symbols.tune.toIcon(),
            onPressed: () => context.push(CompareSettingsPage()),
          ),
          initialOption: initialBible,
          options: user.compareBiblesOrDefault,
          optionMapper: (option) => StyledSelectOption(
            leading: BibleAbbreviation(translation: option),
            title: option.fullName().toText(),
            subtitle: option.publisher.toText(),
            thirdLine: BibleTile.buildBibleChips(option),
          ),
        );
      });
}
