import 'package:bible/models/user/language.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/bible_tile.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class BibleSheet {
  static Future<BibleTranslation?> show(BuildContext context) {
    ref.markOnboardingStep(.changeBible);
    return context.showStyledSheet<BibleTranslation>((context, ref) {
      final user = ref.watch(userProvider);
      return StyledSheet(
        title: t.labels.bible.toText(),
        children: [
          if (user.recentBibles.isNotEmpty)
            StyledStickyHeader(
              title: t.navigation.recents.toText(),
              children: user.recentBibles
                  .take(5)
                  .map(
                    (translation) => StyledSwipeable(
                      key: ValueKey(translation),
                      actions: [
                        .remove(
                          onPressed: () => ref.updateUser(
                            (user) => user.copyWith(recentBibles: user.recentBibles.withRemoved(translation)),
                          ),
                        ),
                      ],
                      child: BibleTile(
                        translation: translation,
                        trailing: StyledRadio(isSelected: translation == user.translation),
                        onPressedOverride: () => context.pop(translation),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ...BibleTranslation.values
              .groupListsBy((translation) => translation.bibleLanguage)
              .sortedBy((language, _) => language.appLanguage == Language.device ? 0 : 1)
              .mapToIterable(
                (language, translations) => StyledStickyHeader(
                  title: language.title().toText(),
                  children: translations
                      .map(
                        (translation) => BibleTile(
                          translation: translation,
                          trailing: StyledRadio(isSelected: translation == user.translation),
                          onPressedOverride: () => context.pop(translation),
                        ),
                      )
                      .toList(),
                ),
              ),
        ],
      );
    });
  }
}
