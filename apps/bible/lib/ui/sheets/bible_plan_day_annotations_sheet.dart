import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/annotation_list_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BiblePlanDayAnnotationsSheet {
  static Future<void> show(
    BuildContext context, {
    required BiblePlanDayId planDay,
    required String planName,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => context.showStyledSheet(
    (_, _) => StyledSheet.builder(
      title: t.biblePlans.day(day: planDay.dayIndex + 1).toText(),
      subtitle: planName.toText(),
      childrenBuilder: (context, ref) {
        final annotations = ref.watch(userProvider).getPlanDayAnnotations(planDay);
        return annotations.isEmpty
            ? [
                Padding(
                  padding: .all(16),
                  child: StyledTile.message(
                    leading: Symbols.note_stack.toIcon(),
                    title: t.emptyStates.noAnnotations.toText(),
                  ),
                ),
              ]
            : annotations
                  .sortedBy((annotation) => annotation.createdAt)
                  .map(
                    (annotation) => AnnotationListItem(
                      key: ValueKey(annotation),
                      annotation: annotation,
                      onNavigateToVerseSelection: onNavigateToVerseSelection,
                    ),
                  )
                  .toList();
      },
    ),
  );
}
