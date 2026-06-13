import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/bible_tile.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class BiblesPage extends HookConsumerWidget {
  const BiblesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final bibles = user.biblesOrDefault;

    return StyledPage(
      title: 'Bibles'.toText(),
      body: StyledDock(
        forceHeight: true,
        shrinkWrap: false,
        children: [
          if (bibles.isEmpty)
            Padding(
              padding: .all(16),
              child: StyledTile.message(
                leading: Symbols.book.toIcon(),
                title: "You haven't added any Bibles.".toText(),
              ),
            ),
          Expanded(
            child: StyledReorderableList(
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
          ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.secondary(
            label: 'Add & Remove Bibles'.toText(),
            onPressed: () => context.showStyledSheet((context) {
              final selectedBiblesState = useState(user.biblesOrDefault);
              return StyledSheet(
                title: 'Add & Remove Bibles'.toText(),
                children: BibleTranslation.values
                    .map(
                      (translation) => BibleTile(
                        translation: translation,
                        trailing: StyledSwitch(
                          isSelected: selectedBiblesState.value.contains(translation),
                          onSelected:
                              selectedBiblesState.value.length <= 1 && selectedBiblesState.value.contains(translation)
                              ? null
                              : (_) => selectedBiblesState.value = selectedBiblesState.value.withToggle(translation),
                        ),
                      ),
                    )
                    .toList(),
                buttonsBuilder: (context) => [
                  StyledRectButton.primary(
                    label: 'Save'.toText(),
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
