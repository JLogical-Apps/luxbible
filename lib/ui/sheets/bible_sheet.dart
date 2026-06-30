import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/bibles_page.dart';
import 'package:bible/ui/widgets/bible_tile.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BibleSheet {
  static Future<BibleTranslation?> show(BuildContext context) {
    final user = ref.read(userProvider);
    return context.showStyledSheet<BibleTranslation>(
      (context) => StyledSheet(
        title: 'Bible'.toText(),
        trailing: StyledCircleButton.lg(
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
