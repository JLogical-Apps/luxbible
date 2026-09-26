import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/annotation_list_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class BiblePlanAnnotationsSheet {
  static Future<void> showDay(
    BuildContext context, {
    required BiblePlanDayId planDay,
    required String planName,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => show(
    context,
    title: t.biblePlans.day(day: planDay.dayIndex + 1),
    planName: planName,
    getAnnotations: (user) => user.getPlanDayAnnotations(planDay),
    onNavigateToVerseSelection: onNavigateToVerseSelection,
  );

  static Future<void> showInstance(
    BuildContext context, {
    required String instanceId,
    required String planName,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => show(
    context,
    title: t.labels.annotations,
    planName: planName,
    getAnnotations: (user) => user.getPlanInstanceAnnotations(instanceId),
    showsDaySections: true,
    onNavigateToVerseSelection: onNavigateToVerseSelection,
  );

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String planName,
    required List<Annotation> Function(User) getAnnotations,
    bool showsDaySections = false,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => context.showStyledSheet(
    (_, _) => StyledSheet.builder(
      title: title.toText(),
      subtitle: planName.toText(),
      childrenBuilder: (context, ref) {
        final annotations = getAnnotations(ref.watch(userProvider));

        List<Widget> buildItems(Iterable<Annotation> annotations) => annotations
            .sortedBy((annotation) => annotation.createdAt)
            .map(
              (annotation) => AnnotationListItem(
                key: ValueKey(annotation),
                annotation: annotation,
                onNavigateToVerseSelection: onNavigateToVerseSelection,
              ),
            )
            .toList();

        if (annotations.isEmpty) {
          return [
            Padding(
              padding: .all(16),
              child: StyledTile.message(
                leading: Symbols.note_stack.toIcon(),
                title: t.emptyStates.noAnnotations.toText(),
              ),
            ),
          ];
        }

        return showsDaySections
            ? annotations
                  .groupListsBy((annotation) => annotation.planDay?.dayIndex ?? 0)
                  .sortedBy((day, annotations) => day)
                  .mapToIterable(
                    (day, annotations) => StyledSection(
                      padding: .only(top: 24),
                      title: t.biblePlans.day(day: day + 1).toText(),
                      children: buildItems(annotations),
                    ).buildChildren(context),
                  )
                  .flattenedToList
            : buildItems(annotations);
      },
    ),
  );
}
