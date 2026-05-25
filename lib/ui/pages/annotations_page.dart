import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class AnnotationsPage extends ConsumerWidget {
  const AnnotationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return StyledPage(
      title: 'Your Annotations'.toText(),
      body: StyledListView(
        children: user.annotations.isEmpty
            ? [
                Padding(
                  padding: .all(16),
                  child: StyledTile.message(
                    leading: Symbols.note_stack.toIcon(),
                    title: "You haven't created any annotations.".toText(),
                  ),
                ),
              ]
            : user.annotations.reversed
                  .map((annotation) => StyledListItem(title: annotation.formatLocation().toText()))
                  .toList(),
      ),
    );
  }
}
