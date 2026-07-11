import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/bible_plan_tile.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class BiblePlanSearchPage extends HookConsumerWidget {
  const BiblePlanSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planByType = ref.watch(biblePlansProvider);

    final scopeState = useState<BiblePlanScope?>(null);
    final scope = scopeState.value;

    final typeState = useState<BiblePlanSearchType?>(null);
    final type = typeState.value;

    final matchingPlanByType = planByType
        .where((planType, plan) => scope == null || planType.scope == scope)
        .where((planType, plan) => type == null || planType.searchType == type);

    return StyledPage(
      title: 'Find A Bible Plan'.toText(),
      body: Column(
        crossAxisAlignment: .start,
        children: [
          SingleChildScrollView(
            scrollDirection: .horizontal,
            padding: .symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                StyledPillButton.md(
                  colorBuilder: scope == null ? null : .surfacePrimaryInverted,
                  leading: Symbols.book_6.toIcon(),
                  label: (scope?.title() ?? 'Scope').toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newScope = await context.showStyledSheet(
                      (context) => StyledSelectionSheet<BiblePlanScope>(
                        title: 'Scope'.toText(),
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
                    if (newScope != null) {
                      scopeState.value = newScope;
                    }
                  },
                ),
                StyledPillButton.md(
                  colorBuilder: type == null ? null : .surfacePrimaryInverted,
                  leading: Symbols.category.toIcon(),
                  label: (type?.title() ?? 'Type').toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newType = await context.showStyledSheet(
                      (context) => StyledSelectionSheet<BiblePlanSearchType>(
                        title: 'Type'.toText(),
                        options: BiblePlanSearchType.values,
                        optionMapper: (type) =>
                            StyledSelectOption(title: type.title().toText(), subtitle: type.description().toText()),
                        initialOption: type,
                        trailing: type == null
                            ? null
                            : StyledCircleButton.md(
                                child: Symbols.delete.toIcon(),
                                onPressed: () {
                                  typeState.value = null;
                                  context.pop();
                                },
                              ),
                      ),
                    );
                    if (newType != null) {
                      typeState.value = newType;
                    }
                  },
                ),
              ],
            ),
          ),
          gapH8,
          Expanded(
            child: StyledListView(
              padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
              children: [
                if (matchingPlanByType.isEmpty)
                  Padding(
                    padding: .all(16),
                    child: StyledTile.message(
                      leading: Symbols.search_off.toIcon(),
                      title: 'No matching Bible plans.'.toText(),
                    ),
                  ),
                ...matchingPlanByType.mapToIterable(
                  (type, plan) => BiblePlanTile(
                    planType: type,
                    plan: plan,
                    trailing: Icon(Symbols.chevron_right),
                    onPressed: () async {
                      final shouldStartPlan = await context.showStyledSheet(
                        (context) => StyledSheet(
                          title: 'Start Plan?'.toText(),
                          children: [
                            BiblePlanTile(planType: type, plan: plan),
                            StyledDivider(height: 2),
                            ...StyledSection(
                              padding: .only(top: 24),
                              title: 'Days'.toText(),
                              children: plan.days
                                  .mapIndexed<Widget>(
                                    (dayIndex, day) => StyledListItem(
                                      title: 'Day ${dayIndex + 1}'.toText(),
                                      subtitle: Text(day.passages.map((passage) => passage.format()).join(' • ')),
                                    ),
                                  )
                                  .toList(),
                            ).buildChildren(context),
                          ],
                          buttonsBuilder: (context) => [
                            StyledRectButton.primary(label: 'Start Plan'.toText(), onPressed: () => context.pop(true)),
                          ],
                        ),
                      );
                      if (shouldStartPlan == true && context.mounted) {
                        ref.updateUser(
                          (user) => user
                              .withStartedPlan(planType: type, plan: plan)
                              .withOnboardingStepCompleted(.startBiblePlan),
                        );
                        context.pop(type);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
