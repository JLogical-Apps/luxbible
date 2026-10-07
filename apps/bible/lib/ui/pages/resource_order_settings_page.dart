import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class ResourceOrderSettingsPage extends ConsumerWidget implements StyledRoute<void> {
  const ResourceOrderSettingsPage({super.key});

  @override
  String get path => '/settings/resources';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resourceOrder = ref.watch(userProvider).resourceOrderOrDefault;

    return StyledPage(
      title: t.studyActions.linkedResources.toText(),
      body: ListView(
        children: [
          Padding(
            padding: .all(16),
            child: StyledTile.message(
              leading: Symbols.info.toIcon(),
              title: t.settings.resourceOrderDescription.toText(),
            ),
          ),
          StyledReorderableList(
            shrinkWrap: true,
            children: resourceOrder
                .map(
                  (type) => StyledListItem.draggable(
                    key: ValueKey(type),
                    title: type.title().toText(),
                    leading: type.icon.toIcon(),
                  ),
                )
                .toList(),
            onReorder: (oldIndex, newIndex) => ref.updateUser(
              (user) => user.copyWith(resourceOrder: user.resourceOrderOrDefault.withReorder(oldIndex, newIndex)),
            ),
          ),
        ],
      ),
    );
  }
}
