import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/text_style_extensions.dart';
import 'package:style/src/widgets/styled_circle_button.dart';
import 'package:style/src/widgets/styled_material.dart';
import 'package:utils_core/utils_core.dart';

class StyledCalendar extends HookWidget {
  static final weekHeight = 44.0;

  final DateTime value;
  final DateTime firstDate;
  final DateTime lastDate;

  final Function(DateTime) onChanged;

  final bool isEnabled;

  const StyledCalendar({
    super.key,
    required this.value,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final firstMonth = DateTime(firstDate.year, firstDate.month);
    final monthCount = firstMonth.getMonthsUntil(lastDate) + 1;

    final initialMonthIndex = firstMonth.getMonthsUntil(value);
    final pageController = usePageController(initialPage: initialMonthIndex);
    final monthIndexState = useState(initialMonthIndex);
    final monthIndex = monthIndexState.value;

    final today = DateTime.now().withoutTime();
    final weekdays = Weekday.localizedOrder;

    DateTime getMonth(int index) => DateTime(firstMonth.year, firstMonth.month + index);

    Widget buildDay(DateTime date) {
      final text = Center(child: Text(date.day.toString()));
      final isSelectable = isEnabled && !date.isBefore(firstDate) && !date.isAfter(lastDate);

      return SizedBox.square(
        dimension: 40,
        child: isSelectable || date == value
            ? StyledMaterial(
                colorBuilder: date == value ? .surfacePrimaryInverted : .transparent,
                isSelected: isSelectable && date == today && date != value ? false : null,
                isEnabled: isSelectable,
                borderRadius: .circular(999),
                onPressed: isSelectable ? () => onChanged(date) : null,
                child: text,
              )
            : DefaultTextStyle(style: context.textStyle.labelLg.disabled(), child: text),
      );
    }

    Widget buildMonth(DateTime month) {
      final leadingBlankCount = (Weekday.fromDateTime(month).index - weekdays.first.index) % 7;
      final dates = [
        ...List<DateTime?>.filled(leadingBlankCount, null),
        ...Range.generate(1, DateTime(month.year, month.month + 1, 0).day).map((day) => month.addDays(day - 1)),
      ];

      return Column(
        children: dates
            .slices(7)
            .map(
              (week) => Row(
                children: [...week, ...List.filled(7 - week.length, null)]
                    .map(
                      (date) => Expanded(
                        child: SizedBox(
                          height: weekHeight,
                          child: Center(child: date?.mapIfNonNull((date) => buildDay(date))),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      );
    }

    return Column(
      mainAxisSize: .min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                getMonth(monthIndex).formatMonthAndYear(),
                style: context.textStyle.headingXxs.disabled(isDisabled: !isEnabled),
              ),
            ),
            StyledCircleButton.md(
              child: Symbols.chevron_left.toIcon(),
              onPressed: isEnabled && monthIndex > 0
                  ? () =>
                        pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic)
                  : null,
            ),
            StyledCircleButton.md(
              child: Symbols.chevron_right.toIcon(),
              onPressed: isEnabled && monthIndex < monthCount - 1
                  ? () => pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic)
                  : null,
            ),
          ],
        ),
        Padding(
          padding: .symmetric(vertical: 8),
          child: Row(
            children: weekdays
                .map(
                  (weekday) => Expanded(
                    child: Text(
                      weekday.formatShort(),
                      textAlign: .center,
                      style: context.textStyle.labelSm.subtleTertiary().disabled(isDisabled: !isEnabled),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        // Fits the six weeks a month can span, so the height stays fixed while swiping.
        SizedBox(
          height: weekHeight * 6,
          child: PageView.builder(
            controller: pageController,
            physics: isEnabled ? null : NeverScrollableScrollPhysics(),
            itemCount: monthCount,
            onPageChanged: (index) => monthIndexState.value = index,
            itemBuilder: (context, index) => Align(alignment: .topCenter, child: buildMonth(getMonth(index))),
          ),
        ),
      ],
    );
  }
}
