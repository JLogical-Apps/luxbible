import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/bible_plan_page.dart';
import 'package:bible/ui/widgets/bible_plan_thumbnail.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class BiblePlanSearchPage extends HookConsumerWidget {
  const BiblePlanSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final planByType = ref.watch(biblePlansProvider);

    final scopeState = useState<BiblePlanScope?>(null);
    final scope = scopeState.value;

    final typeState = useState<BiblePlanSearchType?>(null);
    final type = typeState.value;

    final matchingPlans = planByType.entries
        .where((entry) => scope == null || entry.key.scope == scope)
        .where((entry) => type == null || entry.key.searchType == type)
        .toList();

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
                if (matchingPlans.isEmpty)
                  Padding(
                    padding: .all(16),
                    child: StyledTile.message(
                      leading: Symbols.search_off.toIcon(),
                      title: 'No matching Bible plans.'.toText(),
                    ),
                  ),
                ...matchingPlans.map((entry) {
                  final type = entry.key;
                  final plan = entry.value;
                  final hasStarted = user.hasStartedPlan(type);
                  return StyledListItem.navigation(
                    leading: BiblePlanThumbnail(plan: plan, isEnabled: !hasStarted),
                    title: SingleChildScrollView(
                      scrollDirection: .horizontal,
                      child: Row(
                        spacing: 8,
                        children: [
                          plan.name.toText(),
                          if (hasStarted)
                            StyledTag.sm(
                              leading: Symbols.check.toIcon(),
                              child: 'Following'.toText(),
                              isEnabled: false,
                            ),
                        ],
                      ),
                    ),
                    subtitle: plan.description.toText(),
                    thirdLine: Padding(
                      padding: .only(top: 4),
                      child: Row(
                        spacing: 4,
                        children: [
                          StyledTag.sm(isEnabled: !hasStarted, child: type.scope.title().toText()),
                          StyledTag.sm(isEnabled: !hasStarted, child: type.searchType.title().toText()),
                        ],
                      ),
                    ),
                    isEnabled: !hasStarted,
                    onPressed: hasStarted
                        ? null
                        : () async {
                            final newPlan = await context.push(BiblePlanPage(planType: type));
                            if (newPlan != null && context.mounted) {
                              context.pop(newPlan);
                            }
                          },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
