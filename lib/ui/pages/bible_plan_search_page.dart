import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/bible_plan_page.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class BiblePlanSearchPage extends ConsumerWidget {
  const BiblePlanSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final planByType = ref.watch(biblePlansProvider);

    return StyledPage(
      title: 'Find Plans'.toText(),
      body: StyledListView(
        padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
        children: planByType
            .mapToIterable(
              (type, plan) => StyledListItem.navigation(
                title: SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    spacing: 8,
                    children: [
                      plan.name.toText(),
                      if (user.hasStartedPlan(type))
                        StyledTag.sm(leading: Symbols.check.toIcon(), child: 'Following'.toText()),
                    ],
                  ),
                ),
                subtitle: plan.description.toText(),
                thirdLine: '${plan.dayCount} days'.toText(),
                onPressed: () async {
                  final newPlan = await context.push(BiblePlanPage(planType: type));
                  if (newPlan != null && context.mounted) {
                    context.pop();
                  }
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
