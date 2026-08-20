import 'package:bible/models/user/language.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/bible_tile.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class BiblesPage extends HookConsumerWidget {
  const BiblesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final bibles = user.biblesOrDefault;

    return StyledPage(
      title: t.labels.bibles.toText(),
      body: StyledDock(
        shrinkWrap: false,
        children: [
          StyledReorderableList(
            shrinkWrap: true,
            children: bibles
                .map(
                  (translation) => StyledSwipeable(
                    key: ValueKey(translation),
                    isEnabled: user.biblesOrDefault.length > 1,
                    actions: [
                      .delete(
                        onPressed: () => ref.updateUser(
                          (user) => user.copyWith(bibles: user.biblesOrDefault.withRemoved(translation)),
                        ),
                      ),
                    ],
                    child: BibleTile(
                      translation: translation,
                      trailing: ReorderableDragStartListener(child: Icon(Symbols.drag_handle), index: 0),
                    ),
                  ),
                )
                .toList(),
            onReorder: (oldIndex, newIndex) =>
                ref.updateUser((user) => user.copyWith(bibles: user.biblesOrDefault.withReorder(oldIndex, newIndex))),
          ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.secondary(
            label: t.bibleDetails.addRemoveBibles.toText(),
            onPressed: () => context.showStyledSheet((context, _) {
              final selectedBiblesState = useState(user.biblesOrDefault);
              return StyledSheet(
                title: t.bibleDetails.addRemoveBibles.toText(),
                children: BibleTranslation.values
                    .groupListsBy((translation) => translation.bibleLanguage)
                    .sortedBy((language, _) => language.appLanguage == Language.device ? 0 : 1)
                    .mapToIterable(
                      (language, translations) => StyledStickyHeader(
                        title: language.title().toText(),
                        children: translations
                            .map(
                              (translation) => BibleTile(
                                translation: translation,
                                trailing: StyledSwitch(
                                  isSelected: selectedBiblesState.value.contains(translation),
                                  onSelected:
                                      selectedBiblesState.value.length <= 1 &&
                                          selectedBiblesState.value.contains(translation)
                                      ? null
                                      : (_) => selectedBiblesState.value = selectedBiblesState.value.withToggle(
                                          translation,
                                        ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                    .toList(),
                buttonsBuilder: (context) => [
                  StyledRectButton.primary(
                    label: t.common.save.toText(),
                    onPressed: () {
                      ref.updateUser((user) => user.copyWith(bibles: selectedBiblesState.value));
                      context.pop();
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
