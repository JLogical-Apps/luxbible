import 'package:lux/i18n.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:bible/ui/widgets/commentary_tile.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class CommentariesPage extends HookConsumerWidget {
  const CommentariesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final commentaries = user.commentariesOrDefault;

    return StyledPage(
      title: t.labels.commentaries.toText(),
      body: StyledDock(
        forceHeight: true,
        shrinkWrap: false,
        activeScrollKey: 'scroll',
        children: [
          if (commentaries.isEmpty)
            Padding(
              padding: .all(16),
              child: StyledTile.message(
                leading: Symbols.tooltip_2.toIcon(),
                title: t.emptyStates.noCommentariesAdded.toText(),
              ),
            ),
          Expanded(
            child: KeyedScrollTransformer(
              scrollKey: 'scroll',
              child: StyledReorderableList(
                children: commentaries
                    .map(
                      (commentary) => StyledSwipeable(
                        key: ValueKey(commentary),
                        isEnabled: user.commentariesOrDefault.length > 1,
                        actions: [
                          .delete(
                            onPressed: () => ref.updateUser(
                              (user) => user.copyWith(commentaries: user.commentariesOrDefault.withRemoved(commentary)),
                            ),
                          ),
                        ],
                        child: CommentaryTile(
                          commentary: commentary,
                          trailing: ReorderableDragStartListener(child: Icon(Symbols.drag_handle), index: 0),
                        ),
                      ),
                    )
                    .toList(),
                onReorder: (oldIndex, newIndex) => ref.updateUser(
                  (user) => user.copyWith(commentaries: user.commentariesOrDefault.withReorder(oldIndex, newIndex)),
                ),
              ),
            ),
          ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.secondary(
            label: t.commentaries.addRemove.toText(),
            onPressed: () => context.showStyledSheet((context) {
              final selectedCommentariesState = useState(user.commentariesOrDefault);
              return StyledSheet(
                title: t.commentaries.addRemove.toText(),
                children: CommentaryType.values
                    .map(
                      (commentary) => CommentaryTile(
                        commentary: commentary,
                        trailing: StyledSwitch(
                          isSelected: selectedCommentariesState.value.contains(commentary),
                          onSelected:
                              selectedCommentariesState.value.length <= 1 &&
                                  selectedCommentariesState.value.contains(commentary)
                              ? null
                              : (_) => selectedCommentariesState.value = selectedCommentariesState.value.withToggle(
                                  commentary,
                                ),
                        ),
                      ),
                    )
                    .toList(),
                buttonsBuilder: (context) => [
                  StyledRectButton.primary(
                    label: t.common.save.toText(),
                    onPressed: () {
                      ref.updateUser((user) => user.copyWith(commentaries: selectedCommentariesState.value));
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
