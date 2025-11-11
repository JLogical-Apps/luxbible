import 'package:bible/models/passage.dart';
import 'package:bible/models/user.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum VerseAction {
  highlight;

  Widget buildIcon(
    BuildContext context, {
    required User user,
    required Passage selectedPassage,
  }) => switch (this) {
    highlight => Icon(
      Symbols.format_ink_highlighter,
      fill: user.isPassageHighlighted(selectedPassage) ? 1 : 0,
    ),
  };

  void onPressed(
    BuildContext context,
    WidgetRef ref, {
    required User user,
    required Passage selectedPassage,
  }) {
    switch (this) {
      case highlight:
        ref
            .read(userProvider.notifier)
            .update((user) => user.withToggledHighlight(selectedPassage));
    }
  }
}
