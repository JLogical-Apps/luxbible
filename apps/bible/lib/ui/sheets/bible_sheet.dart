import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/bibles_page.dart';
import 'package:bible/ui/widgets/bible_tile.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BibleSheet {
  static Future<BibleTranslation?> show(BuildContext context) {
    final user = ref.read(userProvider);
    ref.markOnboardingStep(.changeBible);
    return context.showStyledSheet<BibleTranslation>(
      (context, _) => StyledSheet(
        title: t.labels.bible.toText(),
        trailing: StyledCircleButton.md(
          child: Symbols.tune.toIcon(),
          onPressed: () {
            context.pop();
            context.push(BiblesPage());
          },
        ),
        children: user.biblesOrDefault
            .map(
              (translation) => BibleTile(
                translation: translation,
                trailing: StyledRadio(isSelected: translation == user.translation),
                onPressedOverride: () => context.pop(translation),
              ),
            )
            .toList(),
      ),
    );
  }
}
