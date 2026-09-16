import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/custom_bible_plans_provider.dart';
import 'package:bible/ui/pages/create_bible_plan_page.dart';
import 'package:bible/ui/widgets/bible_plan_tile.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utils_core/utils_core.dart';

enum BiblePlanSearchSource { included, custom }

class BiblePlanSearchPage extends HookConsumerWidget implements StyledRoute<String> {
  const BiblePlanSearchPage({super.key});

  @override
  String get path => '/bible-plans/find';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planById = ref.watch(biblePlansProvider);
    final customPlanById = ref.watch(customBiblePlansProvider);

    final scopeState = useState<BiblePlanScope?>(null);
    final scope = scopeState.value;

    final sourceState = useState<BiblePlanSearchSource?>(null);
    final source = sourceState.value;

    final matchingPlanById = planById
        .where(
          (planId, _) =>
              source == null ||
              (source == .custom ? customPlanById.containsKey(planId) : !customPlanById.containsKey(planId)),
        )
        .where((planId, plan) => scope == null || plan.scope == scope);

    return StyledPage(
      title: t.biblePlans.find.toText(),
      body: StyledDock(
        shrinkWrap: false,
        children: [
          SingleChildScrollView(
            scrollDirection: .horizontal,
            padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                StyledPillButton.md(
                  colorBuilder: scope == null ? null : .surfacePrimaryInverted,
                  leading: Symbols.book_6.toIcon(),
                  label: (scope?.title() ?? t.labels.scope).toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newScope = await context.showStyledSheet(
                      (context, _) => StyledSelectionSheet<BiblePlanScope>(
                        title: t.labels.scope.toText(),
                        options: BiblePlanScope.values,
                        optionMapper: (scope) =>
                            StyledSelectOption(title: scope.title().toText(), subtitle: scope.description().toText()),
                        initialOption: scope,
                        trailing: scope == null
                            ? null
                            : StyledCircleButton.md(
                                child: Symbols.delete.toIcon(),
                                onPressed: () {
                                  scopeState.value = null;
                                  context.pop();
                                },
                              ),
                      ),
                    );
                    if (newScope != null) scopeState.value = newScope;
                  },
                ),
                StyledPillButton.md(
                  colorBuilder: source == null ? null : .surfacePrimaryInverted,
                  leading: Symbols.source.toIcon(),
                  label: (source?.title() ?? t.labels.source).toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newSource = await context.showStyledSheet(
                      (context, _) => StyledSelectionSheet<BiblePlanSearchSource>(
                        title: t.labels.source.toText(),
                        options: BiblePlanSearchSource.values,
                        optionMapper: (source) =>
                            StyledSelectOption(title: source.title().toText(), subtitle: source.description().toText()),
                        initialOption: source,
                        trailing: source == null
                            ? null
                            : StyledCircleButton.md(
                                child: Symbols.delete.toIcon(),
                                onPressed: () {
                                  sourceState.value = null;
                                  context.pop();
                                },
                              ),
                      ),
                    );
                    if (newSource != null) sourceState.value = newSource;
                  },
                ),
              ],
            ),
          ),
          gapH8,
          if (matchingPlanById.isEmpty)
            Padding(
              padding: .all(16),
              child: StyledTile.message(
                leading: Symbols.search_off.toIcon(),
                title: t.emptyStates.noMatchingPlans.toText(),
              ),
            ),
          ...matchingPlanById.mapToIterable(
            (planId, plan) => BiblePlanTile(
              planId: planId,
              plan: plan,
              trailing: Icon(Symbols.chevron_right),
              onPressed: () async {
                final isCustom = ref.read(customBiblePlansProvider).containsKey(planId);
                final shouldStartPlan = await context.showStyledSheet(
                  (sheetContext, _) => StyledSheet(
                    title: t.biblePlans.startPlanQuestion.toText(),
                    trailing: isCustom
                        ? StyledCircleButton.md(
                            child: Symbols.more_vert.toIcon(),
                            onPressed: () => context.showStyledSheet(
                              (menuContext, _) => StyledSheet(
                                title: plan.name.toText(),
                                children: [
                                  StyledListItem(
                                    leading: Icon(Symbols.delete, color: menuContext.colors.contentCritical),
                                    title: t.biblePlans.deletePlan.toText(),
                                    onPressed: () async {
                                      menuContext.pop();
                                      final shouldDelete = await context.showStyledDialog(
                                        (context) => StyledDialog.confirmDelete(
                                          title: t.biblePlans.deletePlanQuestion.toText(),
                                          body: t.biblePlans.deletePlanConfirmation(name: plan.name).toText(),
                                          cancelLabel: t.common.nevermind.toText(),
                                        ),
                                      );
                                      if (shouldDelete != true) return;
                                      ref.read(customBiblePlansProvider.notifier).delete(planId);
                                      ref.updateUser((user) => user.withRemovedCompletedPlan(planId));
                                      if (context.mounted) context.pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        : null,
                    children: [
                      BiblePlanTile(planId: planId, plan: plan, showTags: false),
                      StyledListItem(
                        leading: Symbols.calendar_month.toIcon(),
                        title: t.labels.duration.toText(),
                        subtitle: t.biblePlans.dayCount(count: plan.dayCount).toText(),
                      ),
                      if (BiblePlanType.getById(planId)?.source case final source?)
                        StyledListItem(
                          leading: Symbols.source.toIcon(),
                          title: t.labels.source.toText(),
                          subtitle: source.name.toText(),
                          trailing: Symbols.arrow_outward.toIcon(),
                          onPressed: () => launchUrl(Uri.parse(source.link)),
                        ),
                      StyledDivider(height: 2),
                      ...StyledSection(
                        padding: .only(top: 24),
                        title: t.labels.days.toText(),
                        children: plan.days
                            .mapIndexed<Widget>(
                              (dayIndex, day) => StyledListItem(
                                title: t.biblePlans.day(day: dayIndex + 1).toText(),
                                subtitle: day.isReviewAndReflect
                                    ? t.biblePlans.reviewAndReflect.toText()
                                    : Text(day.passages.map((passage) => passage.format()).join(' • ')),
                              ),
                            )
                            .toList(),
                      ).buildChildren(context),
                    ],
                    buttonsBuilder: (context) => [
                      StyledRectButton.primary(
                        label: t.biblePlans.startPlan.toText(),
                        onPressed: () => context.pop(true),
                      ),
                    ],
                  ),
                );
                if (shouldStartPlan == true && context.mounted) {
                  ref.updateUser(
                    (user) =>
                        user.withStartedPlan(planId: planId, plan: plan).withOnboardingStepCompleted(.startBiblePlan),
                  );
                  context.pop(planId);
                }
              },
            ),
          ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.primary(
            label: t.biblePlans.createCustomPlan.toText(),
            onPressed: () async {
              final planId = await context.push(CreateBiblePlanPage());
              if (planId != null && context.mounted) context.pop(planId);
            },
          ),
        ],
      ),
    );
  }
}

extension BiblePlanSearchSourceExtension on BiblePlanSearchSource {
  String title() => switch (this) {
    .included => t.biblePlans.includedPlans,
    .custom => t.common.custom,
  };

  String description() => switch (this) {
    .included => t.biblePlans.includedPlansDescription,
    .custom => t.biblePlans.customPlansDescription,
  };
}
