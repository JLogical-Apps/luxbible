import 'package:bible/models/commentary_type.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/commentaries_page.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class CommentarySelectionSheet {
  static Future<CommentaryType?> show(BuildContext context, {CommentaryType? initialCommentary}) =>
      context.showStyledSheet((context, ref) {
        final user = ref.watch(userProvider);
        return StyledSelectionSheet(
          title: t.labels.commentary.toText(),
          trailing: StyledCircleButton.md(
            child: Symbols.tune.toIcon(),
            onPressed: () => context.push(CommentariesPage()),
          ),
          initialOption: initialCommentary,
          options: user.commentariesOrDefault,
          optionMapper: (option) =>
              StyledSelectOption(title: option.title().toText(), subtitle: option.description().toText()),
        );
      });
}
