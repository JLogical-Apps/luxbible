import 'package:bible/models/reference/region.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_divider.dart';
import 'package:bible/style/widgets/styled_sticky_header.dart';
import 'package:bible/ui/pages/commentaries_page.dart';
import 'package:bible/ui/pages/interlinear_page.dart';
import 'package:bible/ui/widgets/passage_builder.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum StudyAction {
  compare,
  interlinear,
  commentary;

  String title() => switch (this) {
    compare => 'Compare',
    interlinear => 'Interlinear',
    commentary => 'Commentary',
  };

  String description({required ReferencesRegion region}) => switch (this) {
    compare => 'Compare ${region.format()} across a variety of translations.',
    interlinear => 'View a lexical breakdown of ${region.format()} using Strongs.',
    commentary => 'View commentaries of ${region.format()}.',
  };

  IconData get icon => switch (this) {
    compare => Symbols.text_compare,
    interlinear => Symbols.dictionary,
    commentary => Symbols.tooltip_2,
  };

  Future<void> onPressed(BuildContext context, WidgetRef ref, {required ReferencesRegion region}) async {
    final bibles = ref.read(biblesProvider);
    switch (this) {
      case compare:
        context.showStyledSheet(
          StyledSheet.list(
            titleText: 'Compare ${region.format()}',
            children: bibles
                .mapIndexed<Widget>(
                  (i, bible) => Stack(
                    children: [
                      StyledStickyHeader(
                        titleText: bible.translation.title(),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: PassageBuilder(passage: region.toPassage(), bible: bible),
                        ),
                      ),
                      if (i + 1 < bibles.length)
                        Positioned(bottom: 0, left: 0, right: 0, child: StyledDivider(height: 2)),
                    ],
                  ),
                )
                .toList(),
          ),
        );
      case interlinear:
        context.push(InterlinearPage(passage: region.toPassage()));
      case commentary:
        context.push(CommentariesPage(passage: region.toPassage()));
    }
  }
}
