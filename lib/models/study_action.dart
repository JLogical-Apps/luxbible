import 'dart:collection';

import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/cross_references_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/ui/widgets/verses_builder.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:utils_core/utils_core.dart';

enum StudyAction {
  compare,
  interlinear,
  commentary,
  crossReferences;

  String title() => switch (this) {
    compare => 'Compare',
    interlinear => 'Interlinear',
    commentary => 'Commentary',
    crossReferences => 'Cross References',
  };

  String description({required ReferencesRegion? region, required RegionType regionType}) {
    final regionText = region?.format() ?? regionType.formatThis();
    return switch (this) {
      compare => 'Compare $regionText across a variety of translations.',
      interlinear => 'View a lexical breakdown of $regionText using Strongs.',
      commentary => 'View commentaries of $regionText.',
      crossReferences => 'View cross references of $regionText.',
    };
  }

  IconData get icon => switch (this) {
    compare => Symbols.text_compare,
    interlinear => Symbols.dictionary,
    commentary => Symbols.tooltip_2,
    crossReferences => Symbols.graph_4,
  };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required ReferencesRegion region,
    required Bible bible,
    required User user,
    required Function(Passage) onNavigateToPassage,
  }) async {
    final bibles = ref.read(biblesProvider);
    switch (this) {
      case compare:
        context.showStyledSheet(
          (context) => StyledSheet(
            title: 'Compare'.toText(),
            subtitle: region.format().toText(),
            children: bibles
                .mapIndexed<Widget>(
                  (i, bible) => Stack(
                    children: [
                      StyledStickyHeader.child(
                        title: bible.translation.title().toText(),
                        child: Padding(
                          padding: .only(bottom: 16),
                          child: VersesBuilder(passage: region.toPassage(), bible: bible),
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
        context.showStyledSheetWithBreadcrumbs(
          breadcrumbText: region.format(),
          (context) => StyledSheet(
            title: 'Interlinear'.toText(),
            subtitle: region.format().toText(),
            children: region.references
                .mapIndexed((i, reference) {
                  final verse = bible.getVerseByReference(reference);
                  if (verse == null) {
                    return null;
                  }

                  return Stack(
                    children: [
                      StyledStickyHeader(
                        title: reference.format().toText(),
                        children: verse.fragments
                            .mapToMap((fragment) => MapEntry(fragment, fragment.strongIds.firstOrNull))
                            .withoutNullValues
                            .mapToIterable(
                              (fragment, strongId) => StyledListItem.navigation(
                                title: fragment.text.trim().toText(),
                                subtitle: Row(
                                  spacing: 4,
                                  children: [
                                    StyledBadge(text: strongId),
                                    if (strongs[strongId] case final strong?) Text(strong.languageText),
                                  ],
                                ),
                                onPressed: () {
                                  context.pop();
                                  StrongSheet.showWithContext(
                                    context,
                                    ref,
                                    strongId: strongId,
                                    bible: bible,
                                    user: user,
                                    onNavigateToPassage: onNavigateToPassage,
                                  );
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
        final relatedCommentaries = commentaries
            .mapToMap((commentary) => MapEntry(commentary, commentary.getNotesFor(region.toPassage())))
            .where((commentary, notes) => notes.isNotEmpty);
        context.showStyledSheet(
          (context) => StyledSheet(
            title: 'Commentary'.toText(),
            subtitle: region.format().toText(),
            children: relatedCommentaries.isEmpty
                ? [
                    Padding(
                      padding: .all(16),
                      child: StyledBanner(message: 'No Commentaries Found'.toText()),
                    ),
                  ]
                : relatedCommentaries
                      .mapToIterable(
                        (commentary, notes) => StyledStickyHeader(
                          title: commentary.name.toText(),
                          children: notes
                              .mapToIterable(
                                (passage, note) =>
                                    StyledListItem(title: passage.format().toText(), subtitle: note.toText()),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
          ),
        );
      case crossReferences:
        final crossReferences = ref.watch(crossReferencesProvider);
        final relatedCrossReferences = crossReferences.where(
          (reference, crossReferences) => region.references.contains(reference),
        );
        context.showStyledSheet(
          (context) => StyledSheet(
            title: 'Cross References'.toText(),
            subtitle: region.format().toText(),
            children: relatedCrossReferences.isEmpty
                ? [
                    Padding(
                      padding: .all(16),
                      child: StyledBanner(message: 'No Cross References Found'.toText()),
                    ),
                  ]
                : relatedCrossReferences
                      .mapToIterable(
                        (reference, crossReferences) => StyledStickyHeader(
                          title: reference.format().toText(),
                          children: crossReferences
                              .map(
                                (references) => StyledListItem(
                                  title: references.toPassage().format().toText(),
                                  subtitle: bible
                                      .getVersesBySpan(references)
                                      .map((verse) => verse.text)
                                      .join(' ')
                                      .toText(),
                                  onPressed: () {
                                    context.pop();
                                    onNavigateToPassage(references.toPassage());
                                  },
                                  trailing: Symbols.expand_circle_right.toIcon(),
                                ),
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
