import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/hydrated_bible_plan_progress.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class BiblePlanPaceSheet {
  static Future<BiblePlanPace?> showStart(BuildContext context, {required String planName, required int dayCount}) =>
      show(
        context,
        title: t.biblePlans.choosePace,
        planName: planName,
        initialPace: BiblePlanPace.relaxed(),
        naturalEndDate: BiblePlanPace.getNaturalEndDate(dayCount: dayCount),
        confirmLabel: t.biblePlans.startPlan,
      );

  static Future<BiblePlanPace?> showEdit(
    BuildContext context, {
    required String title,
    required HydratedBiblePlanProgress progress,
    required BiblePlanPace initialPace,
  }) => show(
    context,
    title: title,
    planName: progress.plan.getDisplayName(progress.id),
    initialPace: initialPace,
    naturalEndDate: progress.naturalEndDate,
    confirmLabel: t.common.save,
  );

  static Future<BiblePlanPace?> show(
    BuildContext context, {
    required String title,
    required String planName,
    required BiblePlanPace initialPace,
    required DateTime naturalEndDate,
    required String confirmLabel,
  }) => context.showStyledSheet((context, _) {
    final typeState = useState(initialPace.type);

    final endDateState = useState(initialPace.endDate ?? naturalEndDate);
    final firstEndDate = [DateTime.now().withoutTime(), ?initialPace.endDate].min;

    return StyledSheet(
      title: title.toText(),
      subtitle: planName.toText(),
      children: [
        ...BiblePlanPaceType.values.map(
          (type) => StyledListItem.radio(
            title: type.title().toText(),
            subtitle: type.description().toText(),
            leading: type.icon.toIcon(),
            isSelected: type == typeState.value,
            onSelected: () => typeState.value = type,
            showDividerOverride: type == BiblePlanPaceType.values.last ? false : null,
          ),
        ),
        Padding(
          padding: .symmetric(horizontal: 16),
          child: StyledCalendar(
            value: endDateState.value,
            firstDate: firstEndDate,
            lastDate: [endDateState.value, firstEndDate.addDays(730)].max,
            onChanged: (endDate) => endDateState.value = endDate,
            isEnabled: typeState.value == .paced,
          ),
        ),
      ],
      buttonsBuilder: (context) => [
        StyledRectButton.primary(
          label: confirmLabel.toText(),
          onPressed: () => context.pop(BiblePlanPace.fromType(typeState.value, endDate: endDateState.value)),
        ),
        StyledRectButton.transparent(label: t.common.cancel.toText(), onPressed: () => context.pop()),
      ],
    );
  });
}
