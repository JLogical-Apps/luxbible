import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/custom_bible_plans_provider.dart';
import 'package:bible/ui/widgets/bible_plan_thumbnail.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class CreateBiblePlanPage extends HookConsumerWidget implements StyledRoute<String> {
  const CreateBiblePlanPage({super.key});

  @override
  String get path => '/bible-plans/create';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methodState = useState<BiblePlanCreationMethod?>(null);
    final method = methodState.value;

    final biblePlans = ref.watch(biblePlansProvider);
    final existingNames = biblePlans.mapToIterable((id, plan) => plan.getDisplayName(id)).distinct;

    final nameState = useDependentState(() {
      final baseName = t.biblePlans.myBiblePlan;
      if (!existingNames.contains(baseName)) return baseName;

      return Iterable.generate(
        existingNames.length + 1,
        (index) => '$baseName (${index + 2})',
      ).firstWhere((name) => !existingNames.contains(name));
    }, [method]);
    final name = nameState.value;

    final colorState = useDependentState(() => BiblePlanColor.values.random, [method]);
    final daysState = useDependentState(() => [BiblePlanDay()], [method]);
    final days = daysState.value;

    final nameError = name.trim().isEmpty
        ? t.biblePlans.nameRequired
        : existingNames.contains(name)
        ? t.biblePlans.nameAlreadyExists
        : null;

    final plan = BiblePlan(name: name, colorOverride: colorState.value, days: daysState.value);

    final stepIndexState = useState(0);

    return StyledModulePage(
      title: (stepIndexState.value == 2 ? t.biblePlans.review : t.biblePlans.createCustomPlan).toText(),
      onStepChanged: (stepIndex) => stepIndexState.value = stepIndex,
      steps: [
        StyledModuleStep.selection(
          title: t.biblePlans.creationMethodQuestion.toText(),
          options: BiblePlanCreationMethod.values,
          selectedOption: method,
          optionMapper: (method) => StyledSelectOption(
            title: t.biblePlans.manual.toText(),
            subtitle: t.biblePlans.manualDescription.toText(),
            leading: Symbols.edit_note.toIcon(),
          ),
          onSelectOption: (method) => methodState.value = method,
          canGoNext: method != null,
        ),
        StyledModuleStep(
          title: t.biblePlans.nameAndColor.toText(),
          childrenBuilder: (context) => [
            StyledTextField(
              text: name,
              label: t.labels.name.toText(),
              error: nameError?.toText(),
              onChanged: (name) => nameState.value = name,
            ),
            gapH24,
            Wrap(
              alignment: .center,
              spacing: 12,
              runSpacing: 12,
              children: BiblePlanColor.values
                  .map(
                    (color) => StyledTile(
                      isSelected: colorState.value == color,
                      onPressed: () => colorState.value = color,
                      child: BiblePlanThumbnail(displayName: name, color: color, size: .lg),
                    ),
                  )
                  .toList(),
            ),
          ],
          buttons: .next(canGoNext: nameError == null),
        ),
        StyledModuleStep(
          bodyPadding: .zero,
          onBackPressed: (goBack) async {
            final shouldDiscard = await context.showStyledDialog(
              (context) => StyledDialog.confirmDelete(
                title: t.biblePlans.discardPlanQuestion.toText(),
                body: t.biblePlans.discardPlanConfirmation.toText(),
                deleteLabel: t.biblePlans.discard.toText(),
                cancelLabel: t.common.nevermind.toText(),
              ),
            );
            if (shouldDiscard == true && context.mounted) goBack();
          },
          childrenBuilder: (context) => [
            ...StyledDivider(height: 2).wrapPositioned(
              days
                  .mapIndexed(
                    (dayIndex, day) => StyledSwipeable(
                      key: ValueKey((day, days.length)),
                      actions: [
                        .remove(
                          onPressed: () async {
                            final shouldRemove = day.isReviewAndReflect
                                ? true
                                : await context.showStyledDialog(
                                    (context) => StyledDialog.confirmDelete(
                                      title: t.biblePlans.removeDayQuestion.toText(),
                                      body: t.biblePlans.removeDayConfirmation(day: dayIndex + 1).toText(),
                                      deleteLabel: t.common.remove.toText(),
                                      cancelLabel: t.common.nevermind.toText(),
                                    ),
                                  );
                            if (shouldRemove == true) daysState.value = days.withRemovedAt(dayIndex);
                          },
                        ),
                      ],
                      child: StyledStickyHeader(
                        title: t.biblePlans.day(day: dayIndex + 1).toText(),
                        trailing: Row(
                          children: [
                            StyledCircleButton.md(
                              child: Symbols.add.toIcon(),
                              colorBuilder: .surfaceSecondary,
                              onPressed: () async {
                                final passage = await FindInBibleSheet.show(
                                  context,
                                  selectionConfiguration: ref.watch(luxReaderConfigurationProvider).selection,
                                  title: t.biblePlans.addPassage.toText(),
                                );
                                if (passage != null) daysState.value = days.withPassageAdded(dayIndex, passage);
                              },
                            ),
                          ],
                        ),
                        children: [
                          if (day.isReviewAndReflect)
                            Padding(
                              padding: EdgeInsets.all(16).copyWith(top: 0),
                              child: StyledTile.message(
                                leading: Symbols.book_ribbon.toIcon(),
                                title: t.biblePlans.reviewAndReflect.toText(),
                              ),
                            )
                          else
                            StyledReorderableList(
                              shrinkWrap: true,
                              onReorder: (oldIndex, newIndex) =>
                                  daysState.value = days.withPassageReordered(dayIndex, oldIndex, newIndex),
                              children: day.passages.map((passage) {
                                return StyledSwipeable(
                                  key: ValueKey(passage),
                                  actions: [
                                    .remove(
                                      onPressed: () => daysState.value = days.withPassageRemoved(dayIndex, passage),
                                    ),
                                  ],
                                  child: StyledListItem(
                                    title: passage.format().toText(),
                                    trailing: StyledCircleButton.md(
                                      child: Symbols.more_vert.toIcon(),
                                      onPressed: () => context.showStyledSheet(
                                        (sheetContext, _) => StyledSheet(
                                          title: passage.format().toText(),
                                          children: [
                                            if (days.length >= 2)
                                              StyledListItem.navigation(
                                                leading: Symbols.move_group.toIcon(),
                                                title: t.biblePlans.moveToAnotherDay.toText(),
                                                onPressed: () {
                                                  sheetContext.pop();
                                                  context.showStyledSheet(
                                                    (sheetContext, _) => StyledSheet(
                                                      title: t.biblePlans.moveToAnotherDay.toText(),
                                                      children: days.indexed
                                                          .where((entry) => entry.$1 != dayIndex)
                                                          .map(
                                                            (entry) => StyledListItem(
                                                              title: t.biblePlans.day(day: entry.$1 + 1).toText(),
                                                              subtitle: entry.$2.isReviewAndReflect
                                                                  ? t.biblePlans.reviewAndReflect.toText()
                                                                  : Text(
                                                                      entry.$2.passages
                                                                          .map((passage) => passage.format())
                                                                          .join(' • '),
                                                                    ),
                                                              onPressed: () {
                                                                daysState.value = days.withPassageMoved(
                                                                  sourceDayIndex: dayIndex,
                                                                  destinationDayIndex: entry.$1,
                                                                  passage: passage,
                                                                );
                                                                sheetContext.pop();
                                                              },
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            StyledListItem(
                                              leading: Icon(Symbols.delete, color: sheetContext.colors.contentCritical),
                                              title: t.common.remove.toText(),
                                              onPressed: () {
                                                daysState.value = days.withPassageRemoved(dayIndex, passage);
                                                sheetContext.pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            gapH32,
            Padding(
              padding: .all(16),
              child: StyledRectButton.secondary(
                label: t.biblePlans.addDay.toText(),
                onPressed: days.length < 365 ? () => daysState.value = [...days, BiblePlanDay()] : null,
              ),
            ),
          ],
          buttons: .custom(
            buttonsBuilder: (context, _) => [
              StyledRectButton.primary(
                label: t.biblePlans.createAndStart.toText(),
                onPressed: plan.isValid
                    ? () {
                        final id = ref.read(customBiblePlansProvider.notifier).create(plan);
                        ref.updateUser(
                          (user) =>
                              user.withStartedPlan(planId: id, plan: plan).withOnboardingStepCompleted(.startBiblePlan),
                        );
                        context.pop(id);
                      }
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum BiblePlanCreationMethod { manual }
