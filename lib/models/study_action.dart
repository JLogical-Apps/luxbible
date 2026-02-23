import 'dart:collection';

import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/ui/widgets/passage_builder.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
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

  String description({required ReferencesRegion? region, required RegionType regionType}) {
    final regionText = region?.format() ?? regionType.formatThis();
    return switch (this) {
      compare => 'Compare $regionText across a variety of translations.',
      interlinear => 'View a lexical breakdown of $regionText using Strongs.',
      commentary => 'View commentaries of $regionText.',
    };
  }

  IconData get icon => switch (this) {
    compare => Symbols.text_compare,
    interlinear => Symbols.dictionary,
    commentary => Symbols.tooltip_2,
  };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required ReferencesRegion region,
    required Bible bible,
  }) async {
    final bibles = ref.read(biblesProvider);
    switch (this) {
      case compare:
        context.showStyledSheet(
          StyledSheet(
            titleText: 'Compare ${region.format()}',
            children: bibles
                .mapIndexed<Widget>(
                  (i, bible) => Stack(
                    children: [
                      StyledStickyHeader.child(
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
        final strongs = ref.watch(strongsProvider);
        context.showStyledSheetWithContext(
          breadcrumbText: region.format(),
          (context) => StyledSheet(
            titleText: 'Interlinear ${region.format()}',
            children: region.references
                .mapIndexed((i, reference) {
                  final verse = bible.getVerseByReference(reference);
                  if (verse == null) {
                    return null;
                  }

                  return Stack(
                    children: [
                      StyledStickyHeader(
                        titleText: reference.format(),
                        children: verse.fragments
                            .mapToMap((fragment) => MapEntry(fragment, fragment.strongIds.firstOrNull))
                            .withoutNullValues
                            .mapToIterable(
                              (fragment, strongId) => StyledListItem.navigation(
                                titleText: fragment.text.trim(),
                                subtitle: Row(
                                  spacing: 4,
                                  children: [
                                    StyledBadge(text: strongId),
                                    if (strongs[strongId] case final strong?) Text(strong.languageText),
                                  ],
                                ),
                                onPressed: () {
                                  context.pop();
                                  StrongSheet.showWithContext(context, ref, strongId: strongId);
                                },
                              ),
                            )
                            .toList(),
                      ),
                      if (i + 1 < region.references.length)
                        Positioned(bottom: 0, left: 0, right: 0, child: StyledDivider(height: 2)),
                    ],
                  );
                })
                .nonNulls
                .toList(),
          ),
        );
      case commentary:
        final commentaries = ref.watch(commentariesProvider);
        context.showStyledSheet(
          StyledSheet(
            titleText: 'Commentary of ${region.format()}',
            children: commentaries
                .mapToMap((commentary) => MapEntry(commentary, commentary.getNotesFor(region.toPassage())))
                .where((commentary, notes) => notes.isNotEmpty)
                .mapToIterable(
                  (commentary, notes) => StyledStickyHeader(
                    titleText: commentary.name,
                    children: notes
                        .mapToIterable(
                          (passage, note) => StyledListItem(titleText: passage.format(), subtitleText: note),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        );
    }
  }
}
